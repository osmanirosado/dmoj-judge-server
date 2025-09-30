#!/usr/bin/env bash

cd "$(dirname "$0")" || exit 1

CONF_FILE='judges.conf'
if [[ ! -f "$CONF_FILE" ]]
then
    echo "[info] Creating the file $CONF_FILE."
    cat > "$CONF_FILE" <<EOF
JUDGE_NUMBER=3
JUDGE_NAME_PREFIX=Arcadia-
PROJECT_NAME_PREFIX=arcadia

BASE_IMAGE=dmoj/judge-tier3:latest

IMAGE_NAME=local-judge-tier3
IMAGE_TAG_LATEST=latest
IMAGE_TAG_ACTIVE=active

BRIDGE_ADDRESS=

PROBLEMS_DIR=/var/opt/lib/dmoj/problems
EOF
else
    echo "[warn] The file $CONF_FILE exits."
fi
