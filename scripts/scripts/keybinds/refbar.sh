#!/usr/bin/env sh

# Refresh the dwmbar.
# Send SIGTRAP signal to dwmbar script, which will handle it with a trap.
pkill -SIGTRAP dwmbar.sh
