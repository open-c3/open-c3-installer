#!/bin/bash

set -euo pipefail

NAME=$1

if [ -z "$NAME" ]; then
    echo "[ERROR] Missing parameter: NAME"
    exit 1
fi

PACKAGE="/data/open-c3-installer/data/$NAME.tar.gz"
REMOTE_DIR="/data/open-c3-installer/data/"
IP_LIST_FILE="/data/open-c3-installer/sync.txt"

if [ ! -f "$PACKAGE" ]; then
    echo "[ERROR] Package file not found: $PACKAGE"
    exit 1
fi

if [ ! -f "$IP_LIST_FILE" ]; then
    echo "[ERROR] IP list file not found: $IP_LIST_FILE"
    exit 1
fi

while IFS= read -r IP; do
    [ -z "$IP" ] && continue

    echo "=== Syncing $PACKAGE to $IP ==="

    scp "$PACKAGE" "$IP:$REMOTE_DIR"

    echo "=== Done syncing to $IP ==="
done < "$IP_LIST_FILE"

