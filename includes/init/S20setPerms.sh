#!/bin/bash

# Check for custom settings
CUSTOM_SETTINGS_DIR="/tmp/rtd-settings"
if [ -d "${CUSTOM_SETTINGS_DIR}" ]; then
    echo "[INFO] Found custom settings in ${CUSTOM_SETTINGS_DIR}"
    /bin/cp ${CUSTOM_SETTINGS_DIR}/* ${RTD_HOME}/readthedocs/settings
else
    echo "[WARN] No Custom settings found in ${CUSTOM_SETTINGS_DIR}"
fi

# Set Permissions
/bin/chown -R rtd:rtd /opt/rtd
/bin/chmod u=rw,g=rw,o= ${RTD_HOME}/readthedocs/settings/*

