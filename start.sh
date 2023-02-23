#!/bin/bash

BRANCH="${BRANCH:=stable}"

if [[ $BRANCH == "stable" ]]; then
  release_url="https://api.github.com/repos/suwayomi/tachidesk-server/releases/latest"
elif [[ $BRANCH == "preview" ]]; then
  release_url="https://api.github.com/repos/suwayomi/tachidesk-server-preview/releases/latest"
else
  echo -e "\033[1;31mERROR! Invalid value of BRANCH environment variable. Exiting...\033[0m"
  exit 1
fi

download_url=$(curl -sL $release_url | grep -o -E "https://.*\.jar")
latest_version=$(echo $download_url | grep -o -E "v[0-9]+\.[0-9]+\.[0-9]+-r[0-9]+" | head -n 1)
version_file="version.json"

if [ -f $version_file ]; then
  current_version=$(cat $version_file | jq -r .latest)
else
  current_version=""
fi

if [[ $current_version != $latest_version || ! -f "server.jar" ]]; then
  echo -e "\033[1;33mNew version ($latest_version) of Tachidesk Server available! Downloading...\033[0m"
  curl -sL $download_url -o server.jar || echo -e "\033[1;31mERROR! Could not download the latest version of Tachidesk Server! Please check if the releases URL is valid or not.\033[0m"
  echo "{\"branch\": \"$BRANCH\", \"latest\": \"$latest_version\"}" >$version_file
else
  echo -e "\033[1;33mAlready using the latest version ($current_version) of Tachidesk Server!\033[0m"
fi

mkdir -p $XDG_CONFIG_HOME/rclone/

if [[ -n $RCLONE_CONF ]]; then
  echo -e "\033[1;33mDownloading Rclone configuration file...\033[0m"
  curl -sL $RCLONE_CONF -o $XDG_CONFIG_HOME/rclone/rclone.conf || echo -e "\033[1;31mERROR! Could not download Rclone configuration file! Please check if the URL is valid or not.\033[0m"
else
  rm -rf $XDG_CONFIG_HOME/rclone/
fi

if [[ ! -f $XDG_CONFIG_HOME/rclone/rclone.conf ]]; then
  echo -e "\033[1;33mWARNING! Backup remote is not configured, your data won't be saved. Follow the project README for more information.\033[0m"
else
  echo -e "\033[1;33mDownloading previously backed up data...\033[0m"
  rclone --progress copy hbackup: hlocal:
fi

goreman -set-ports=false \
  -logtime=false \
  -exit-on-stop \
  start
