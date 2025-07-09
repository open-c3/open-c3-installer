#!/bin/bash

set -euo pipefail

NAME=$1

if [ -z "$NAME" ]; then
    echo "[ERROR] Missing parameter: NAME"
    exit 1
fi

BASE_DIR="/data/open-c3-installer"
PACKAGE="$BASE_DIR/data/$NAME.tar.gz"
SCRIPT="$BASE_DIR/test-run.sh"
REMOTE_PACKAGE="/data/open-c3-installer.tar.gz"
REMOTE_SCRIPT="/data/test-run.sh"
IP_LIST_FILE="$BASE_DIR/test.txt"

if [ ! -f "$PACKAGE" ]; then
    echo "[ERROR] Package file not found: $PACKAGE"
    exit 1
fi

if [ ! -f "$SCRIPT" ]; then
    echo "[ERROR] Script file not found: $SCRIPT"
    exit 1
fi

if [ ! -f "$IP_LIST_FILE" ]; then
    echo "[ERROR] IP list file not found: $IP_LIST_FILE"
    exit 1
fi

while IFS= read -r IP; do
    [ -z "$IP" ] && continue

    echo "=== Testing on $IP ==="

    scp "$PACKAGE" "$IP:$REMOTE_PACKAGE"
    scp "$SCRIPT" "$IP:$REMOTE_SCRIPT"
    ssh "$IP" "bash $REMOTE_SCRIPT"

    echo "=== Done with $IP ==="
done < "$IP_LIST_FILE"
