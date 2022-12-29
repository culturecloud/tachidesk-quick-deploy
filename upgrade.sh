#!/bin/sh

if [ -f server.jar ]; then
    if [ ! -f server.jar.backup ]; then
        mv server.jar server.jar.backup
    else
        rm server.jar
    fi
fi

curl -L $(curl -s https://api.github.com/repos/suwayomi/tachidesk-server-preview/releases/latest | jq -r '.assets[9] | .browser_download_url') -o server.jar
