---
# Salt State file for: installing demo package:
# Author: vernon on Aug/12/14
include:
  - python
  - users
  - postgres

demo-app_db_user:
  postgres_user.present:
    - name: {{ pillar['demo-app_dbuser'] }}
    - password: {{ pillar['demo-app_dbpassword'] }}
    - user: postgres
    - createdb: True
    - require:
      - service: postgresql

demo-app_db:
  postgres_database.present:
    - name: {{ pillar['demo-app_dbname'] }}
    - encoding: UTF8
    - lc_ctype: en_GB.UTF8
    - lc_collate: en_GB.UTF8
    - template: template0
    - owner: {{ pillar['demo-app_dbuser'] }}
    - user: postgres
    - require:
      - postgres_user: demo-app_db_user

/opt:
  file.directory:
    - user: www-data
    - group: staff
    - dir_mode: 775

demo-app-repo:
  file.directory:
    - name: /opt/demo-app
    - makedirs: True
    - user: www-data
    - group: staff
    - dir_mode: 775
    - file_mode: 664
    - watch:
      - git: demo-app-repo
  git.latest:
    - name: https://github.com/eHealthAfrica/demo-app.git
    - rev: master
    - always_fetch: True
    - target: /opt/demo-app
    - user: www-data

/opt/demo-app:
  file.directory:
    - user: www-data
    - group: staff
    - dir_mode: 775
    - file_mode: 664
    - recurse:
      - group
      - mode
    - require:
      - file: demo-app-repo

/opt/Envs/demo-app:
  file.directory:
    - user: www-data
    - group: staff
    - dir_mode: 775
    - recurse:
      - user
      - group
    - require:
      - user: www-data
      - virtualenv: /opt/Envs/demo-app
  virtualenv.managed:
    - system_site_packages: True
    - requirements: /opt/demo-app/requirements.txt
    - require:
      - pkg: python-virtualenv
      - pkg: python-pip
      - pkg: psycopg2
      - file: demo-app-repo

psycopg2:
  pkg:
    - name: python-psycopg2
    - installed

/opt/demo-app/demo/salt_settings.py:
  file.managed:
    - source: salt://demo-app/demo-app.settings.py
    - template: jinja
    - user: www-data
    - group: staff
    - mode: 440  # this file contains our confidential codes.
    - require:
      - file: demo-app-repo

/opt/demo-app/manage.py:
  file.managed:
    - mode: 775
    - source: salt://demo-app/manage.py
    - template: jinja
    - user: www-data
    - group: staff

/opt/demo-app/demo/wsgi.py:
  file.managed:
    - mode: 775
    - source: salt://demo-app/wsgi.py
    - template: jinja
    - user: www-data
    - group: staff

/etc/uwsgi/vassals/demo-app-uwsgi.ini:
  file:
    - managed
    - makedirs: True
    - source: salt://demo-app/demo-app-uwsgi.ini
    - template: jinja

/opt/Envs/demo-app/.project:
  file.managed:
    - contents: "/opt/demo-app\n"
    - user: www-data
    - gropu: staff
    - require:
      - file: /opt/Envs/demo-app

/var/log/demo-app:
  file.directory:
  - user: www-data
  - group: staff
  - file_mode: 660
  - dir_mode: 770
  - require:
    - user: www-data

static_dir:
  file.directory:
    - name: /srv/static/demo-app
    - makedirs: True
    - user: www-data
    - group: staff
    - file_mode: 660
    - dir_mode: 770

collectstatic:  # don't forget to put the static files in place
  cmd.run:
    - name: '/opt/Envs/demo-app/bin/python /opt/demo-app/manage.py collectstatic --noinput'
    - user: www-data
    - require:
      - file: /opt/demo-app/manage.py
    - on_changes:
      - file: demo-app-repo

/var/media/demo-app:  # a place for django to store uploaded media
  file.directory:
  - makedirs: True
  - user: www-data
  - group: staff
  - file_mode: 660
  - dir_mode: 770

# this is a test file used to prove that the media directory actually works...
/var/media/demo-app/test.jpg:
  file.copy:
    - source: /opt/demo-app/sample_media/test.jpg
    - file_mode: 444

kick_uwsgi:
  file:
    - name: /etc/uwsgi/vassals/demo-app-uwsgi.ini
    - touch  # touch the file to trigger the emperor to restart uWSGI instances
    - order: last
    - on_changes:
      - file: demo-app-repo

kick_nginx:
  service:
    - name: nginx
    - running
    - order: last
    - on_changes:
      - file: demo-app-repo
...
