#!/bin/bash

# Your command to check if headset is plugged in, for example:
if pacmd list-sinks | grep -q 'headset'; then
  echo ""  # Replace with the actual icon for headset
else
  echo ""  # Replace with the actual icon for speakers
fi

