#!/usr/bin/env bash

cat > .env <<EOF
# Environment variables for Docker Compose

BRIDGE_ADDRESS=10.12.101.21:9999
JUDGE_NAME=<name>
JUDGE_KEY=<key>

EOF

