#!/usr/bin/env bash
set -Eeuo pipefail

# root scripts
echo "root" | su root -c " \
    rm -f /tmp/.X11-unix/X0 && \
    rm -f /tmp/.X0-lock && \
    hostname ${HOSTNAME} && \
    . ${RES_PATH}/scripts/define.sh && \
    . ${RES_PATH}/builds/create_user.sh && \
    . ${RES_PATH}/scripts/info.sh \
"

# user scripts
echo "${PASSWORD}" | su ${USERNAME} -c " \
    ${RES_PATH}/scripts/start_vnc.sh && \
    ${RES_PATH}/scripts/start_novnc.sh
"

while true; do
    sleep 1
done

