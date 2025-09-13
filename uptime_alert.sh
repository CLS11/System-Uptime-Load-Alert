#!/bin/bash

#Output file
REPORT="system_uptime_alert.txt"

#Print Header
echo "System Uptime & Load Report - $(date)" > "$REPORT"
echo "=========================================" >> "$REPORT"

#Show Uptime
echo "" >> "$REPORT"
echo "CPU Load Averages:" >> "$REPORT"
cat /proc/loadavg >> "$REPORT"

#Optional alert
LOAD=$(awk '{print $1}' /proc/loadavg)
THRESHOLD=2.0

if (( $(echo "$LOAD > $THRESHOLD" | bc -l) )); then
    echo "Warning: CPU load is above $THRESHOLD!" >> "$REPORT"
else
    echo "CPU load is normal." >> "$REPORT"
fi

echo "Report saved in $REPORT"
