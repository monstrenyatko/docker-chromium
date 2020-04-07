FROM alpine:3

LABEL maintainer="Oleg Kovalenko <monstrenyatko@gmail.com>"

RUN sed -i -e 's/v[[:digit:]]\..*\//edge\//g' /etc/apk/repositories && \
    # upgrade to edge
    apk update && apk upgrade && \
    echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing/" >> /etc/apk/repositories && \
    apk add --no-cache bash shadow supervisor fluxbox x11vnc xvfb novnc ttf-freefont chromium && \
    # open novnc by default
    ln -s /usr/share/novnc/vnc.html /usr/share/novnc/index.html && \
    # clean-up
    rm -rf /root/.cache && mkdir -p /root/.cache && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /var/cache/distfiles/*

# replace favicon
COPY icon.svg /usr/share/novnc/app/images/icons/novnc-icon-sm.svg
COPY icon.svg /usr/share/novnc/app/images/icons/novnc-icon.svg
RUN buildDeps='make imagemagick';SHELL=/bin/bash; \
    # novnc makefile syntax requires bash => make bash temporary the default shell
    mv /bin/sh /bin/sh.bkp && \
    ln -s /bin/bash /bin/sh && \
    apk update && \
    apk add $buildDeps && \
    cd /usr/share/novnc/app/images/icons/ && \
    make && \
    rm /bin/sh && \
    mv /bin/sh.bkp /bin/sh && \
    # clean-up
    apk del $buildDeps && \
    rm -rf /root/.cache && mkdir -p /root/.cache && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /var/cache/distfiles/*

ENV SYS_USERNAME="daemon" \
    SYS_GROUPNAME="daemon" \
    APP_USERNAME="chromium" \
    APP_GROUPNAME="chromium" \
    APP_USERHOME="/data"
RUN addgroup $APP_GROUPNAME && \
    adduser -D -h $APP_USERHOME -G $APP_GROUPNAME $APP_USERNAME

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=C.UTF-8 \
    LOG_LEVEL=info \
    DISPLAY=:0.0 \
    DISPLAY_WIDTH=1024 \
    DISPLAY_HEIGHT=768 \
    WEBSOCKIFY_PARAMS= \
    CHROMIUM_PARAMS= \
    XDG_CONFIG_HOME=/data/config \
    XDG_CACHE_HOME=/data/cache

COPY conf.d /app/conf.d
COPY run.sh supervisord.conf /app/

VOLUME ["/data"]

CMD ["/app/run.sh"]
