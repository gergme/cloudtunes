#!/usr/bin/env bash

normalize-ogg --bitrate 128 --tmpdir /tmp --force-encode --ogg /data/station_0/*.ogg
lltag -F "/%i/%i/%a - %t" -G -R /data/station_0/* --sep _ --spaces -g "CloudTunes Rocks!" --yes

