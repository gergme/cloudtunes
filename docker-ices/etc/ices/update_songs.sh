#!/usr/bin/env bash

set -e
set -o pipefail

SOURCE="/data"
STATION="default"

printf "Generating ${STATION} playlist...\n"
find ${SOURCE}/${STATION}/ -type f -name '*.ogg' > /etc/ices2/playlist/${STATION}.txt


