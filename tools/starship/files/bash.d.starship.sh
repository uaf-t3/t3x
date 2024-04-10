#!/bin/bash

# https://starship.rs/

if command -v starship &> /dev/null; then
  # echo "starship is installed"
  eval "$(starship init bash)"
fi

