---
# Salt Pillar file for: demo-app-demo settings
# Author: vernon on 8/7/14 
## /srv/pillar/demo-app_settings.sls

# data for demo-app  server
demo-app_dbengine: django.db.backends.postgresql_psycopg2
demo-app_dbname: demo-app-demo
demo-app_dbuser: demo-user
demo-app_dbpassword: password2
demo-app_dbhost: localhost
demo-app_dbport: 5432

...
