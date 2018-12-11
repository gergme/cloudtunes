#!/usr/bin/env bash

set -e
set -o pipefail

SOURCE="/data"

printf "Generating STATION_0 playlist...\n"
find ${SOURCE}/station_0/ -type f -name '*.ogg' > /etc/ices2/playlist/station_0.txt

printf "Generating STATION_1 playlist...\n"
find ${SOURCE}/station_1/ -type f -name '*.ogg' > /etc/ices2/playlist/station_1.txt
