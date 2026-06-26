#!/usr/bin/env bash
set -euo pipefail

# Backup to remote server

# Prevent multiple executions of the backup.
lock_file="/tmp/remote-backup.lock"

exec 9>"$lock_file"
if ! flock -n 9; then
  echo "Another remote backup is already running; exiting."
  exit 0
fi

# -n dry run
# -c use checksum - only uses file size and modified date by default
# -v verbose
# --partial
# --append-verify
# --size-only - don't compare file times
# --delete - delete files that don't exist (files that have been deleted on the source)

# Use this when the entire drive is finally copied over.
# rsync -ahv --delete --partial --append-verify --info=progress2 --stats /path/to/src/ user@server:/path/to/dest

# Use this until there is a full backup so that we don't waste all our time scanning files.
rsync -a --ignore-existing --partial --size-only /path/to/src/ user@server:/path/to/dest
