#!/bin/bash

# Check if exactly one argument is provided
if [ "$#" -ne 1 ]; then
    echo "Usage of the Script: $0 service_name"
    exit 1
fi

SERVICE="$1"

# Check the service status
if systemctl is-active --quiet "$SERVICE"; then
    echo "Service '$SERVICE' is running."
else
    echo "Service '$SERVICE' is not running."
fi

exit 0
