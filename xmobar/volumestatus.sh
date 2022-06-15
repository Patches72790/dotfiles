#!/bin/bash

status="$(pamixer --get-mute)"

if [[ !$status ]]; then
    echo ""
else
    echo "ﳌ"
fi
