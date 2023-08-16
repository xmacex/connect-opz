#!/bin/sh
# I believe Jack cleans out the disconnects itself.

#/usr/bin/killall -s 9 alsa_in
/bin/kill $(ps -C alsa_in h -o pid,cmd |grep "H4" |cut -d" " -f2)
