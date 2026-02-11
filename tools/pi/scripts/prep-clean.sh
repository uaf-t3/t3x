# Define paths
CHROME_HISTORY="$HOME/.config/chromium/Default/History"

# Clear bash history
history -c
rm ~/.bash_history
unset HISTFILE

# Remove SSH keys (Pi will regenerate them)
sudo rm -f /etc/ssh/ssh_host_*

# Clean logs and systemd journals
sudo journalctl --rotate
sudo journalctl --vacuum-time=1s
sudo rm -rf /var/log/*.gz /var/log/*.[0-9] /var/log/*.log

# Optional: Clean package cache
sudo apt clean

# Zero-fill free space to make compression work better (optional but nice) - takes several minutes
# sudo dd if=/dev/zero of=/EMPTY bs=1M || true
# sudo rm -f /EMPTY
# sync

# Delete Chromium history
if [[ -f "$CHROME_HISTORY" ]]; then
    echo "Deleting Chromium history..."
    rm "$CHROME_HISTORY" && echo "Chromium history deleted." || echo "Failed to delete Chromium history."
else
    echo "Chromium history file not found."
fi

# Delete keyrings
sudo rm -f $HOME/.local/share/keyrings/*
