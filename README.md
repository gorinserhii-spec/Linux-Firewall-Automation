# 🔐 Linux Firewall & Automated Security Report

![Bash](https://img.shields.io/badge/language-bash-green)
![Linux](https://img.shields.io/badge/platform-linux-blue)
![Security](https://img.shields.io/badge/focus-security-red)
![License](https://img.shields.io/badge/license-MIT-lightgrey)

---

## 📌 Overview
This project provides **automation scripts** to setup and monitor a Debian-based Linux server (e.g., Ubuntu).
It automates **firewall setup**, **SSH hardening**, and **Fail2ban configuration**, and generates live **security reports**.

The scripts are:
- 🧩 **Interactive** — guide the user step-by-step.
- 🧱 **Non-destructive** — append rules safely, never overwrite.
- 🔒 **Security-focused** — designed for real server environments.

---

## 🎯 Key Features

- **Interactive Setup** — choose a custom SSH port (avoid default port 22).
- **Safety Confirmation** — user approval before applying changes.
- **Non-Destructive Configuration** — appends to `/etc/fail2ban/jail.local` instead of overwriting.
- **Two-Script Architecture:**
  - `install_firewall.sh` → installs and configures security stack.
  - `generate_report.sh` → produces timestamped reports.
- **Firewall Policy:**
  - Default: deny all incoming.
  - Allow: SSH (custom port), HTTP (80), HTTPS (443).
- **Automated Reporting:**
  - Captures live Fail2ban status.
  - Summarizes recent blocked UFW packets in `report.md`.

---

## 🛠 Requirements

- Debian-based Linux (Ubuntu 20.04 or newer)
- `sudo` or root privileges
- Bash shell environment

---

## 🔧 Script Details

### 🧰 `install_firewall.sh` — Installer

**Main actions:**
1. 🔹 **Confirmation prompt** – prevents accidental execution.
2. 🔹 **Custom SSH port** – user input (defaults to 22).
3. 🔹 **UFW setup:**
   - Installs UFW if missing.
   - Configures custom SSH, HTTP and HTTPS rules.
   - Enables logging.
4. 🔹 **Fail2ban configuration:**
   - Installs Fail2ban if missing.
   - Checks `/etc/fail2ban/jail.local`; safely appends `[sshd]` rule if absent.
5. 🔹 **Service restart & activation:**
   - Restarts Fail2ban.
   - Enables and activates UFW.

---

### 📄 `generate_report.sh` — Reporter

Creates a detailed, timestamped `report.md` with:
- Current **Fail2ban jail status** (`fail2ban-client status sshd`).
- Recent **UFW block entries** – last 20 records from `/var/log/ufw.log`.
- Auto-generated header and creation date.

---

## 🚀 Usage

### 1️⃣ Make scripts executable
```bash
chmod +x install_firewall.sh
chmod +x generate_report.sh
```

### 2️⃣ Run installer (one-time setup)
```bash
sudo ./install_firewall.sh
```

### 3️⃣ Generate security report anytime
```bash
sudo ./generate_report.sh
```

### 4️⃣ View report
Open report.md to inspect the firewall and Fail2ban activity summary.

### 📊 Example Output
Example report on a clean server (real data will populate as attacks are blocked): report.PNG

### 🧠 Summary
This project demonstrates a professional, security-oriented approach to Linux server management. It separates setup from monitoring and prioritizes safety, automation, and transparency.

- Bash scripting
- Linux system administration
- Firewall configuration (UFW)
- Intrusion prevention (Fail2ban)
- Security automation & reporting

## 📜 License
This project is licensed under the [MIT License](./LICENSE).

=================================================
# Author: Serhii Gorin 
# Date: 01.11.2025

---
> ℹ️ **Note:** The scripts in this repository were implemented using AI-assisted tools to optimize the automation logic. The focus of this project is on **System Administration** and **Infrastructure logic**, ensuring the solution works correctly in a production-like environment.
