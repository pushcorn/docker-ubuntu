FROM ubuntu:20.04

LABEL maintainer="joseph@pushcorn.com"

RUN apt-get update \
    && apt-get -y install \
        bash-completion \
        curl \
        iproute2 \
        iputils-ping \
        jq \
        locales \
        netcat \
        rsync \
        silversearcher-ag \
        telnet \
        tree \
        unzip \
        vim-tiny \
    && rm -rf /var/lib/apt/lists/* \
    \
    && cd /usr/share/i18n \
        && find locales/ -type f ! -name en_US ! -name en_GB ! -name "translit*" ! -name C ! -name POSIX ! -name "i18n*" ! -name iso14651_t1_common ! -name iso14651_t1 -delete \
        && find charmaps/ -type f ! -name UTF-8.gz -delete \
        && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
        && locale-gen en_US.UTF-8 \
    \
    && cd /tmp \
        && infocmp -I xterm > xterm \
        && sed -e 's/smcup[^,]*,\s*//' -e 's/rmcup[^,]*,\s*//' xterm > xterm.src \
        && tic xterm.src \
        && rm ./* \
    \
    && cd /root \
        && QD_URL=https://bitbucket.org/josephtzeng/quick-and-dirty/raw/master \
        && mkdir -p .qd/bin .bashrc.d .bash_completion.d \
        && curl -sL $QD_URL/bin/qd -o .qd/bin/qd \
        && curl -sL $QD_URL/modules/bash/resources/bash_completion.d/qd -o .bash_completion.d/qd \
        && chmod u+x .qd/bin/qd

ENV PATH=/root/.qd/bin:$PATH
ENV QD_MESSAGE_TS=true

COPY root/ /

WORKDIR /root

CMD ["/bin/bash"]
