# d0minRec0n

```
     ____        _      ____                      
    |  _ \  ___ | | ___|  _ \ ___  ___ ___  _ __ 
    | | | |/ _ \| |/ _ \ |_) / _ \/ __/ _ \| '_ \
    | |_| | (_) | |  __/  _ <  __/ (_| (_) | | | |
    |____/ \___/|_|\___|_| \_\___|\___\___/|_| |_|

              d0minRec0n
        Domain OSINT & Recon Tool
```

**d0minRec0n** is a lightweight Bash-based **Domain OSINT & Reconnaissance tool** designed to automate common reconnaissance tasks against a target domain using standard Linux utilities and popular OSINT tools.

> ⚠️ **Authorized use only**  
> This tool is intended for **legal security research, penetration testing, and educational purposes**.  
> Do **NOT** use against targets without explicit permission.

---

## Features

d0minRec0n performs multiple recon tasks and neatly stores the results in a structured output directory:

- DNS information gathering
  - `host`
  - `nslookup`
  - `dig`
- Network path discovery
  - `traceroute`
- Domain ownership & registration info
  - `whois`
- DNS enumeration
  - `dnsrecon`
- Web Application Firewall detection
  - `wafw00f`
- Subdomain discovery via Certificate Transparency
  - `crt.sh`

---

## Installation

### 1. Clone the repository
```bash
git https://github.com/Route6969/d0mainRec0n.git
cd d0minRec0n
```

### 2. Make the script executable
```bash
chmod +x d0minRec0n
```

> Dependencies

*Ensure the following tools are installed on your system:*

- bash
- host
- nslookup
- dig
- traceroute
- whois
- dnsrecon
- wafw00f
- curl
- jq

### Install on Debian/Ubuntu

```bash
sudo apt update
sudo apt install -y dnsutils traceroute whois curl jq
pip install dnsrecon wafw00f
```

### Usage

```bash
./d0minRec0n <domain>
```

### Example

```bash
./d0minRec0n example.com
```

### Output Structure

All results are saved in a directory named after the target domain:

```
recon-example.com/
├── host.txt
├── nslookup.txt
├── traceroute.txt
├── dig.txt
├── whois.txt
├── dnsrecon.txt
├── wafw00f.txt
└── crtsh-subdomains.txt
```

### Subdomain Discovery (crt.sh)

d0minRec0n queries crt.sh to extract subdomains from public TLS certificates, then:

- Removes wildcard entries
- Deduplicates results
- Outputs a clean list for further enumeration

### Disclaimer

This tool is provided as-is with no warranty.
The author is not responsible for misuse, damage, or legal consequences resulting from the use of this software.

Always get written authorization before performing reconnaissance or scanning activities.

### License

MIT License

### Author

Created by losharik
Happy hunting 🕵️‍♂️