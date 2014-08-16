#{{ pillar['salt_managed'] }}

try:
    from .settings import *
except ImportError:
    import sys, django
    django.utils.six.reraise(RuntimeError, *sys.exc_info()[1:])  # use RuntimeError to extend the traceback
except:
    raise

# noinspection PyUnresolvedReferences
LANGUAGE_CODE = "{{ salt['pillar.get']('LANGUAGE_CODE', 'en-us') }}"
# noinspection PyUnresolvedReferences
TIME_ZONE = "{{ salt['pillar.get']('TIME_ZONE',  'UTC') }}"

DEBUG = True
TEMPLATE_DEBUG = DEBUG



ADMINS = (
    ("{{ pillar['administrator_name'] }}", "{{ pillar['administrator_email'] }}"),
)

DATABASES = {
        'default': {
                    'ENGINE': '{{ pillar["demo-app_dbengine"] }}',
                    'NAME': '{{ pillar["demo-app_dbname"] }}',
                    'USER': '{{ pillar["demo-app_dbuser"] }}',
                    'PASSWORD': '{{ pillar["demo-app_dbpassword"] }}',
                    'HOST': '{{ pillar["demo-app_dbhost"] }}',
                    'PORT': '{{ pillar["demo-app_dbport"] }}',
                }
}

STATIC_ROOT = '/srv/static/demo-app'
MEDIA_ROOT = '/var/media/demo-app'

SECRET_KEY = '{{ pillar["secret_key"] }}'
