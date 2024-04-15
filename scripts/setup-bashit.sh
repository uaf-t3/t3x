#!/usr/bin/bash
function info() { echo "$1"; sleep 0.3; } 
function boom() { echo "ERROR: $1"; sleep 1; exit 1; }
function depends() { 
  if $(command -v $1 > /dev/null); then
    info "Command dependancy available: $1"
  else
    boom "Error: script depends on $1" 
  fi
}

########

BASH_IT=$HOME/.bash_it
BASH_IT_TEMPLATE=$BASH_IT/template/bash_profile.template.bash
BASH_IT_BASHD="$HOME/.bash.d/bash_it.sh"

info "T3X - Bash It! Setup"
depends git

if [ ! -d "$HOME/.bash_it" ]; then
  info "Cloning bash-it to $HOME/.bash_it"
  git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
else
  info "Skipping git clone: $HOME/.bash_it exists already"
fi

if [ -d $(dirname $BASH_IT_BASHD) ]; then
  if [ -f "$BASH_IT_BASHD" ]; then
    info "Skipping profile configration, file exists: $BASH_IT_BASHD"
  else
    info "Configuring Bash It to launch from ~/.bash.d/bash_it.sh"
    sed "s|{{BASH_IT}}|$BASH_IT|" "$BASH_IT/template/bash_profile.template.bash" > $BASH_IT_BASHD
    #cp -v "$HOME/.bash_it/template/bash_profile.template.bash" "$BASH_IT_BASHD"
  fi
else
  info "WARNING: no .bash.d detected ... skipping adding bash it to profile"
  info "         To manually install run :  $BASH_IT_BASHD"
fi
