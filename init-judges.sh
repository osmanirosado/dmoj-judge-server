#!/usr/bin/env bash

cd "$(dirname "$0")" || exit 1

source load-conf.sh

FILE=".env"
if [[ ! -f "$FILE" ]]
then
    echo "[info] Setting up the $FILE file"
    cat > .env <<EOF
IMAGE_NAME=$IMAGE_NAME
IMAGE_TAG=$IMAGE_TAG

EOF
else
    echo "[warn] The $FILE file exists"
fi

ALIASES_FILE=bash_aliases
echo "" > $ALIASES_FILE

for ((i = 1 ; i <= "$JUDGE_NUMBER" ; i++))
do
    NAME="judge-$i"
    cat >>"$ALIASES_FILE" <<<"alias judge${i}dc='docker-compose --project-directory $PWD/$NAME -f $PWD/judge.yml'"

    mkdir -p "$NAME"

    FILE="$NAME/.gitignore" && test ! -f "$FILE" && cat > "$FILE" <<<'*'
    FILE="$NAME/.dockerignore" && test ! -f "$FILE" && cat > "$FILE" <<<'*'

    FILE="$NAME/.env"
    if [[ ! -f "$FILE" ]]
    then
    echo "[info] Setting up the $FILE file."
    cat > "$FILE" <<EOF
IMAGE_NAME=$IMAGE_NAME
IMAGE_TAG=$IMAGE_TAG

BRIDGE_ADDRESS=$BRIDGE_ADDRESS

JUDGE_NAME=${JUDGE_NAME_PREFIX}$i
JUDGE_KEY=<Define the judge key here>

PROBLEMS_DIR=$PROBLEMS_DIR
EOF
    else
      echo "[warn] The $FILE file exists."
    fi
done

exit 0
