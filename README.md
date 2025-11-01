🔐 Linux Firewall & Report Automation Script
=================================================

📌 Description
This project provides two professional Bash scripts to automate the setup and monitoring of a firewall on a Debian-based Linux server (like Ubuntu). It interactively configures ufw (Uncomplicated Firewall), hardens SSH access, and sets up fail2ban. A separate script generates on-demand security reports.

This project is designed to be safe, interactive, and non-destructive.

🎯 Key Features
Interactive Setup: Asks for a custom SSH port to avoid using the default (and heavily scanned) port 22.

Safety Check: Asks for user confirmation before making any network changes.

Non-Destructive: Safely appends rules to /etc/fail2ban/jail.local; it does not overwrite the file, preserving any existing custom rules.

Separation of Concerns: Includes two separate scripts: one for installation (install_firewall.sh) and one for monitoring (generate_report.sh).

Firewall Rules: Configures UFW to deny all incoming traffic by default, while allowing SSH (custom port), HTTP (80), and HTTPS (443).

Automated Reporting: Generates a timestamped report.md file showing the live fail2ban jail status and the latest blocked packets from UFW logs.

🛠 Requirements
A Debian-based Linux server (e.g., Ubuntu 20.04+).

sudo or root privileges.

Bash shell.

🔧 Script Functionality
install_firewall.sh (The Installer)
Asks for Confirmation: Prevents accidental execution.

Asks for SSH Port: Prompts the user for a custom SSH port (defaults to 22 if left empty).

Installs UFW: Checks if ufw is installed. If not, it installs it.

Sets UFW Rules:

Allows the user-defined SSH port.

Allows HTTP (80) and HTTPS (443).

Sets default deny incoming and allow outgoing.

Enables high-volume logging.

Installs Fail2ban: Checks if fail2ban is installed. If not, it installs it.

Configures Fail2ban:

Safely checks if an [sshd] rule already exists in /etc/fail2ban/jail.local.

If no rule is found, it appends the new [sshd] rule to the file.

Restarts Services: Restarts fail2ban and enables ufw to apply all changes.

generate_report.sh (The Reporter)
Creates Report: Generates a new report.md file with a current title and timestamp.

Gets Fail2ban Status: Runs fail2ban-client status sshd and prints the full output (including banned IPs and statistics) into the report.

Parses UFW Logs: Checks if /var/log/ufw.log exists, finds the last 100 log entries, filters them for [UFW BLOCK] messages, and prints the last 20 blocked packets into the report.

🚀 How to Run
Clone the repository or create the script files (install_firewall.sh and generate_report.sh) on your server.

Make the scripts executable:

Bash

chmod +x install_firewall.sh
chmod +x generate_report.sh
Run the one-time installer with sudo. The script will guide you:

Bash

sudo ./install_firewall.sh
After the server has been running (and potentially blocked some attacks), generate a security report at any time:

Bash

sudo ./generate_report.sh
Check the generated report.md file for the results.

📷 Screenshots
Example of a generated report (this shows a clean server, but will fill up as attacks are blocked): report.png

Summary
This project demonstrates a professional, security-conscious approach to server administration. By separating setup from monitoring and building an interactive, non-destructive installer, it showcases key skills in Bash scripting, Linux hardening, and network security automation.

=================================================

Author: Serhii Gorin
Date: 01.11.2025
