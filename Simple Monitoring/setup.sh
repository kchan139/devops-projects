#!/bin/bash

if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root or with sudo privileges"
    exit 1
fi

echo "=== SETTING UP NETDATA ==="

echo "--- Updating system packages..."
apt-get update -y
apt-get install stress -y

echo "--- Installing dependencies..."
apt-get install -y curl wget

echo "--- Installing Netdata..."
bash <(curl -Ss https://get.netdata.cloud/kickstart.sh) --dont-wait

echo "--- Restarting Netdata..."
systemctl restart netdata

echo "--- Netdata setup completed"
echo "--- Dashboard available at: http://localhost:19999"