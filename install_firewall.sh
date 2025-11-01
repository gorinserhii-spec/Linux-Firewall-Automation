#!/bin/bash

# --- Улучшение 1: Безопасность (Подтверждение) ---
read -p "Warning: This script will configure UFW and Fail2ban.
It will deny all incoming ports except for SSH, HTTP (80), and HTTPS (443).
Are you sure you want to continue? (y/n): " confirm

if [ "$confirm" != "y" ]; then
    echo "Exiting setup."
    exit 1
fi

# --- Улучшение 2: Интерактивность (Порт SSH) ---
read -p "Please enter your custom SSH port (or press Enter for default '22'): " ssh_port

# Если пользователь ничего не ввел, используем 22
if [ -z "$ssh_port" ]; then
    ssh_port="22"
fi

echo "--- Configuring UFW ---"
# Установка UFW (если его нет)
if ! command -v ufw &> /dev/null; then
    echo "UFW not found. Installing..."
    apt update && apt install -y ufw
fi

# Сначала разрешаем новый SSH-порт, ПОТОМ включаем firewall
echo "Allowing SSH on port $ssh_port/tcp..."
ufw allow $ssh_port/tcp
ufw allow 80/tcp  # HTTP
ufw allow 443/tcp # HTTPS

# Включаем UFW
ufw --force enable
ufw default deny incoming
ufw default allow outgoing

# Включаем логирование
ufw logging high
echo "UFW configured."

# --- Улучшение 3: Безопасность (Установка Fail2ban) ---
echo "--- Configuring Fail2ban ---"
if ! command -v fail2ban-client &> /dev/null; then
    echo "Fail2ban not found. Installing..."
    apt update && apt install -y fail2ban
fi

# --- Улучшение 4: Безопасность (Не перезаписываем конфиг) ---
JAIL_FILE="/etc/fail2ban/jail.local"
SSHD_RULE="[sshd]\nenabled = true"

# Проверяем, существует ли файл и есть ли в нем уже [sshd]
if [ ! -f "$JAIL_FILE" ] || ! grep -q "\[sshd\]" "$JAIL_FILE"; then
    echo "Adding [sshd] rule to $JAIL_FILE..."
    # Используем 'echo -e' и '>>' (append), чтобы ДОБАВИТЬ в конец, а не стереть
    echo -e "\n$SSHD_RULE" >> "$JAIL_FILE"
else
    echo "[sshd] rule already exists in $JAIL_FILE. Skipping."
fi

systemctl restart fail2ban
echo "Fail2ban configured and restarted."
echo "--- Firewall setup complete. ---"