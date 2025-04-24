#!/bin/sh

LOG_FILE=$1

if [ -z "$LOG_FILE" ] || [ ! -f "$LOG_FILE" ]; then
    echo 'Usage: $0 <nginx_log_file>'
    echo 'Error: Log file not found.'
fi

echo
echo '<<< NGINX LOG ANALYSIS >>>'
echo

echo '--- Top 5 IP addresses with the most requests ---'
awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -5 | awk '{print $2 " - " $1 " requests"}'
echo

echo "--- Top 5 most requested paths ---"
awk '{print $7}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -5 | awk '{print $2 " - " $1 " requests"}'
echo

echo "--- Top 5 response status codes ---"
awk '{print $8}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -5 | awk '{print $2 " - " $1 " requests"}'
echo

echo "--- Top 5 user agents ---"
awk -F'"' '{print $6}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -5 | awk '{ for (i=2; i<=NF; i++) printf "%s ", $i; print "- " $1 " requests" }'
echo

echo "<<< END OF ANALYSIS >>>"