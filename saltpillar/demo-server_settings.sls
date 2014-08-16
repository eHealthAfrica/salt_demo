---
# Salt Pillar file for: demo-app-demo settings
# Author: vernon on 8/7/14 
## /srv/pillar/demo-server_settings.sls

secret_key: ThisIsAVeryPoorSecretKey

django_settings_module: demo.salt_settings

demo-server_socket: '/tmp/demo-server.sock'

demo_max_uwsgi_processes: 2

# Internationalization
# https://docs.djangoproject.com/en/1.6/topics/i18n/
LANGUAGE_CODE: 'en-gb'

TIME_ZONE: 'UTC'
...
