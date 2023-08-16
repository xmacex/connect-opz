#!/bin/sh
# arecord -l and aplay -l lists ALSA input and output devices.
# jack_lsp lists Jack devices, connections with -c.

# Start alsa_in.
alsa_in -d hw:CARD=Digitone -j digitone &

# Wait for alsa_in to come up.
sleep 1

# Connect softcut.
jack_connect digitone:capture_1 softcut:input_1
jack_connect digitone:capture_2 softcut:input_2

# Connect to crone (monitor).
jack_connect digitone:capture_1 crone:input_1
jack_connect digitone:capture_2 crone:input_2

# Connect to system playback.
# jack_connect alsa_in:capture_1 system:playback_1
# jack_connect alsa_in:capture_2 system:playback_2
