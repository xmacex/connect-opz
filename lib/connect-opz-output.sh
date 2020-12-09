#!/bin/sh
# arecord -l and aplay -l lists ALSA input and output devices.
# jack_lsp lists Jack devices, connections with -c.

# Start and alsa_out.
alsa_out -d hw:1 -r 44100 &

# Wait for alsa_out to come up.
sleep 1

# Connect from softcut to OP-Z.
jack_connect softcut:output_1 alsa_out:playback_1
jack_connect softcut:output_2 alsa_out:playback_2

# Connect from crone (monitor) to OP-Z.
jack_connect crone:output_1 alsa_out:playback_1
jack_connect crone:output_2 alsa_out:playback_2
