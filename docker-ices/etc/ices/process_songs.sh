#!/usr/bin/env bash

lltag -F "/%i/%i/%a - %t" -G -R /data/default/* --sep _ --spaces -g "CloudTunes Rocks!" --yes
normalize-ogg --bitrate 128 --tmpdir /tmp --force-encode --ogg /data/default/*.ogg
