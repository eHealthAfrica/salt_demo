---
# Salt Pillar file for: dev-track-demo settings
# Author: vernon on 8/7/14 
## /srv/pillar/demo_settings.sls

# data for demo-app  server
dbengine: django.db.backends.postgresql_psycopg2
dbname: dev-track-demo
dbuser: demo-user
dbpassword: password2
dbhost: localhost
dbport: 5432

secret_key: ThisIsAVeryPoorSecretKey

django_settings_module: demo.salt_settings

demo_app_socket: '/tmp/demo_app.sock'

demo_max_uwsgi_processes: 2
...
