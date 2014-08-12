---
# Salt State file for: installing demo package:
# Author: vernon on Aug/12/14
include:
  - python
  - users
  - postgres

dev-track-repo:
  git.latest:
    - name: https://github.com/eHealthAfrica/dev-track.git
    - rev: master
    - always_fetch: True
    - target: /opt/dev-track
    - user: www-data
    - group: staff
  file.directory:
    - name: /opt/dev-track
    - user: www-data
    - group: staff
    - dir_mode: 775
    - file_mode: 664

/opt/Envs/dev-track:
  file.directory:
    - user: www-data
    - group: staff
    - dir_mode: 775
    - require:
      - user: www-data
  virtualenv.managed:
    - system_site_packages: True
    - requirements: /opt/dev-track/requirements.txt
    - require:
      - pkg: python-virtualenv
      - pkg: python-pip
      - pkg: psycopg2

psycopg2:
  pkg:
    - name: python-psycopg2
    - installed

/opt/dev-track/demo/salt_settings.py:
  file.managed:
    - source: salt://demo-app/dev-track.settings.py
    - template: jinja
    - user: www-data
    - group: staff
    - mode: 440  # this file contains our confidential codes.
    - require:
      - file: dev-track-repo

/opt/dev-track/manage.py:
  file.managed:
    - mode: 775
    - source: salt://demo-app/manage.py
    - template: jinja
    - user: www-data
    - group: staff

/opt/dev-track/demo/wsgi.py:
  file.managed:
    - mode: 775
    - source: salt://demo-app/wsgi.py
    - template: jinja
    - user: www-data
    - group: staff

/opt/Envs/dev-track/.project:
  file.managed:
    - contents: "/opt/dev-track\n"
    - user: www-data
    - gropu: staff
    - require:
      - file: /opt/Envs/dev-track

/var/log/dev-track:
  file.directory:
  - user: www-data
  - group: staff
  - file_mode: 660
  - dir_mode: 770
  - require:
    - user: www-data

...
