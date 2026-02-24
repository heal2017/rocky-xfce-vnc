#!/usr/bin/env bash
set -Eeuo pipefail
. ${RES_PATH}/scripts/define.sh

if [ ${ENABLE_NOVNC} == "true" ]; then
    ${NOVNC_PATH}/utils/novnc_proxy --vnc localhost:5900 --listen ${NOVNC_PORT} &> /dev/null &
    if [ ${USE_VNC_PASSWORD} == "true" ]; then
        information "no_vnc:    http://localhost:${NOVNC_PORT}/?password=${VNC_PASSWORD}"
    else
        information "no_vnc:    http://localhost:${NOVNC_PORT}"
    fi
fi

