#!/bin/bash

# Run the uptime command and pipe it into awk to extract just the "up time" portion
uptime --pretty| cut -c 3-

