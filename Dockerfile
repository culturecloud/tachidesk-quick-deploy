FROM alpine:edge

ENV TZ Asia/Dhaka \
    DATA_DIR /home/culturecloud/tachidesk \
    XDG_CONFIG_HOME /home/culturecloud/.config

ENV RCLONE_CONFIG_HBACKUP_TYPE hasher \
    RCLONE_CONFIG_HBACKUP_REMOTE backup: \
    RCLONE_CONFIG_HBACKUP_HASHES md5 \
    RCLONE_CONFIG_HLOCAL_TYPE hasher \
    RCLONE_CONFIG_HLOCAL_REMOTE ${DATA_DIR} \
    RCLONE_CONFIG_HLOCAL_HASHES md5 \
    RCLONE_MEGA_HARD_DELETE true \
    RCLONE_UPDATE true \
    RCLONE_RETRIES 10 \
    RCLONE_USE_MMAP true \
    RCLONE_STATS_ONE_LINE true
    
RUN apk update && \
    apk add --no-cache \
    openjdk8-jre-base \
    rclone \
    curl \
    bash \
    jq \
    tzdata && \
    apk add --no-cache \
    --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing/ \
    goreman && \
    rm /var/cache/apk/*

RUN addgroup -g 1000 -S culturecloud && \
    adduser -u 1000 -S culturecloud -G culturecloud

RUN mkdir -p /home/culturecloud && \
    chown -R culturecloud:culturecloud /home/culturecloud && \
    chmod 755 /home/culturecloud

WORKDIR /home/culturecloud

USER culturecloud

COPY . .

CMD ["bash", "start.sh"]