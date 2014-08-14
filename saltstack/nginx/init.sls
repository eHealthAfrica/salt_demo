nginx:
  pkg:
    - installed
  service.running:
    - enable: True
    - watch:
      - file: new-default

default-nginx-out:    # remove the stock default file and replace with ours:
  file.absent:
    - name: /etc/nginx/sites-enabled/default

/var/log/nginx:
  file:
    - directory
    - owner: www-data
    - group: staff

new-default:
  file.managed:
    - makedirs: True
    - name: /etc/nginx/sites-available/demo-app-with-default
    - source: salt://nginx/demo-app-with-default.conf
    - template: jinja

enable_demo_default:
  cmd:
    - run
    - name: ln -s /etc/nginx/sites-available/demo-app-with-default /etc/nginx/sites-enabled/demo-app-with-default
    - unless: test -L /etc/nginx/sites-enabled/demo-app-with-default
    - require:
      - file: /etc/nginx/sites-available/demo-app-with-default
