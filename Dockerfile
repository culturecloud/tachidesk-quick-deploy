FROM alpine:edge

ENV TZ="Asia/Dhaka" \
    DATA_DIR="/home/culturecloud/tachidesk" \
    XDG_CONFIG_HOME="/home/culturecloud/.config" \
    RCLONE_CONFIG_HBACKUP_TYPE="hasher" \
    RCLONE_CONFIG_HBACKUP_REMOTE="backup:tachidesk" \
    RCLONE_CONFIG_HBACKUP_HASHES="md5" \
    RCLONE_MEGA_HARD_DELETE="true" \
    RCLONE_UPDATE="true" \
    RCLONE_RETRIES="10" \
    RCLONE_USE_MMAP="true" \
    RCLONE_STATS_ONE_LINE="true"

RUN apk update && \
    apk upgrade --no-cache && \
    apk add --virtual venv wget && \
    echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" | tee -a /etc/apk/repositories && \
    echo "https://apk.bell-sw.com/main" | tee -a /etc/apk/repositories && \
    wget -P /etc/apk/keys/ https://apk.bell-sw.com/info@bell-sw.com-5fea454e.rsa.pub && \
    apk del venv && \
    apk add --no-cache \
        bash \
        bellsoft-java8-runtime \
        curl \
        goreman \
        jq \
        lz4 \
        rclone \
        tar \
        tini \
        tzdata && \
    apk cache clean --purge && \
    rm -rf /var/cache/apk/*

RUN addgroup -g 1000 -S culturecloud && \
    adduser -u 1000 -S culturecloud -G culturecloud && \
    mkdir -p /home/culturecloud && \
    chown -R culturecloud:culturecloud /home/culturecloud && \
    chmod 777 /home/culturecloud/**

WORKDIR /home/culturecloud

USER culturecloud

COPY --chown=culturecloud:culturecloud . .

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["bash", "start.sh"]
