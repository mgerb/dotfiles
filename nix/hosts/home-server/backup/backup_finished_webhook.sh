# Grab the most recent line from the remote backup service and send it to the webhook.

# Sleep so that we can wait for the job logs to flush.
sleep 2

# NOTE: In user mode, this won't show data transfer.
line=$(
    journalctl --user -u remoteBackup.service -n 50 --no-pager \
    | tail -n 1 \
    | sed 's/"/\\"/g'
)

curl -X POST \
    -H "Content-Type: application/json" \
    -d "{\"line\":\"$line\"}" \
    <webhook url>
