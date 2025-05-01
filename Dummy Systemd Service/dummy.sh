#!/bin/bash

LOG_FILE="/var/log/dummy-service.log"

if [ ! -f "$LOG_FILE" ]; then
	touch "$LOG_FILE"
	chmod 644 "$LOG_FILE"
	echo "--- Log file created at $LOG_FILE"
fi

echo "--- Dummy service started at $(date)" >> "$LOG_FILE"

while true; do
	echo "[$(date '+%Y-%m-%d %H:%M:%S')] Dummy service is running..." >> "$LOG_FILE"
	sleep 10
done
