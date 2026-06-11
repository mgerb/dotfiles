# Backup to remote server

# -n dry run
# -c use checksum - only uses file size and modified date by default
# -v verbose
# --partial
# --append-verify
rsync -achv --delete --partial --append-verify --info=progress2 --stats /path/to/src/ user@server:/path/to/dest;
