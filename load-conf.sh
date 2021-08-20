#!/usr/bin/env bash

CONF_FILE='judges.conf'
if [[ -f "$CONF_FILE" ]]
then
    source $CONF_FILE
else
    echo "[error] The $CONF_FILE does not exists. Run 'setup-conf.sh' script to create it."
    exit 1
fi
