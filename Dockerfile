FROM alpine:latest

RUN apk --update add curl jq openjdk8-jre-base tzdata

RUN addgroup -g 1000 -S suwayomi && adduser -u 1000 -S suwayomi -G suwayomi

RUN mkdir -p /home/suwayomi && chown -R suwayomi:suwayomi /home/suwayomi

USER suwayomi

WORKDIR /home/suwayomi

COPY . .

EXPOSE 4567

CMD ["/bin/sh", "start-docker.sh"]