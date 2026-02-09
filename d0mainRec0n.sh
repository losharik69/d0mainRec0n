#!/bin/bash

# -----------------------------
# d0minRec0n - Domain OSINT Tool
# -----------------------------

RED="\e[31m"
GREEN="\e[32m"
CYAN="\e[36m"
YELLOW="\e[33m"
RESET="\e[0m"

# ASCII Art
echo -e "${CYAN}"
cat << "EOF"
     ____        _      ____                      
    |  _ \  ___ | | ___|  _ \ ___  ___ ___  _ __ 
    | | | |/ _ \| |/ _ \ |_) / _ \/ __/ _ \| '_ \
    | |_| | (_) | |  __/  _ <  __/ (_| (_) | | | |
    |____/ \___/|_|\___|_| \_\___|\___\___/|_| |_|

              d0minRec0n
        Domain OSINT & Recon Tool
EOF
echo -e "${RESET}"

echo -e "${RED}[!] WARNING:${RESET} Authorized use only. Do NOT scan targets without permission."
echo

# Usage check
if [ -z "$1" ]; then
    echo -e "${YELLOW}Usage:${RESET} ./d0minRec0n <domain>"
    exit 1
fi

DOMAIN=$1
OUTDIR="recon-$DOMAIN"
mkdir -p "$OUTDIR"

echo -e "${GREEN}[+] Target:${RESET} $DOMAIN"
echo -e "${GREEN}[+] Output:${RESET} $OUTDIR"
echo

# -----------------------------
# DNS Recon
# -----------------------------
echo -e "${CYAN}[*] host${RESET}"
host "$DOMAIN" | tee "$OUTDIR/host.txt"
echo

echo -e "${CYAN}[*] nslookup${RESET}"
nslookup "$DOMAIN" | tee "$OUTDIR/nslookup.txt"
echo

# -----------------------------
# Traceroute
# -----------------------------
echo -e "${CYAN}[*] traceroute${RESET}"
traceroute "$DOMAIN" | tee "$OUTDIR/traceroute.txt"
echo

echo -e "${CYAN}[*] dig${RESET}"
dig "$DOMAIN" any +short | tee "$OUTDIR/dig.txt"
echo

# -----------------------------
# WHOIS
# -----------------------------
echo -e "${CYAN}[*] whois${RESET}"
whois "$DOMAIN" | tee "$OUTDIR/whois.txt"
echo

# -----------------------------
# DNSRecon
# -----------------------------
echo -e "${CYAN}[*] dnsrecon${RESET}"
dnsrecon -d "$DOMAIN" -a | tee "$OUTDIR/dnsrecon.txt"
echo

# -----------------------------
# WAF Detection
# -----------------------------
echo -e "${CYAN}[*] wafw00f${RESET}"
wafw00f "$DOMAIN" | tee "$OUTDIR/wafw00f.txt"
echo

# -----------------------------
# Subdomain Discovery (crt.sh)
# -----------------------------
echo -e "${CYAN}[*] crt.sh subdomain discovery${RESET}"

curl -s "https://crt.sh/?q=%25.$DOMAIN&output=json" \
| jq -r '.[].name_value' \
| tr '\n' ',' \
| tr ',' '\n' \
| sed 's/\*\.//g' \
| sort -u \
| tee "$OUTDIR/crtsh-subdomains.txt"

echo

# -----------------------------
# Done
# -----------------------------
echo -e "${GREEN}[✔] d0minRec0n completed${RESET}"
echo -e "${GREEN}[✔] Results saved in:${RESET} $OUTDIR"
