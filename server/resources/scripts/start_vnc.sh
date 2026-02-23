#!/usr/bin/env bash
set -Eeuo pipefail
. ${RES_PATH}/scripts/define.sh

# vnc server
mkdir -p ~/.vnc
cat <<- 'EOF' > ~/.vnc/xstartup
#!/bin/sh
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus

unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS
/etc/X11/xinit/xinitrc

exec startxfce4
EOF

chmod a+x ~/.vnc/xstartup

if [ ${USE_VNC_PASSWORD} == "true" ]; then
    echo "${VNC_PASSWORD}" | vncpasswd -f > ~/.vnc/passwd
    { vncserver :0 -geometry ${GEOMETRY} -rfbport 5900 -rfbauth ~/.vnc/passwd &> /dev/null; rc=$?; } || :
    if [ "$rc" == "0" ]; then
        success "vncserver: start ok (password: ${VNC_PASSWORD})"
    else
        failure "vncserver: start failed"
    fi
else
    { vncserver :0 -geometry ${GEOMETRY} -rfbport 5900 -SecurityTypes None &> /dev/null; rc=$?; } || :
    if [ "$rc" == "0" ]; then
        success "vncserver: start ok (no password)"
    else
        failure "vncserver: start failed"
    fi
fi
