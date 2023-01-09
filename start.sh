#!/bin/sh

if [ ! -f server.jar ]
then
    curl -L $(curl -s https://api.github.com/repos/suwayomi/tachidesk-server-preview/releases/latest | jq -r '.assets[9] | .browser_download_url') -o server.jar
fi

if [ -v "REPL_SLUG" ]
then
    java -Dsuwayomi.tachidesk.config.server.rootDir=/home/runner/${REPL_SLUG} -jar server.jar
else
    java -Dsuwayomi.tachidesk.config.server.rootDir=/home/suwayomi -jar server.jar
fi
