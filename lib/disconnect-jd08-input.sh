#!/bin/sh
# I believe Jack cleans out the disconnects itself.

/bin/kill $(ps -C alsa_in h -o pid,cmd |grep "Boutique" |cut -d" " -f2)
