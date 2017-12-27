#!/bin/bash

ADMIN_USER_PASSWORD=${ADMIN_USER_PASSWORD:-admin}
SLUMBER_USER_PASSWORD=${SLUMBER_USER_PASSWORD:-slumber_pass}

if [[ ${RTD_CONTAINER_TYPE} == "webserver" ]]; then
    echo "Starting WebServer..."
    su rtd -s "/bin/sh" -c "cd ${RTD_HOME} && python manage.py runserver 0.0.0.0:8000"
elif [[ ${RTD_CONTAINER_TYPE} == "celery" ]]; then
    echo "Starting Celery..."
    su rtd -s "/bin/sh" -c "cd ${RTD_HOME} && celery worker -A readthedocs -Q default,celery,web,builder -l DEBUG -c 2"
elif [[ ${RTD_CONTAINER_TYPE} == "initdb" ]]; then
    echo "Initializing Database..."
    # TODO: Check if this causes any issues when the DB is already provisioned
    su rtd -s "/bin/sh" -c "cd ${RTD_HOME} && python manage.py migrate"

    echo "Creating Slumber User..."
    # TODO: Make this configurable via Docker Env var?
    cd ${RTD_HOME} && echo "from django.contrib.auth.models import User; User.objects.create_user('slumber_user', 'slumber@localhost', '${SLUMBER_USER_PASSWORD}', is_staff=True, is_active=True)" | python manage.py shell

    echo "Creating Admin User..."
    # TODO: Make this configurable via Docker Env var?
    cd ${RTD_HOME} && echo "from django.contrib.auth.models import User; User.objects.create_superuser('admin', 'admin@localhost', '${ADMIN_USER_PASSWORD}')" | python manage.py shell
    
    echo "Finished initializing database."
    echo " Sleeping..."
    sleep 2147483647
else
    # Setup DB
    su rtd -s "/bin/sh" -c "cd ${RTD_HOME} && python manage.py migrate"

    # Setup Base Users
    echo "Creating Admin..."
    cd ${RTD_HOME} && echo "from django.contrib.auth.models import User; User.objects.create_superuser('admin', 'admin@localhost', 'admin')" | python manage.py shell
    echo "Creating Slumber User..."
    cd ${RTD_HOME} && echo "from django.contrib.auth.models import User; User.objects.create_superuser('slumber_user', 'slumber@localhost', 'slumber_pass')" | python manage.py shell

    echo "Starting Celery..."
    su rtd -s "/bin/sh" -c "(cd ${RTD_HOME} && python manage.py celeryd -l DEBUG -Q celery,web > /tmp/celery.log 2>&1) &"
    echo "Starting WebServer..."
    su rtd -s "/bin/sh" -c "cd ${RTD_HOME} && python manage.py runserver 0.0.0.0:8000 > /tmp/webserver.log 2>&1"
fi
