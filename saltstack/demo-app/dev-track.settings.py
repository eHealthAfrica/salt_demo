{{ pillar['salt_managed'] }}

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
    ('Vernon Cole', 'vernon.cole@ehealthafrica.org'),
)

DATABASES = {
        'default': {
                    'ENGINE': '{{ pillar["dbengine"] }}',
                    'NAME': '{{ pillar["dbname"] }}',
                    'USER': '{{ pillar["dbuser"] }}',
                    'PASSWORD': '{{ pillar["dbpassword"] }}',
                    'HOST': '{{ pillar["dbhost"] }}',
                    'PORT': '{{ pillar["dbport"] }}',
                }
}

SECRET_KEY = '{{ pillar["secret_key"] }}'
