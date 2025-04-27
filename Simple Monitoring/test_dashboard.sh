#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root or with sudo privileges"
    exit 1
fi

echo "=== TESTING NETDATA MONITOR DASHBOARD ==="

if ! systemctl is-active --quiet netdata; then
    echo "--- Netdata is not running. Please install it first using setup.sh"
    exit 1
fi

echo "--- Netdata is running. Dashboard should be available at http://localhost:19999"

generate_cpu_load() {
    echo "--- Generating CPU load for $1 seconds..."
    
    echo "--- CPU load generated. Check the dashboard to see the spike."
    stress --cpu 4 --timeout $1
}

generate_disk_load() {
    echo "--- Generating disk I/O for $1 seconds..."
    timeout $1 dd if=/dev/zero of=/tmp/test_file bs=1M count=1024 conv=fdatasync &
    
    echo "--- Disk I/O generated. Check the dashboard to see the activity."
    sleep $1
}

generate_memory_load() {
    echo "--- Generating memory usage for $1 seconds..."
    timeout $1 bash -c "stress-ng --vm 2 --vm-bytes 80% --vm-method all --verify -t $1" &
    
    echo "--- Memory load generated. Check the dashboard to see the usage spike."
    sleep $1
}

# Check if stress-ng is installed, install if not
if ! command -v stress-ng &> /dev/null; then
    echo "--- Installing stress-ng for memory testing..."
    apt-get update && apt-get install -y stress-ng
fi

echo "--- Starting system load tests..."
generate_cpu_load 60
generate_disk_load 20

# Only run memory test if stress-ng was installed
if command -v stress-ng &> /dev/null; then
    generate_memory_load 30
else
    echo "--- Warning: stress-ng not available, skipping memory test"
fi

echo "--- Load tests completed. Check the Netdata dashboard to see the results."
echo "--- If alerts were triggered, they should be visible on the dashboard. (http://localhost:19999)"