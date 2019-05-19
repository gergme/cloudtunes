#!/usr/bin/env bash

for file in `readlink -f /data/station_0/*.ogg`; do
timeout 5m normalize-ogg --bitrate 128 --tmpdir /tmp --force-encode --ogg ${file}
RESULT=$?
if [ ${RESULT} -eq 124 ]; then printf "Failed to process normalization of ${file}!\n"; rm -fv ${file}; rm -fv /etc/ices2/playlist/default0.txt; printf "Regenerating playlist...\n"; /etc/ices2/update_songs.sh; fi
#sed "/${file}/d" /etc/ices2/playlist/default0.txt; done
timeout 20s lltag -F "/%i/%i/%a - %t" -G -R ${file} --sep _ --spaces -g "CloudTunes Rocks!" --yes
RESULT=$?
if [ ${RESULT} -eq 124 ]; then printf "Failed to process tagging of ${file}!\n"; rm -fv ${file}; rm -fv /etc/ices2/playlist/default0.txt; printf "Regenerating playlist...\n"; /etc/ices2/update_songs.sh; fi
#[ $? -ne "124" ] && sed "/${file}/d" /etc/ices2/playlist/default0.txt; done
done
