#!/bin/bash

status="$(pamixer --get-mute)"

[ $status != "true" ] && echo "" || echo "ﳌ"
