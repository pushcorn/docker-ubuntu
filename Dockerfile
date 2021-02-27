FROM ubuntu:latest

LABEL maintainer="joseph@pushcorn.com"

RUN apt-get update && apt-get -y install \
    iproute2 \
    jq \
    locales \
    telnet \
    vim-tiny \
    wget \
    bash-completion \
    && rm -rf /var/lib/apt/lists/* \
    \
    && find /usr/share/i18n/locales/ -type f ! -name en_US ! -name en_GB ! -name "translit*" ! -name C ! -name POSIX ! -name "i18n*" ! -name iso14651_t1_common ! -name iso14651_t1 -delete \
    && find /usr/share/i18n/charmaps/ -type f ! -name UTF-8.gz -delete \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
    && locale-gen en_US.UTF-8 \
    \
    && cd /tmp \
    && infocmp -I xterm > xterm \
    && sed -e 's/smcup[^,]*,\s*//' -e 's/rmcup[^,]*,\s*//' xterm > xterm.src \
    && tic xterm.src \
    && rm xterm xterm.src

COPY root/ .

WORKDIR /root

CMD ["/bin/bash"]
