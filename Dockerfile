FROM ubuntu:20.04

LABEL maintainer="joseph@pushcorn.com"

ARG TIMEZONE=America/Indiana/Indianapolis

ENV DEBIAN_FRONTEND=noninteractive

ONBUILD COPY Dockerfile root.build* root* /
ONBUILD COPY Dockerfile .qd* /root/.qd/
ONBUILD RUN rm /Dockerfile /root/.qd/Dockerfile

COPY Dockerfile root.build* root* /
COPY Dockerfile .qd* /root/.qd/

RUN rm /Dockerfile /root/.qd/Dockerfile \
    && apt-get update \
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
        tinysshd \
        tree \
        tzdata \
        ucspi-tcp \
        unzip \
        vim-tiny \
    && rm -rf /var/lib/apt/lists/* /etc/cron* \
    \
    && cd /usr/share/i18n \
        && find locales/ -type f ! -name en_US ! -name en_GB ! -name "translit*" ! -name C ! -name POSIX ! -name "i18n*" ! -name iso14651_t1_common ! -name iso14651_t1 -delete \
        && find charmaps/ -type f ! -name UTF-8.gz -delete \
        && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
        && locale-gen en_US.UTF-8 \
    \
    && cd /tmp \
        && ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime \
        && dpkg-reconfigure tzdata \
        && infocmp -I xterm > xterm \
        && sed -e 's/smcup[^,]*,\s*//' -e 's/rmcup[^,]*,\s*//' xterm > xterm.src \
        && tic xterm.src \
        && rm ./*

ENV QD_VERSION=2.4.8
ENV PATH=/root/.qd/bin:$PATH
ENV QD_MESSAGE_TS=true

RUN cd /root \
        && QD_URL=https://bitbucket.org/josephtzeng/quick-and-dirty/raw/$QD_VERSION \
        && mkdir -p .qd/bin .bashrc.d .bash_completion.d \
        && curl -sL $QD_URL/bin/qd -o .qd/bin/qd \
        && curl -sL $QD_URL/bin/qt -o .qd/bin/qt \
        && curl -sL $QD_URL/modules/bash/resources/bash_completion.d/qd -o .bash_completion.d/qd \
        && chmod u+x .qd/bin/* \
        && qd :install \
            --command copy \
            --command render \
            --command ubuntu:add-ppa-repo \
            --command ubuntu:begin-apt-install \
            --command ubuntu:end-apt-install \
            --module watchman \
        && qd watchman:install

WORKDIR /root

ENTRYPOINT ["qd"]

CMD [":shell"]
