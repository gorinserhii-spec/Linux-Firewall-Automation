#!/bin/bash

REPORT_FILE="report.md"
UFW_LOG="/var/log/ufw.log"

echo "Generating attack report..."

# Create a new, clean report
echo "# Firewall Attack Report" > "$REPORT_FILE"
echo "## Date: $(date)" >> "$REPORT_FILE"
echo "" >> "$REPORT_FILE"

# Check if Fail2ban is running
if command -v fail2ban-client &> /dev/null; then
    echo "--- Fail2ban Status (sshd) ---" >> "$REPORT_FILE"
    
    # Get the full status, not just the IP
    STATUS_OUTPUT=$(fail2ban-client status sshd)
    
    echo "\`\`\`" >> "$REPORT_FILE"
    echo "$STATUS_OUTPUT" >> "$REPORT_FILE"
    echo "\`\`\`" >> "$REPORT_FILE"
else
    echo "Fail2ban is not installed. Skipping Fail2ban report." >> "$REPORT_FILE"
fi

echo "" >> "$REPORT_FILE"

# Check if the UFW log exists
if [ -f "$UFW_LOG" ]; then
    echo "--- UFW Log (Last 20 DENY entries) ---" >> "$REPORT_FILE"
    echo "\`\`\`" >> "$REPORT_FILE"
    # Search for lines containing [UFW BLOCK], as DENY might be elsewhere
    tail -n 100 "$UFW_LOG" | grep "\[UFW BLOCK\]" | tail -n 20 >> "$REPORT_FILE"
    echo "\`\`\`" >> "$REPORT_FILE"
else
    echo "UFW log file ($UFW_LOG) not found. Skipping UFW report." >> "$REPORT_FILE"
fi

echo "Report generated: $REPORT_FILE"
