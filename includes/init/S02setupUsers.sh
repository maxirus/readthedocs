#!/bin/bash

# Description:
# 	This script sets up the user accounts that
#	are required.

addgroup rtd || exit $?

id rtd > /dev/null 2>&1
if [ $? -ne 0 ]; then
  adduser -D -G rtd -h /home/rtd -s /sbin/nologin rtd || exit $?
else
  echo "[WARN] User rtd already setup ..."
fi

exit 0
