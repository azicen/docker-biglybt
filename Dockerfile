FROM curlimages/curl:latest AS download

RUN mkdir -p /tmp/plugins && chmod -R 777 /tmp/plugins

ADD https://files.biglybt.com/plugins/xmwebui_1.0.9.zip /tmp/plugins/xmwebui.zip
RUN TRGUING_RELEASE=$( \
        curl -s https://github.com/jayzcoder/TrguiNG/releases | \
        grep -o '[^"]*' | \
        grep -m 1 '/jayzcoder/TrguiNG/releases/tag/' | \
        sed 's|/jayzcoder/TrguiNG/releases/tag/||' \
    ) && \
    curl -L -o /tmp/plugins/trguing.zip \
        "https://github.com/jayzcoder/TrguiNG/releases/download/${TRGUING_RELEASE}/${TRGUING_RELEASE}.zip"

FROM ghcr.io/linuxserver/webtop:ubuntu-xfce

RUN echo 'deb http://deb.debian.org/debian/ sid main contrib' >> /etc/apt/sources.list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 6ED0E7B82643E131
RUN rm /etc/apt/sources.list.d/*

#RUN sed -i 's@//.*archive.ubuntu.com@//mirrors.ustc.edu.cn@g' /etc/apt/sources.list
#RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list

RUN apt update && apt install -y --no-install-recommends \
        default-jre \
        biglybt \
        iputils-ping \
        unzip \
        fonts-noto-cjk && \
    apt autoremove -y && \
    apt autoclean -y && \
    apt clean

COPY ./root /
COPY --from=download /tmp/plugins /plugins
RUN unzip /plugins/trguing.zip -d /webui && rm /plugins/trguing.zip

RUN chmod 755 /config/.config/autostart
RUN chmod 644 /config/.config/autostart/biglybt.desktop
RUN chown abc:abc -R /config/.config/autostart

VOLUME /config/.biglybt

EXPOSE 9091
