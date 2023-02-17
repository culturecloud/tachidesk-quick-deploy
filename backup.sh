#!/bin/bash

if [[ ! -f $XDG_CONFIG_HOME/rclone/rclone.conf ]]; then
  echo -e "\033[1;33mBackup remote is not configured! Stopping backup task...\033[0m"
  exit 0
fi

sleep 60

while [[ -f $XDG_CONFIG_HOME/rclone/rclone.conf ]]; do
  echo -e "\033[1;33mStarting backup task...\033[0m"
  rclone md5sum hlocal: >/dev/null
  rclone sync hlocal: hbackup: --exclude="{*.tmp,local/**,webUI/**}"
  rclone sync hbackup:local hlocal:local
  echo -e "\033[1;33mBackup complete!\033[0m"
  sleep ${BACKUP_FREQUENCY:=3600}
done
