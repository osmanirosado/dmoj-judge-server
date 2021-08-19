#!/usr/bin/env bash

cd "$(dirname "$0")" || exit 1

CONF_FILE='build-image.conf'
if [[ -f "$CONF_FILE" ]]
then
    source $CONF_FILE
else
    echo "[error] The $CONF_FILE does not exists. Run 'setup-conf.sh' script to create it."
    exit 1
fi

echo "[info] Writing the image tag into the .env file."
cat > .env <<EOF
IMAGE_TAG=$IMAGE_TAG

EOF

OUTPUT_FILE=build-image.out
echo "[info] Running the docker compose build command in background. See the output in the '${OUTPUT_FILE}' file."
nohup docker-compose build --pull > ${OUTPUT_FILE} &
