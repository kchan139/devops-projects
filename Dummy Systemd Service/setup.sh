#/bin/bash

echo "--- Setting Up Dummy Systemd Service..."

chmod +x dummy.sh

if [ ! -d /usr/bin/dummy/ ]; then
	mkdir /usr/bin/dummy/
fi

cp dummy.sh /usr/bin/dummy/
cp dummy.service /etc/systemd/system/

systemctl daemon-reload

echo "--- Setup Completed."
