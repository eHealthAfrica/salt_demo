---
# Salt Pillar file for: demo-app-demo settings
# Author: vernon on 8/7/14 
## /srv/pillar/demo_settings.sls

# data for demo-app  server
demo_app_dbengine: django.db.backends.postgresql_psycopg2
demo_app_dbname: demo-app-demo
demo_app_dbuser: demo-user
demo_app_dbpassword: password2
demo_app_dbhost: localhost
demo_app_dbport: 5432

secret_key: ThisIsAVeryPoorSecretKey

django_settings_module: demo.salt_settings

demo_app_socket: '/tmp/demo_app.sock'

demo_max_uwsgi_processes: 2
...
