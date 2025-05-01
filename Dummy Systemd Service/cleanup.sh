#!/bin/bash

echo "--- Cleanning Up Dummy Systemd Service..."

systemctl stop dummy.service
systemctl disable dummy.service

rm /etc/systemd/system/dummy.service
rm -rf /usr/bin/dummy/
rm /var/log/dummy-service.log

systemctl daemon-reload

echo "--- Cleanup Completed"
