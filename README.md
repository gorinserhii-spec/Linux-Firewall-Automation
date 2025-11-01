# 🔐 Linux Firewall & Automated Security Report  

![Bash](https://img.shields.io/badge/language-bash-green)
![Linux](https://img.shields.io/badge/platform-linux-blue)
![Security](https://img.shields.io/badge/focus-security-red)
![License](https://img.shields.io/badge/license-MIT-lightgrey)

---

## 📌 Overview  
Interactive Bash automation project for securing and monitoring a Debian-based Linux server (e.g., Ubuntu).  
Includes **firewall setup**, **SSH hardening**, **Fail2ban configuration**, and **real-time report generation**.

Designed to be:  
- 🧩 **Interactive** – guided step-by-step configuration.  
- 🧱 **Non-destructive** – appends safely without overwriting.  
- 🔒 **Security-focused** – built for real production environments.

---

## 🎯 Key Features  

- **Interactive Setup** — select a custom SSH port (avoid default port 22).  
- **Safety Confirmation** — user approval before applying rules.  
- **Non-Destructive Configuration** — safely appends to `/etc/fail2ban/jail.local`.  
- **Two-Script Design:**  
  - `install_firewall.sh` → setup & configuration.  
  - `generate_report.sh` → monitoring & reporting.  
- **Firewall Policy:**  
  - Default: deny all incoming.  
  - Allow: SSH (custom port), HTTP (80), HTTPS (443).  
- **Automated Reporting:**  
  - Captures live Fail2ban jail status.  
  - Summarizes last blocked packets from UFW logs into `report.md`.

---

## 🛠 Requirements  

- Debian-based Linux (Ubuntu 20.04+ recommended)  
- `sudo` or root privileges  
- Bash shell  

---

## 🔧 Script Details  

### 🧰 `install_firewall.sh` — Installer  

**Functionality:**  
1. Prompts for confirmation to prevent accidental execution.  
2. Asks for a custom SSH port (default: 22).  
3. Installs and configures **UFW**:  
   - Installs if missing.  
   - Applies default deny policy for incoming connections.  
   - Allows SSH (custom), HTTP (80), HTTPS (443).  
   - Enables logging.  
4. Installs and configures **Fail2ban**:  
   - Installs if missing.  
   - Checks `/etc/fail2ban/jail.local` and safely appends `[sshd]` rule if absent.  
5. Restarts **Fail2ban** and enables **UFW** to apply all changes.  

---

### 📄 `generate_report.sh` — Reporter  

**Functionality:**  
- Creates a new `report.md` file with a timestamped header.  
- Executes `fail2ban-client status sshd` and outputs banned IPs and jail stats.  
- Reads `/var/log/ufw.log` to extract the latest `[UFW BLOCK]` events (last 20 entries).  
- Saves all results into `report.md` for review.

---

## 🚀 Usage  

### 1️⃣ Make the scripts executable  
```bash
chmod +x install_firewall.sh
chmod +x generate_report.sh
