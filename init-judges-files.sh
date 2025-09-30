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

JUDGE_KEY_FILE=".key"

for ((i = 1 ; i <= "$JUDGE_NUMBER" ; i++))
do
    NAME="judge$i"
    JUDGE_NAME="${JUDGE_NAME_PREFIX}$i"
    PROJECT_NAME="${PROJECT_NAME_PREFIX}$i"

    cat >>"$ALIASES_FILE" <<<"alias ${PROJECT_NAME}dc='sudo docker compose --project-directory $PWD/$NAME -f $PWD/judge.yml'"

    mkdir -p "$NAME"

    FILE="$NAME/.gitignore"      && test ! -f "$FILE" && echo '*' > "$FILE"
    FILE="$NAME/.dockerignore"   && test ! -f "$FILE" && echo '*' > "$FILE"
    FILE="$NAME/$JUDGE_KEY_FILE" && test ! -f "$FILE" && echo 'DMOJ_JUDGE_KEY=' > "$FILE"

    FILE="$NAME/.env"
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
