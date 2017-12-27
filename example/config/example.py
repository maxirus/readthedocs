#!/bin/python

"""Environment settings"""
from __future__ import absolute_import
import os, sys, re
from subprocess import CalledProcessError, check_output

from .base import CommunityBaseSettings


class CommunityExampleSettings(CommunityBaseSettings):

    """Settings for this environment"""

    ## General Config ##
    SECRET_KEY = 'mySup3rS3cr3tK3y'
    
    DEBUG = True
    TEMPLATE_DEBUG = DEBUG
    TASTYPIE_FULL_DEBUG = DEBUG

    ALLOW_PRIVATE_REPOS = True

    ADMINS = (
        ('YourName Here', 'your.name@example.com')
    )

    
    ## Web Server Endpoints ##
    PRODUCTION_DOMAIN = 'localhost:8000'
    WEBSOCKET_HOST = 'webserver:8088'
    SLUMBER_API_HOST = 'http://webserver:8000'
    PUBLIC_API_URL = 'http://webserver:8000'

    ## Celery ##
    REDIS = {
        'host': 'redis',
        'port': 6379,
        'db': 0,
    }
    BROKER_URL = 'redis://{0}:{1}/{2}'.format(REDIS['host'], REDIS['port'], REDIS['db'])
    CELERY_RESULT_BACKEND = 'redis://{0}:{1}/{2}'.format(REDIS['host'], REDIS['port'], REDIS['db'])
    CELERY_ALWAYS_EAGER = False
    

    ## Email Settings ##
    # Use this backend to send emails to console
    EMAIL_BACKEND = 'django.core.mail.backends.console.EmailBackend'
    # Use this backend to send emails using SMTP
    # EMAIL_BACKEND = 'django.core.mail.backends.smtp.EmailBackend'
    DEFAULT_FROM_EMAIL = "no-reply@readthedocs.example.com"
    SERVER_EMAIL = DEFAULT_FROM_EMAIL
    EMAIL_HOST = 'smtp.example.com'
    EMAIL_PORT = '25'
    EMAIL_HOST_USER = 'example_user'
    EMAIL_HOST_PASSWORD = 'example_password'
    EMAIL_USE_TLS = False

    # TODO: Change this
    @property
    def DATABASES(self):  # noqa
        return {
            'default': {
                'ENGINE': 'django.db.backends.postgresql_psycopg2',
                'NAME': 'rtd',
                'USER': 'admin',
                'PASSWORD': 'admin',
                'HOST': 'postgresql',
                'PORT': 5432
            }
        }

    DONT_HIT_DB = False

    SESSION_COOKIE_DOMAIN = None
    CACHE_BACKEND = 'dummy://'

    SLUMBER_USERNAME = 'slumber_user'
    SLUMBER_PASSWORD = os.getenv("SLUMBER_USER_PASSWORD")  # noqa: ignore dodgy check

    HAYSTACK_CONNECTIONS = {
        'default': {
            'ENGINE': 'haystack.backends.simple_backend.SimpleEngine',
        },
    }

    # Elasticsearch settings.
    ES_HOSTS = ['elasticsearch:9200']

    FILE_SYNCER = 'readthedocs.builds.syncers.LocalSyncer'
    #SYNC_USER = 'rtd'
    #MULTIPLE_APP_SERVERS = [ 'webserver' ]


    # For testing locally. Put this in your /etc/hosts:
    # 127.0.0.1 test
    # and navigate to http://test:8000
    CORS_ORIGIN_WHITELIST = (
        'test:8000',
    )


CommunityExampleSettings.load_settings(__name__)
