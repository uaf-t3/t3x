# T3X: Raspberry Pi Configuration & Maintenance Toolkit

T3X is a modular Bash-based toolkit designed to help educators and developers in the T3 Alliance community **configure, update, and maintain Raspberry Pi systems**. It is *not* an image-building tool, but a **post-flash setup and lifecycle management suite**.

> [!note] 
> **Safe, Secure, Accessible & Fun:** The core mission of this project is to provide an interface that allows T3 learners to fortify the security and configuration of their devices, protecting them from potential cyber threats. It's not just about providing technology; it's about delivering safe and secure technology. Doing this should also be fun and adaptable to the evolving needs of the T3 community and their projects.

## 🚀 Purpose

T3X standardizes and simplifies Raspberry Pi setup tasks across educational deployments. After flashing Raspberry Pi OS, T3X helps bring devices up to T3 standards:

- Installs core packages
- Hardens system security
- Applies standard T3 user configs
- Simplifies long-term maintenance

## 🧰 What T3X Does

- 🛠️ Configures freshly-flashed Pi OS devices
- 🔒 Applies security best practices
- 📦 Installs and manages standard packages
- 🧼 Fixes common bugs or misconfigurations
- 🔄 Updates itself from GitHub
- 🧪 Provides extra scripts for optional or dev tasks

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

Fully manual clone steps:
```
git clone https://github.com/uaf-t3/t3x
cd t3x
# Review the scripts starting with bootstrap.sh
./scripts/bootstrap.sh
```

Trust the T3X CHEESE lab team? Recommended easy method:
```
curl https://raw.githubusercontent.com/uaf-t3/t3x/main/scripts/bootstrap.sh | bash -e
```
Changes/Impacts of installing T3X
```.bashrc will be setup to include .bash.d/*.sh scripts
.bash.d/00-t3x.sh will setup $HOME/t3x/bin in user PATH
.bash.d/00-local.sh will ensure $HOME/.local/bin is in user PATH
.bash.d/(other).sh other scripts added for quality of life or when a user choosed to include/add a new feature that augments.
Beyond that the impacts of T3X will depend on what tools from it you run.
```

### 4. Use the toolkit
```bash
t3x help        # See available commands
t3x update      # Pull the latest version
t3x harden      # Apply system hardening rules
```

---

### Changes/Impacts of installing `T3X`

- `.bashrc` will be setup to include `.bash.d/*.sh` scripts
- `.bash.d/00-t3x.sh` will setup `$HOME/t3x/bin` in user `PATH`
- `.bash.d/00-local.sh` will ensure `$HOME/.local/bin` is in user `PATH`
- `.bash.d/(other).sh` other scripts added for quality of life or when a user chooses to include/add a new feature that augments.

## 🔧 How Subcommands Work

T3X uses a modular subcommand system like `git` or `kubectl`.
___

### Basic Usage
```bash
t3x [TOOL_NAME] [SUBCOMMAND] [OPTIONS]
```

Each command is defined as a `.t3x` file in:
```
tools/TOOL_NAME/TOOL_NAME.t3x
```

### Example Tools

#### `t3x pi`
Manages Pi-specific settings.
- `t3x pi update` – Updates the Pi
- `t3x pi wallpaper` – Sets a fun wallpaper
- `t3x pi lockdown` – Applies basic security lockdowns
  - Includes: `enable-wfw`, `ssh-disable`, `password-check`, `vnc-disable`

#### `t3x starship`
Ensures a custom Starship prompt setup.
- `t3x starship setup` – Installs & configures [starship.sh](https://starship.sh)
- `t3x starship launch` – Bonus launch features

### Tool Discovery
Run this to get started with some tools:
```bash
t3x --help
```
This will give you a normal help window plus a list of tools you can use!

---

## 👨‍💻 Advanced / Dev Tools

Explore the `tools/` and `scripts/` folders for advanced utilities like:
- SD card metadata dumping
- `bashrc` customization templates
- Cron examples and service helpers

---

## 🤝 Contributing

Contributions are welcome! Fork the repo, make changes, and submit a PR. Suggestions, bug reports, and script submissions from T3 partners are encouraged.

We welcome new ideas for t3x.  If you are new to git and GitHub we you might consider installing [gitflow-toolkit](https://github.com/mritd/gitflow-toolkit).

---

## 📄 License

We want this tool to be available for T3 sites and others to use under an open-source license. We picked the [Apache 2.0 license](https://choosealicense.com/licenses/apache-2.0/) with features that support:

| Permissions | Conditions | Limitations |
| ----------- | ---------- | ----------- | 
| ✅ Commercial Use | 📘 License notice | ❌ Liability |
| ✅ Distribution   | 📘 State changes | ❌ Trademark use |
| ✅ Modification   | 📝 Mark changes | ❌ Warranty |
| ✅ Patent use     | 📜             |               |
| ✅ Private use    | 🔇             |               |

See the `LICENSE.md` file for full terms.

---

## 🌐 More Info

- [T3 Alliance Website](https://t3-alliance.org)
- GitHub Issues: [Report bugs](https://github.com/uaf-t3/t3x/issues)
- [T3X GitHub](https://github.com/uaf-t3/t3x)
