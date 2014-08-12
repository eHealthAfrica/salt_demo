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

new-default:
  file.managed:
    - name: /etc/nginx/sites-available/demo-default
    - source: salt://nginx/demo-default.conf

enable_demo_default:
  cmd:
    - run
    - name: ln -s /etc/nginx/sites-available/demo-default /etc/nginx/sites-enabled/demo-default
    - unless: test -L /etc/nginx/sites-enabled/demo-default
    - require:
      - file: /etc/nginx/sites-available/demo-default
