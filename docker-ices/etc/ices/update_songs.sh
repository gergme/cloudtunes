#!/usr/bin/env bash

set -e
set -o pipefail

SOURCE="/data"

# For the default station, you must have AT LEAST ONE to start the containers
printf "Generating STATION_0 playlist...\n"
find ${SOURCE}/station_0/ -type f -name '*.ogg' > /etc/ices2/playlist/default0.txt

