#!/usr/bin/env bash

cd "$(dirname "$0")" || exit 1

CONF_FILE='judges.conf'
if [[ -f "$CONF_FILE" ]]
then
    source $CONF_FILE
else
    echo "[error] The $CONF_FILE does not exists. Run 'setup-conf.sh' script to create it."
    exit 1
fi

docker tag "${IMAGE_NAME}:${IMAGE_TAG}" "${IMAGE_NAME}:oldest"

OUTPUT_FILE=build-image.out
echo "[info] Running the docker compose build command in background. See the output in the '${OUTPUT_FILE}' file."
nohup /usr/local/bin/docker-compose build --pull > ${OUTPUT_FILE} 2>&1 &

# wait for message from nohup to be written in terminal
sleep 2s
