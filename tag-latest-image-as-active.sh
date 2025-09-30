#!/usr/bin/env bash

cd "$(dirname "$0")" || exit 1

source load-judges-config.sh

docker tag "${IMAGE_NAME}:${IMAGE_TAG_LATEST}" "${IMAGE_NAME}:${IMAGE_TAG_ACTIVE}"
