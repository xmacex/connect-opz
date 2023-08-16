#!/bin/sh
# arecord -l and aplay -l lists ALSA input and output devices.
# jack_lsp lists Jack devices, connections with -c.

# Start alsa_in.
alsa_in -d hw:CARD=H4 -j h4 &

# Wait for alsa_in to come up.
sleep 1

# Connect softcut.
jack_connect h4:capture_1 softcut:input_1
jack_connect h4:capture_2 softcut:input_2

# Connect to crone (monitor).
jack_connect h4:capture_1 crone:input_1
jack_connect h4:capture_2 crone:input_2

# Connect to system playback.
# jack_connect alsa_in:capture_1 system:playback_1
# jack_connect alsa_in:capture_2 system:playback_2
