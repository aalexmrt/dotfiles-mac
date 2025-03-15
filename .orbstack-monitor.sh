#!/bin/bash

# Check if OrbStack is running
if ! pgrep -q "OrbStack"; then
    exit 0
fi

# Check if any containers are running
if [ "$(docker ps -q 2>/dev/null)" = "" ]; then
    # Log the action
    echo "$(date): Stopping OrbStack due to inactivity" >> "$HOME/.orbstack-monitor.log"
    # Stop OrbStack
    pkill OrbStack
fi
