<div align="center">

# ⚡ ForbidBuster

### Advanced 403 Forbidden Bypass Toolkit

![Version](https://img.shields.io/badge/version-2.0-orange?style=for-the-badge)
![Bash](https://img.shields.io/badge/bash-4.0%2B-green?style=for-the-badge&logo=gnu-bash&logoColor=white)
![License](https://img.shields.io/badge/license-MIT-blue?style=for-the-badge)
![Platform](https://img.shields.io/badge/platform-Linux%20%7C%20macOS-lightgrey?style=for-the-badge)

**ForbidBuster** is a powerful, all-in-one bash toolkit designed to bypass HTTP 403 Forbidden responses using **12+ advanced techniques** — from path manipulation and header spoofing to cache poisoning, Unicode encoding, and hop-by-hop abuse.

---

</div>

## 🚀 Features

| Category | Techniques |
|---|---|
| 🔓 **Path Fuzzing** | Dot-segment traversal, null bytes, double URL encoding, semicolons, file extensions, backslash injection |
| 🎭 **Header Fuzzing** | X-Forwarded-For, X-Client-IP, X-Real-IP, X-Original-URL, X-Rewrite-URL, CF-Connecting-IP, True-Client-IP, and 20+ more |
| 🔧 **HTTP Method Fuzzing** | GET, POST, PUT, PATCH, DELETE, OPTIONS, TRACE, PROPFIND, MOVE, COPY, LOCK, FAKEVERB |
| 📡 **Protocol Version Fuzzing** | HTTP/0.9, HTTP/1.0, HTTP/1.1, HTTP/2 |
| 🤖 **User-Agent Fuzzing** | Googlebot, Bingbot, Facebook crawler, WhatsApp, mobile UAs, internal scanners |
| 🔀 **Method Override Headers** | X-HTTP-Method-Override, X-Method-Override, X-HTTP-Method |
| 🔗 **Hop-by-Hop Abuse** | Connection header manipulation to strip proxy headers |
| 💀 **Cache Poisoning / WCD** | Web Cache Deception via static file extension appending |
| 🔤 **Unicode & Fullwidth** | Fullwidth slashes, overlong UTF-8, mixed encoding tricks |
| 🔠 **Case Switching** | UPPER, lower, Capitalized, Mixed case path variants |
| 🪞 **Referer Spoofing** | Spoofed Referer headers from localhost, Google, internal paths |
| ⏳ **Wayback Machine** | Check for archived snapshots of restricted pages |

## 📦 Installation

```bash
git clone https://github.com/eh-amish/ForbidBuster.git
cd ForbidBuster/
chmod +x forbidbuster.sh
```

### Dependencies

```bash
# Debian/Ubuntu
sudo apt install curl jq

# macOS
brew install curl jq
```

> **Note:** Unlike previous versions, ForbidBuster **no longer requires `figlet`** — the banner is fully self-contained.

## 🎯 Usage

```bash
./forbidbuster.sh [URL] [path]
```

### Examples

```bash
# Basic usage
./forbidbuster.sh https://example.com admin

# With subpath
./forbidbuster.sh https://example.com admin/index.php

# Server status page
./forbidbuster.sh https://example.com server-status

# Help menu
./forbidbuster.sh --help
```

## 📊 Output

ForbidBuster provides **color-coded responses** for instant visual feedback:

| Color | Meaning |
|---|---|
| 🟢 **Green** | `200 OK` — Potential bypass found! |
| 🔴 **Red** | `403 Forbidden` — Blocked |
| 🟡 **Yellow** | `405` / Other status codes |
| 🔵 **Cyan** | `301/302` Redirects |
| 🟣 **Purple** | `5xx` Server errors |

At the end of each scan, a **summary report** shows the total number of requests made and how many returned 200 OK.

## ⚠️ Disclaimer

This tool is intended for **authorized security testing and educational purposes only**. Always obtain proper authorization before testing any target. Unauthorized access to computer systems is illegal.

## 📄 License

This project is licensed under the MIT License.

---

<div align="center">

**Made with ⚡ by [@eh-amish](https://github.com/eh-amish)**

</div>
