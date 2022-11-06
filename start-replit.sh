#!/bin/sh

if [ -f server.jar ]; then
    rm server.jar
fi

curl -L $(curl -s https://api.github.com/repos/suwayomi/tachidesk-server-preview/releases/latest | jq -r '.assets[9] | .browser_download_url') -o server.jar && \
java -Dsuwayomi.tachidesk.config.server.rootDir='/home/runner/tachidesk' -jar server.jar
