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

...

