#!/usr/bin/env bash

IMAGE_TAG=latest

cat > .env <<EOF
IMAGE_TAG=$IMAGE_TAG

EOF

ALIASES_FILE=bash_aliases
echo "" > $ALIASES_FILE

for i in {1..3}
do
    cat >>"$ALIASES_FILE" <<<"alias judge${i}dc='docker-compose --project-directory $PWD/judge${i} -f $PWD/docker-compose.yml'"

    NAME="judge$i"
    mkdir -p "$NAME"

    cat > "$NAME/.env" <<EOF
IMAGE_TAG=$IMAGE_TAG

BRIDGE_ADDRESS=10.12.101.21

JUDGE_NAME=main-judge-$i
JUDGE_KEY=

PROBLEMS_DIR=/mnt/dmoj/problems
EOF

done
