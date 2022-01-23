#!/bin/sh
# I believe Jack cleans out the disconnects itself.

# killall alsa_out
/bin/kill $(ps -C alsa_out h -o pid,cmd |grep "OPZ" |cut -d" " -f2)
