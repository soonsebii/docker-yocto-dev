FROM ubuntu:14.04

# Mirror
ENV MIRROR_URL="http://ftp.daumkakao.com/ubuntu"

RUN sed -i "s^http://archive.ubuntu.com/ubuntu^${MIRROR_URL}^g" /etc/apt/sources.list \
&& apt-get -qq update \
&& DEBIAN_FRONTEND=noninteractive apt-get --yes --assume-yes install -y -qq \
    gawk wget git-core diffstat unzip texinfo gcc-multilib \
    build-essential chrpath socat libsdl1.2-dev xterm python3 \
&& wget http://commondatastorage.googleapis.com/git-repo-downloads/repo -O /bin/repo \
&& chmod a+x /bin/repo \
&& update-locale LANG=C.UTF-8 LC_MESSAGES=POSIX \
&& locale-gen en_US.UTF-8 \
&& DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales \
&& rm -rf /var/lib/apt/lists/*

