#!/bin/bash

# --- 1. Safety Confirmation ---
read -p "Warning: This script will configure UFW and Fail2ban.
It will deny all incoming ports except for SSH, HTTP (80), and HTTPS (443).
Are you sure you want to continue? (y/n): " confirm

if [ "$confirm" != "y" ]; then
    echo "Exiting setup."
    exit 1
fi

# --- 2. Interactive SSH Port Input ---
read -p "Please enter your custom SSH port (or press Enter for default '22'): " ssh_port

# Default to port 22 if no input is provided
if [ -z "$ssh_port" ]; then
    ssh_port="22"
fi

echo "--- Configuring UFW ---"
# Install UFW if it is not already present
if ! command -v ufw &> /dev/null; then
    echo "UFW not found. Installing..."
    apt update && apt install -y ufw
fi

# Allow the new SSH port *before* enabling the firewall to prevent lockout
echo "Allowing SSH on port $ssh_port/tcp..."
ufw allow $ssh_port/tcp
ufw allow 80/tcp  # HTTP
ufw allow 443/tcp # HTTPS

# Enable the firewall
ufw --force enable
ufw default deny incoming
ufw default allow outgoing

# Enable logging
ufw logging high
echo "UFW configured."

# --- 3. Install Fail2ban ---
echo "--- Configuring Fail2ban ---"
if ! command -v fail2ban-client &> /dev/null; then
    echo "Fail2ban not found. Installing..."
    apt update && apt install -y fail2ban
fi

# --- 4. Non-Destructive Fail2ban Configuration ---
JAIL_FILE="/etc/fail2ban/jail.local"
SSHD_RULE="[sshd]\nenabled = true"

# Check if jail.local exists and if the [sshd] rule is already present
if [ ! -f "$JAIL_FILE" ] || ! grep -q "\[sshd\]" "$JAIL_FILE"; then
    echo "Adding [sshd] rule to $JAIL_FILE..."
    # Use 'echo -e' and '>>' (append) to add the rule without overwriting the file
    echo -e "\n$SSHD_RULE" >> "$JAIL_FILE"
else
    echo "[sshd] rule already exists in $JAIL_FILE. Skipping."
fi

systemctl restart fail2ban
echo "Fail2ban configured and restarted."
echo "--- Firewall setup complete. ---"
