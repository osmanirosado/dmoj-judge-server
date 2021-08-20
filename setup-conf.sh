#!/usr/bin/env bash

cd "$(dirname "$0")" || exit 1

CONF_FILE='judges.conf'
if [[ ! -f "$CONF_FILE" ]]
then
    echo "[info] Creating the file $CONF_FILE."
    cat > "$CONF_FILE" <<EOF
JUDGE_NUMBER=3
JUDGE_NAME_PREFIX='main-judge-'

IMAGE_NAME=dmoj/judge-tier3
IMAGE_TAG=latest
BRIDGE_ADDRESS=10.12.101.21
PROBLEMS_DIR=/mnt/dmoj/problems
EOF
else
    echo "[warn] The file $CONF_FILE exits."
fi
