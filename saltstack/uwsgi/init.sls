---
# Salt State file for: uWSGI
# Author: vernon on 8/14/14 
include:
    - nginx

uwsgi:
    pip.installed:
        - pkgs:
            uwsgi
        - require:
            - pkg: python-dev
            - pkg: python-pip

uwsgi-service:
    service.running:
        - enable: True
        - name: uwsgi
        - require:
          - file: /etc/init/uwsgi.conf

/etc/init/uwsgi.conf:
    file.managed:
        - source: salt://uwsgi/uwsgi.conf
        - require:
            - pip: uwsgi

/etc/uwsgi/uwsgi_params:
    file.managed:
      - makedirs: True
      - source: salt://uwsgi/uwsgi_params.original

/var/log/uwsgi:
    file:
        - directory
        - user: www-data
        - group: www-data
        - require:
            - pip: uwsgi
            - pkg: nginx

/var/log/uwsgi/emperor.log:
    file:
        - managed
        - user: www-data
        - group: www-data
        - require:
            - pip: uwsgi
            - pkg: nginx
...

