#!/usr/bin/env bash

cd "$(dirname "$0")" || exit 1

source load-judges-config.sh

FILE=".env"
echo "[info] Setting up the $FILE file"
cat > .env <<EOF
BASE_IMAGE=$BASE_IMAGE

IMAGE=$IMAGE_NAME:$IMAGE_TAG_LATEST

EOF

ALIASES_FILE=bash_aliases
echo "" > $ALIASES_FILE

for ((i = 1 ; i <= "$JUDGE_NUMBER" ; i++))
do
    BASE_DIR='dmoj'
    JUDGE_DIR="$BASE_DIR/judge$i"
    JUDGE_NAME="${JUDGE_NAME_PREFIX}$i"
    PROJECT_NAME="${PROJECT_NAME_PREFIX}$i"

    cat >>"$ALIASES_FILE" <<<"alias ${PROJECT_NAME}dc='sudo docker compose --project-directory $PWD/$JUDGE_DIR -f $PWD/$BASE_DIR/compose.yml'"

    mkdir -p "$JUDGE_DIR"

    FILE="$JUDGE_DIR/.key" && test ! -f "$FILE" && echo 'DMOJ_JUDGE_KEY=' > "$FILE"

    ln --force --symbolic --relative "$BASE_DIR/compose.yml" "$JUDGE_DIR/compose.yml"

    FILE="$JUDGE_DIR/.env"
    echo "[info] Setting up the $FILE file."
    cat > "$FILE" <<EOF
PROJECT_NAME=$PROJECT_NAME

IMAGE=$IMAGE_NAME:$IMAGE_TAG_ACTIVE

BRIDGE_ADDRESS=$BRIDGE_ADDRESS

DMOJ_JUDGE_NAME=$JUDGE_NAME

PROBLEMS_DIR=$PROBLEMS_DIR
EOF

done

exit 0
