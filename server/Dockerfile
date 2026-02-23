FROM rockylinux:9

LABEL maintainer="https://github.com/heal2017/rocky-xfce-vnc"

RUN \
    mkdir -p /etc/yum.repos.d/backup && \
    cp /etc/yum.repos.d/*repo /etc/yum.repos.d/backup && \
    sed -i -e 's|^mirrorlist=|# mirrorlist=|g' -e 's|^#baseurl=http://dl.rockylinux.org/$contentdir|baseurl=https://mirrors.aliyun.com/rockylinux|g' /etc/yum.repos.d/[Rr]ocky-*.repo && \
    yum install -y https://mirrors.aliyun.com/epel/epel-release-latest-9.noarch.rpm && \
    sed -i 's|^#baseurl=https://download.example/pub|baseurl=https://mirrors.aliyun.com|' /etc/yum.repos.d/epel* && \
    sed -i 's|^metalink|# metalink|' /etc/yum.repos.d/epel* && \
    rm /etc/yum.repos.d/epel-cisco*.repo && \
    yum clean all && \
    yum makecache && \
    yum group install "fonts" -y && \
    yum groupinstall "Xfce" -y && \
    yum install csh -y && \
    yum install zsh -y && \
    yum install procps-ng -y && \
    yum install gcc -y && \
    yum install net-tools -y && \
    yum install iftop -y && \
    yum install tcpdump -y && \
    yum install bind-utils -y && \
    yum install nmap-ncat -y && \
    yum install iproute -y && \
    yum install cronie -y && \
    yum install expect -y && \
    yum install telnet -y && \
    yum install unzip -y && \
    yum install git -y && \
    yum install vim -y && \
    yum install tree -y && \
    yum install tigervnc-server -y && \
    yum install tini -y && \
    yum remove upower -y && \
    rm /etc/xdg/autostart/xfce-polkit.desktop && \
    yum install chkconfig -y

RUN \
    yum install numpy -y && \
    yum install procps-ng -y

ENV RES_PATH="/resources"
ENV TMP_PATH="/tmp"
ENV LANG="en_US.UTF-8"

ENV USERNAME="john"
ENV PASSWORD="john"
ENV UID="1001"
ENV GID="1001"
ENV USERSHELL="/usr/bin/bash"
ENV ROOT_PASSWORD="root"

ENV USE_VNC_PASSWORD="false"
ENV VNC_PASSWORD="password"
ENV GEOMETRY="1920x1080"

ENV NOVNC_PATH="/opt/no_vnc"
ENV NOVNC_PORT="6900"

COPY --chmod=755 ./resources ${RES_PATH}

RUN \
    . ${RES_PATH}/scripts/define.sh && \
    . ${RES_PATH}/builds/create_user.sh && \
    . ${RES_PATH}/builds/build.sh

USER ${USERNAME}
WORKDIR ~

EXPOSE 5900 6900

CMD ["/usr/bin/tini", "-s", "/resources/entrypoint.sh"]

