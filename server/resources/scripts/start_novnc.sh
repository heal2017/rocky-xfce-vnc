#!/usr/bin/env bash
set -Eeuo pipefail
. ${RES_PATH}/scripts/define.sh

${NOVNC_PATH}/utils/novnc_proxy --vnc localhost:5900 --listen ${NOVNC_PORT}

