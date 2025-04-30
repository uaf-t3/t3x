# T3X: A Raspberry Pi Configuration & Maintenance Toolkit

T3X is a modular Bash-based toolkit designed to help educators and developers in the T3 Alliance community **configure, update, and maintain Raspberry Pi systems**. It is *not* an image-building tool, but a **post-flash setup and lifecycle management suite**.

> [!note] 
> **Safe, Secure, Accessible & Fun:** The core mission of this project is to provide an interface that allows T3 learners to fortify the security and configuration of their devices, protecting them from potential cyber threats. It's not just about providing technology; it's about delivering safe and secure technology. Doing this should also be fun and adaptable to the evolving needs of the T3 community and their projects.

---

## 🚀 Purpose

T3X standardizes and simplifies Raspberry Pi setup tasks across educational deployments. After flashing Raspberry Pi OS, T3X helps bring devices up to T3 standards:

- Installs core packages
- Hardens system security
- Applies standard T3 user configs
- Simplifies long-term maintenance

---

## 🧰 What T3X Does

- 🛠️ Configures freshly-flashed Pi OS devices
- 🔒 Applies security best practices
- 📦 Installs and manages standard packages
- 🧼 Fixes common bugs or misconfigurations
- 🔄 Updates itself from GitHub
- 🧪 Provides extra scripts for optional or dev tasks

---

## 📦 Repo Overview

| Path | Description |
|------|-------------|
| `bin/` | Main user-facing scripts like `t3x`, `t3x-install.sh`, and `t3x-update.sh` |
| `lib/` | Bash function libraries used by core tools |
| `scripts/` | Optional utilities for specific installs or fixes |
| `skel/t3x.bash.d/` | Default shell config snippets |
| `tools/` | Extra dev tools and subcommands (*.t3x files) |
| `README.md`, `LICENSE.md`, `VERSION`, `CHANGELOG.md` | Project metadata |

---

## ⚙️ Getting Started

### 1. Flash Raspberry Pi OS (e.g., Bookworm or Bullseye)
Use [Raspberry Pi Imager](https://www.raspberrypi.com/software/) or `rpi-imager`.

### 2. Boot the Pi and access a terminal
SSH or use a direct keyboard/mouse setup.

### 3. Install T3X

