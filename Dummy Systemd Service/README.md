# dummy-systemd-service

A long-running systemd service that logs to a file

Usage:

```bash
chmod +x setup.sh test_dashboard.sh cleanup.sh
sudo ./setup.sh
sudo ./dummy.sh
sudo ./cleanup.sh
```

For real-time monitoring when the dummy service is running:
```bash
tail -f /var/log/dummy-service.log
```

https://roadmap.sh/projects/dummy-systemd-service
