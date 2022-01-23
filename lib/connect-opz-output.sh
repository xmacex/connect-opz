#!/bin/sh
# arecord -l and aplay -l lists ALSA input and output devices.
# jack_lsp lists Jack devices, connections with -c.

# Start and alsa_out.
alsa_out -d hw:CARD=OPZ -r 44100 -j opz &

# Wait for alsa_out to come up.
sleep 1

# Connect from softcut to OP-Z.
jack_connect softcut:output_1 opz:playback_1
jack_connect softcut:output_2 opz:playback_2

# Connect from crone (monitor) to OP-Z.
jack_connect crone:output_1 opz:playback_1
jack_connect crone:output_2 opz:playback_2
