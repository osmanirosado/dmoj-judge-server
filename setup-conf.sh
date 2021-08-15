#!/usr/bin/env bash

CONF_FILE='init-judges.conf'
if [[ ! -f "$CONF_FILE" ]]
then
    echo "Creating the file $CONF_FILE"
    cat > "$CONF_FILE" <<EOF
JUDGE_NUMBER=3
JUDGE_NAME_PREFIX='main-judge-'

IMAGE_TAG=latest
BRIDGE_ADDRESS=10.12.101.21
PROBLEMS_DIR=/mnt/dmoj/problems
EOF
else
    echo "The file $CONF_FILE exits"
fi
