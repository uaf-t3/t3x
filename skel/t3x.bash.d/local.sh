# add $HOME/.local/bin to PATH
if [ -f $HOME/.local/bin ]; then
  if ! $(echo $PATH | grep ".local/bin" > /dev/null); then
    export PATH=$PATH:$HOME/.local/bin
  fi
fi
