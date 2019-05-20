#!/usr/bin/env bash

function errorHandler() {
	printf "Failed to process file ${file}, purging ... \n"
	rm -f ${file}
	rm -f /etc/ices2/playlist/default0.txt
	printf "Regenerating playlist ... \n"
	/etc/ices2/update_songs.sh
}

for file in `readlink -f /data/station_0/*.ogg`; do
timeout 5m normalize-ogg --bitrate 128 --tmpdir /tmp --force-encode --ogg ${file}
RESULT=$?
if [ ${RESULT} -eq 124 ]; then errorHandler; fi
timeout 5s lltag -F "/%i/%i/%a - %t" -G -R ${file} --sep _ --spaces -g "CloudTunes Rocks!" --yes
RESULT=$?
if [ ${RESULT} -eq 124 ]; then errorHandler; fi
done
