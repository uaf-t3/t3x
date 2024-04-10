# Starship.rs

## [starship.rs](https://starship.rs/)

Starship is a customizable shell prompt. As part of the T3 RPi experience we want to improve the basic prompt.  The normal prompt of a RPi looks like:

- [ ] add default pi prompt image example 

T3X provides a quick way to install, configure, and setup starship using a tweaked theme. (TODO: link to original toml theme).

## Usage

```
t3x starship launch
```
- Installs starship systemwide (will prompt for sudo)
- Installs the T3X starship toml custom config in current user `~/.config/starship.toml`
- Installs a [Nerd Font](https://www.nerdfonts.com/) for current user in `~/.local/share/fonts/`.  This is required for the advanced prompt icons.
- TODO: Configures Pi Terminal to use that nerdfont


## TODO list for the launch
- [x] installs starship tool (system wide, needs sudo)
- [ ] installs the T3X starship toml configuration
- [ ] autolaunch: starship init script in `~/.bash.d`
- [x] nerdfont install script 
- [ ] Pi only: detect Pi and configure Pi terminal to use nerdfont
- [ ] bash-completion sanity check & setup
