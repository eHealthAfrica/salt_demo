#{{ pillar['salt_managed'] }}

try:
    from .settings import *
except ImportError:
    import sys, django
    django.utils.six.reraise(RuntimeError, *sys.exc_info()[1:])  # use RuntimeError to extend the traceback
except:
    raise


DEBUG = True
TEMPLATE_DEBUG = DEBUG

ADMINS = (
    ("{{ pillar['administrator_name'] }}", "{{ pillar['administrator_email'] }}"),
)

DATABASES = {
        'default': {
                    'ENGINE': '{{ pillar["demo_app_dbengine"] }}',
                    'NAME': '{{ pillar["demo_app_dbname"] }}',
                    'USER': '{{ pillar["demo_app_dbuser"] }}',
                    'PASSWORD': '{{ pillar["demo_app_dbpassword"] }}',
                    'HOST': '{{ pillar["demo_app_dbhost"] }}',
                    'PORT': '{{ pillar["demo_app_dbport"] }}',
                }
}

STATIC_ROOT = '/srv/static/demo-app'
MEDIA_ROOT = '/var/media/demo-app'

SECRET_KEY = '{{ pillar["secret_key"] }}'
