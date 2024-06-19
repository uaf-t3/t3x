# Starship.rs

## [starship.rs](https://starship.rs/)

Starship is a customizable shell prompt. As part of the T3 RPi experience we want to improve the basic prompt.  The normal prompt of a RPi looks like:

- [ ] add default pi prompt image example 

T3X provides a quick way to install, configure, and setup starship using a tweaked theme. (TODO: link to original toml theme).

## Usage

```bash
t3x starship setup
```

- Installs starship systemwide (will prompt for sudo)
- Installs the T3X starship toml custom config in current user `~/.config/starship.toml`
- Installs and sets UTF-8 locales so that fonts can be displayed properly
- Installs a [Nerd Font](https://www.nerdfonts.com/) for current user in `~/.local/share/fonts/`.  This is required for the advanced prompt icons.
- Configures LxTerminal to use that nerdfont (default terminal)
- [ ] TODO: Install and configure cool-retro-terminal

```bash
t3x starship launch 
```
If starship already setup launches a new shell with a custom revision controlled T3X starship toml (for future hacking features).

- [ ] TODO: launch should spawn in fullscreen cool-retro-terminal 

