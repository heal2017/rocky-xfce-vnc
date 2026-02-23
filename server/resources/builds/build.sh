#!/usr/bin/env bash
set -Eeuo pipefail

# locale
# localedef -c -f UTF-8 -i zh_CN zh_CN.UTF-8

if [ -e /etc/localtime ]; then
    rm -f /etc/localtime
fi
ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

# vim
tee -a /etc/vimrc <<- 'EOF'
set ts=4
set so=5
set cul
set nu
set expandtab
EOF

# limits.conf
tee -a /etc/security/limits.conf <<- 'EOF'
*   soft    nproc       unlimited
*   hard    nproc       unlimited
*   soft    nofile      65536
*   hard    nofile      65536
EOF

# 20-nproc.conf
if [ -f /etc/security/limits.d/20-nproc.conf ]; then
    sed -i '/nproc/d' /etc/security/limits.d/20-nproc.conf
fi
tee -a /etc/security/limits.d/20-nproc.conf <<- 'EOF'
*          soft    nproc     unlimited
*          hard    nproc     unlimited
root       soft    nproc     unlimited
root       hard    nproc     unlimited
EOF

