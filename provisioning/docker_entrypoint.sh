#!/bin/bash

# Default to 'bash' if no arguments are provided
args="$@"
if [ -z "$args" ]; then
  args="/bin/bash"
fi

exec $args
