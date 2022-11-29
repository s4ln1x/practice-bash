#!/usr/bin/env bash
# NOTE: This script must run as sudo/root to work

cat << AFTER_REBOOT > /usr/local/run_after_reboot.sh
#!/usr/bin/env bash
echo "I RAN AFTER REBOOT" > /tmp/after_reboot
systemctl disable after_reboot
AFTER_REBOOT

chmod +x /usr/local/run_after_reboot.sh

cat << AFTER_REBOOT_SERVICE > /etc/systemd/system/after_reboot.service
[Unit]
Description=Runs after a reboot

[Install]
WantedBy=multi-user.target

[Service]
Type=simple
WorkingDirectory=/usr/local
ExecStart=/usr/local/run_after_reboot.sh
AFTER_REBOOT_SERVICE

systemctl daemon-reload
systemctl enable after_reboot

reboot
