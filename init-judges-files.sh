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

    cat >>"$ALIASES_FILE" <<<"alias ${JUDGE_NAME}-dc='sudo docker compose --project-directory $PWD/$NAME -f $PWD/judge.yml'"

    mkdir -p "$NAME"

    FILE="$NAME/.gitignore" && test ! -f "$FILE" && cat > "$FILE" <<<'*'
    FILE="$NAME/.dockerignore" && test ! -f "$FILE" && cat > "$FILE" <<<'*'

    FILE="$NAME/.env"
    if [[ ! -f "$FILE" ]]
    then
    echo "[info] Setting up the $FILE file."
    cat > "$FILE" <<EOF
IMAGE=$IMAGE_NAME:$IMAGE_TAG_ACTIVE

BRIDGE_ADDRESS=$BRIDGE_ADDRESS

JUDGE_NAME=${JUDGE_NAME}
# Define the judge key here
JUDGE_KEY=''

PROBLEMS_DIR=$PROBLEMS_DIR
EOF
    else
      echo "[warn] The $FILE file exists."
    fi
done

exit 0
