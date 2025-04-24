#!/bin/sh
echo "<<< SERVER PERFORMANCE STATISTICS >>>"
echo "Date: $(date)"
echo

echo "--- System Information ---"
echo "OS: $(uname -s)"
echo "Kernel: $(uname -r)"
echo "Uptime: $(uptime)"
echo

echo "--- Total CPU Usage ---"
top -bn1 | grep "%Cpu(s):" | cut -d ',' -f 4 | awk '{print "Usage: " 100-$1 "%"}'
echo

echo "--- Total Memory Usage ---"
free | awk '/^Mem:/ {
    total_bytes=$2; used_bytes=$3; free_bytes=$4;
    printf "Total: %.1fGi\nUsed: %.1fGi (%.2f%%)\nFree: %.1fGi (%.2f%%)\n",
           total_bytes/1024^3, used_bytes/1024^3, used_bytes/total_bytes * 100,
           free_bytes/1024^3, free_bytes/total_bytes * 100
}'
echo

echo "--- Total Disk Usage ---"
df -h | awk '$6 == "/" {printf "Total: %s\nUsed: %s (%s)\nFree: %s\n", $2, $3, $5, $4}'
echo

echo "--- Top 5 Processes by Memory ---"
ps aux --sort -%mem | head -n 6 | awk '{print $1 "\t" $2 "\t" $4 "\t" $11}'
echo

echo "--- Top 5 Processes by CPU ---"
ps aux --sort -%cpu | head -n 6 | awk '{print $1 "\t" $2 "\t" $3 "\t" $11}'
echo

echo "<<< END OF REPORT >>>"