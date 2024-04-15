# add t3x to $PATH
echo "t3x enabled"
if [ -d $HOME/t3x/bin ]; then
  if ! $(echo $PATH | grep "t3x/bin" >/dev/null); then
    export PATH=$PATH:$HOME/t3x/bin;
  fi
fi

# TODO: check to see if sanity has been run
