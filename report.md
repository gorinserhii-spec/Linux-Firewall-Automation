# Firewall Attack Report
## Date: Sat Nov  1 05:50:14 PM CET 2025

--- Fail2ban Status (sshd) ---
```
Status for the jail: sshd
|- Filter
|  |- Currently failed:	0
|  |- Total failed:	0
|  `- Journal matches:	_SYSTEMD_UNIT=sshd.service + _COMM=sshd
`- Actions
   |- Currently banned:	0
   |- Total banned:	0
   `- Banned IP list:	
```

--- UFW Log (Last 20 DENY entries) ---
```
2025-11-01T17:50:05.536116+01:00 serhii-Virtual-Machine kernel: [UFW BLOCK] IN=eth0 OUT= MAC=00:15:5d:a4:41:08:34:60:f9:97:55:d5:08:00 SRC=194.106.216.232 DST=192.168.1.130 LEN=52 TOS=0x00 PREC=0x00 TTL=51 ID=24009 DF PROTO=TCP SPT=443 DPT=60722 WINDOW=502 RES=0x00 ACK URGP=0 
2025-11-01T17:50:05.536142+01:00 serhii-Virtual-Machine kernel: [UFW BLOCK] IN=eth0 OUT= MAC=00:15:5d:a4:41:08:34:60:f9:97:55:d5:08:00 SRC=194.106.216.232 DST=192.168.1.130 LEN=52 TOS=0x00 PREC=0x00 TTL=51 ID=58982 DF PROTO=TCP SPT=443 DPT=60700 WINDOW=502 RES=0x00 ACK URGP=0 
2025-11-01T17:50:10.644221+01:00 serhii-Virtual-Machine kernel: [UFW BLOCK] IN=eth0 OUT= MAC=01:00:5e:00:00:fb:e0:1f:88:f4:26:45:08:00 SRC=192.168.1.124 DST=224.0.0.251 LEN=32 TOS=0x00 PREC=0xC0 TTL=1 ID=0 DF PROTO=2 
```
