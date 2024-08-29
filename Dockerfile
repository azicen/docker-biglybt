FROM curlimages/curl:latest AS download

RUN mkdir -p /tmp/plugins && chmod -R 755 /tmp/plugins && \
    TRGUING_RELEASE=$( \
        curl -s https://github.com/jayzcoder/TrguiNG/releases | \
        grep -o '[^"]*' | \
        grep -m 1 '/jayzcoder/TrguiNG/releases/tag/' | \
        sed 's|/jayzcoder/TrguiNG/releases/tag/||' \
    ) && \
    curl -L --retry 5 --retry-delay 5 --connect-timeout 30 \
        -o /tmp/plugins/trguing.zip \
        "https://github.com/jayzcoder/TrguiNG/releases/download/${TRGUING_RELEASE}/${TRGUING_RELEASE}.zip"

ADD https://files.biglybt.com/plugins/xmwebui_1.0.9.zip /tmp/plugins/xmwebui.zip


FROM ghcr.io/azicen/desktop:latest

ENV TITLE=BiglyBT \
    WEBUI_PORT=9091 \
    WEBUI_USER=admin \
    WEBUI_PASSWD=admin \
    WEBUI_DIR=/webui \
    CONFIG_DIR=/config/.biglybt

RUN pacman -Sy --noconfirm --needed \
        gtk3 \
        jre-openjdk \
        unzip && \
    exec s6-setuidgid abc \
        yay -Sy --noconfirm --needed \
            biglybt && \
    rm -rf \
        /tmp/* \
        /var/cache/pacman/pkg/* \
        /var/lib/pacman/sync/* \
        /config/.cache/yay/*

COPY /root /
COPY --from=download /tmp/plugins /defaults/biglybt/plugins
RUN unzip /defaults/biglybt/plugins/trguing.zip -d /webui && \
    rm /defaults/biglybt/plugins/trguing.zip

VOLUME /config/.biglybt

EXPOSE 9091
