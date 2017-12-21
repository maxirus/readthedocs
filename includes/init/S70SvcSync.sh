#!/bin/bash

# nmap adds 25MB - possibly find a better tool to do this
# This also causes errors in the python SimpleHTTPServer

if [ ! -z "${MV_SVC_PING}" ]; then
  echo "[INFO] Container has Service Synchronizer, ping=${MV_SVC_PING} ..."

  ##### Wait for the svc ping to be successful
  while [ true ]
    do
      SVC_PING_HOST=`echo $MV_SVC_PING | cut -d':' -f1`
      SVC_PING_PORT=`echo $MV_SVC_PING | cut -d':' -f2`

      /usr/bin/nmap -A ${SVC_PING_HOST} -p ${SVC_PING_PORT} --open | grep open
      if [[ $? -eq 0 ]]; then
        echo "[INFO] Service ping ... SUCCESSFUL"
        break
      fi

      echo "[INFO] Endpoint NOT Available, yet"
      sleep 30
    done
fi

exit 0
