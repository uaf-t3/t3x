#!/usr/bin/bash

# curl https://raw.github.com/uaf-t3/t3x/main/scripts/bootstrap.sh | bash -e

function agree() {
  while( true ); do
    echo -n "$1 : (y/n) : "
    read answer
    if [ $answer == "n" ]; then
      return 1;
    elif [ $answer == 'y' ]; then
      return 0;
    fi
    echo "invalid answer - provide a 'y' or a 'n'"
    sleep 0.5
  done
}

if $(ping -c 1 google.com > /dev/null); then
  echo "Internet detected"
else
  echo "Unable to ping google.com -- Are you connected to the internet?"
  sleep 1
  if $(ping -c 1 8.8.8.8 > /dev/null); then
    echo "Unable to ping 8.8.8.8 -- likely no internet!"
    sleep 1
    exit 1
  fi
fi

if ! command -v git > /dev/null ; then
  echo "Warning: missing git - installing now"
  sudo apt update && sudo apt install git && echo "git installed"
  if [ $? -eq 0 ]; then
    echo "Fixed: git installed. continuing"
  else
    echo "Fatal: unable to install git"
  fi
fi

if [ -d $HOME/t3x/.git ]; then
  echo "Success: t3x already available"
else
  echo "Clone: latest t3x to $HOME/t3x"
  # TODO: consider tie into a 'stable' 
  git clone https://github.com/uaf-t3/t3x.git > /dev/null
  if [ $? -eq 0 ]; then
    echo "Success: git clone of t3x completed"
  else
    echo "Fail: git clone of t3x failed."
    exit 1
  fi
fi

cd $HOME/t3x

T3X_BRANCH=$(git branch --show-current)
if [ "$T3X_BRANCH" == 'main' ]; then
  echo "Expected: t3x checkout is on main branch"
else
  echo "Warning: We are not on the t3x main branch.  We are on $T3X_BRANCH."
  agree "  Continue on within the context of $T3X_BRANCH branch?"
  if [ $? -eq 0 ]; then
    echo "  Ok! Carrying on with $T3X_BRANCH"
  else
    echo "  Recommend switching back to main branch with: git switch main"
  fi
fi

if git pull > /dev/null; then
  echo "Success: git pull"
else
  echo "Fail: git pull"
  agree "  Do you want to continue even though git pull failed?"
  if [ $? -eq 0 ]; then
    echo "  Ok!"
  else
    echo "Bye"
    exit 1
  fi
fi

# setup .bashrc setup with .bash.d
if $(grep "T3X.bash.d" $HOME/.bashrc  > /dev/null); then
  echo "Done: Detected .bash.d setup in .bashrc already"
else
  echo "Start: setup .bash.d up in .bashrc"
  echo -e '\n\n# T3X.bash.d - if interactive then do fancy setup stuff\nif [[ $- == *i* ]]; then\n  if [ -d $HOME/.bash.d ]; then\n    for I in $HOME/.bash.d/*.sh; do\n      source $I  \n    done\n  fi\nfi\n' >> ~/.bashrc
fi

# setup .bash.d folder
if [ ! -d $HOME/.bash.d ]; then
  echo "creating .bash.d folder"
  mkdir $HOME/.bash.d
fi

# add skel/t3x.bash.d to $HOME/.bash.d
echo "Start: adding skel/t3x.bash.d to ~/.bash.d"
for tfile in skel/t3x.bash.d/* ; do
  fname=$(basename $tfile)
  if [ ! -f $HOME/.bash.d/$fname ]; then
    cp -v $tfile $HOME/.bash.d/
  else
    if $(diff $tfile $HOME/.bash.d/$fname > /dev/null); then
      echo "  $fname exists and is same"
    else
      agree "  $fname different -- replace with t3x version?"
      if [ $? -eq 0 ]; then
        cp -v $tfile $HOME/.bash.d
      else
        echo "  skipping update of $fname"
      fi
    fi
  fi
done

echo "##############################################"
echo "          t3x bootstrap completed."
echo "        close the terminal and re-open it"
echo "##############################################"
