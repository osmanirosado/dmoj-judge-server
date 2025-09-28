#!/usr/bin/env bash

cd "$(dirname "$0")" || exit 1

source load-judges-config.sh

FILE=".env"
if [[ ! -f "$FILE" ]]
then
    echo "[info] Setting up the $FILE file"
    cat > .env <<EOF
BASE_IMAGE=$BASE_IMAGE

IMAGE=$IMAGE_NAME:$IMAGE_TAG_BUILD

EOF
else
    echo "[warn] The $FILE file exists"
fi

ALIASES_FILE=bash_aliases
echo "" > $ALIASES_FILE

for ((i = 1 ; i <= "$JUDGE_NUMBER" ; i++))
do
    NAME="judge-$i"
    JUDGE_NAME="${JUDGE_NAME_PREFIX}$i"
    PROJECT_NAME="${PROJECT_NAME_PREFIX}$i"

    cat >>"$ALIASES_FILE" <<<"alias ${PROJECT_NAME}-dc='sudo docker compose --project-directory $PWD/$NAME -f $PWD/judge.yml'"

    mkdir -p "$NAME"

    FILE="$NAME/.gitignore"      && test ! -f "$FILE" && echo '*' > "$FILE"
    FILE="$NAME/.dockerignore"   && test ! -f "$FILE" && echo '*' > "$FILE"

    FILE="$NAME/.env"
    JUDGE_KEY=''
    if [[ -f "$FILE" ]]
    then
      # Extract JUDGE_KEY value only (handles quotes, simple assignments)
      JUDGE_KEY=$(awk -F= '/^JUDGE_KEY[[:space:]]*=/{sub(/^[^=]*=[[:space:]]*/,"",$0); gsub(/^[ \t]*"|"[ \t]*$/,"",$0); print $0; exit}' "$FILE")
    fi

    echo "[info] Setting up the $FILE file."
    cat > "$FILE" <<EOF
PROJECT_NAME=${PROJECT_NAME}

IMAGE=$IMAGE_NAME:$IMAGE_TAG_ACTIVE

BRIDGE_ADDRESS=$BRIDGE_ADDRESS

JUDGE_NAME=${JUDGE_NAME}
# Define the judge key here
JUDGE_KEY=${JUDGE_KEY}

PROBLEMS_DIR=$PROBLEMS_DIR
EOF

done

exit 0
