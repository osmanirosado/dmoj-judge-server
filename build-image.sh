#!/usr/bin/env bash

cd "$(dirname "$0")" || exit 1

source load-conf.sh

docker tag "${IMAGE_NAME}:${IMAGE_TAG}" "${IMAGE_NAME}:oldest"

OUTPUT_FILE=build-image.out
echo "[info] Running the docker compose build command in background. See the output in the '${OUTPUT_FILE}' file."
nohup /usr/local/bin/docker-compose build --pull > ${OUTPUT_FILE} 2>&1 &
