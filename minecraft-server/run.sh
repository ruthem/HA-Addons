#!/bin/sh
set -e

mkdir -p /share/minecraft-server
cd /share/minecraft-server/
/usr/local/bin/entrypoint-demoter --match /share/minecraft-server --debug --stdin-on-term stop /opt/bedrock-entry.sh