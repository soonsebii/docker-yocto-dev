FROM ubuntu:14.04

# Setup useful environment variables
ENV MIRROR_URL="http://ftp.daumkakao.com/ubuntu"

# Install packages for the Host Development System
RUN sed -i "s^http://archive.ubuntu.com/ubuntu^${MIRROR_URL}^g" /etc/apt/sources.list \
&& apt-get -qq update \
&& DEBIAN_FRONTEND=noninteractive apt-get --yes --assume-yes install -y -qq \
    gawk wget git-core diffstat unzip texinfo gcc-multilib \
    build-essential chrpath socat cpio python python3 python3-pip python3-pexpect \
    libsdl1.2-dev xterm \
&& wget http://commondatastorage.googleapis.com/git-repo-downloads/repo -O /bin/repo \
&& chmod a+x /bin/repo \
&& update-locale LANG=C.UTF-8 LC_MESSAGES=POSIX \
&& locale-gen en_US.UTF-8 \
&& DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales \
&& rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

ENTRYPOINT ["/sbin/entrypoint.sh"]
CMD ["-d"]
