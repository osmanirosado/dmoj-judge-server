#!/usr/bin/env bash

JUDGE_NUMBER=3
JUDGE_NAME_PREFIX='main-judge-'

IMAGE_TAG=latest
BRIDGE_ADDRESS=10.12.101.21
PROBLEMS_DIR=/mnt/dmoj/problems

FILE=".env"
if [[ ! -f "$FILE" ]]
then
    echo "-> Setting up the $FILE file"
    cat > .env <<EOF
IMAGE_TAG=$IMAGE_TAG

EOF
else
    echo "-> The $FILE file exists"
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
    echo "-> Setting up the $FILE file"
    cat > "$FILE" <<EOF
IMAGE_TAG=$IMAGE_TAG

BRIDGE_ADDRESS=$BRIDGE_ADDRESS

JUDGE_NAME=${JUDGE_NAME_PREFIX}$i
JUDGE_KEY=<Define the judge key here>

PROBLEMS_DIR=$PROBLEMS_DIR
EOF
    else
      echo "-> The $FILE file exists"
    fi
done
