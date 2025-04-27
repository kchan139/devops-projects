#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root or with sudo privileges"
    exit 1
fi

echo "=== CLEANING UP NETDATA INSTALLATION ==="

echo "--- Stopping Netdata service..."
systemctl stop netdata

echo "--- Removing Netdata..."
    
systemctl disable netdata

# Remove packages
apt-get remove --purge -y netdata
apt-get autoremove -y

# Remove directories
echo "--- Removing configuration files..."
rm -rf /etc/netdata

echo "--- Netdata has been removed from the system."