if [ -f "$HOME/t3x/VERSION" ]; then
  VERSION=$(cat "$HOME/t3x/VERSION")
else
  VERSION=" unknown"
fi

echo "t3x v$VERSION enabled"

if [ -d $HOME/t3x/bin ]; then
  if ! $(echo $PATH | grep "t3x/bin" >/dev/null); then
    export PATH=$PATH:$HOME/t3x/bin;
  fi
fi

# TODO: check to see if sanity has been run
