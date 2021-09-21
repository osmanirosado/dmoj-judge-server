#!/usr/bin/env bash

cd "$(dirname "$0")" || exit 1

source load-conf.sh

docker tag "${IMAGE_NAME}:${IMAGE_TAG_BUILD}" "${IMAGE_NAME}:${IMAGE_TAG_USE}"
