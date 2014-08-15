---
# Salt State file for: installing demo package:
# Author: vernon on Aug/12/14
include:
  - python
  - users
  - postgres

demo-app-repo:
  file.directory:
    - name: /opt/demo-app
    - makedirs: True
    - user: www-data
    - group: staff
    - dir_mode: 775
    - file_mode: 664
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
    #- touch  # touch the file to trigger the emperor to restart uWSGI instances
    #- order: last
    #- watch:
    #  - file: demo-app-repo

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

/srv/static/demo-app:
  file.directory:
  - makedirs: True
  - user: www-data
  - group: staff
  - file_mode: 660
  - dir_mode: 770

collectstatic:  # don't forget to put the static files in place
  cmd.run:
    - name: '/opt/Envs/demo-app/bin/python /opt/demo-app/manage.py collectstatic --noinput'
    - user: www-data
    - watch:
      - git: demo-app-repo
    - require:
      - file: /opt/demo-app/manage.py
      - file: /srv/static/demo-app

/var/media/demo-app:
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

...
