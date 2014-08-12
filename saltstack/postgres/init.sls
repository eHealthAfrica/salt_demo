---
# Salt State file for: install postgres
# Author: vernon on 7/18/14 
postgresql:
  pkg:
    - name: postgresql-9.3
    - installed
  service.running:
    - enable: True
    - watch:
      - file: /etc/postgresql/9.3/main/pg_hba.conf

pg_hba.conf:
  file.append:
    - name: /etc/postgresql/9.3/main/pg_hba.conf
    - source: salt://postgres/pg_hba.conf
    - template: jinja
    - require:
      - pkg: postgresql-9.3

db_user:
  postgres_user.present:
    - name: {{ pillar['dbuser'] }}
    - password: {{ pillar['dbpassword'] }}
    - user: postgres
    - createdb: True
    - require:
      - service: postgresql

djangodb:
  postgres_database.present:
    - name: {{ pillar['dbname'] }}
    - encoding: UTF8
    - lc_ctype: en_GB.UTF8
    - lc_collate: en_GB.UTF8
    - template: template0
    - owner: {{ pillar['dbuser'] }}
    - user: postgres
    - require:
      - postgres_user: db_user
...

