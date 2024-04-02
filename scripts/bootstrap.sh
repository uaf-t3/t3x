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

if ping -c 1 google.com > /dev/null; then
  echo "Internet detected"
  echo "Are you connected to the internet?"

fi

if ! command -v git > /dev/null ; then
  echo "missing git - installing now"
  sudo apt update && sudo apt install git && echo "git installed"
  if [ $? -eq 0 ]; then
    echo "git installed. continuing"
  else
    echo "unable to install git"
  fi
fi

if [ -d $HOME/t3x/.git ]; then
  echo "t3x already available"
else
  echo "cloning latest t3x to $HOME/t3x"
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
  echo "Good: on main branch"
else
  echo "Odd: We are not on the t3x main branch.  We are on $T3X_BRANCH."
  agree "Continue on within the context of $T3X_BRANCH branch?"
  if [ $? -eq 0 ]; then
    echo "Ok! Carrying on with $T3X_BRANCH"
  else
    echo "Recommend switching back to main branch with: git switch main"
  fi
fi

if git pull > /dev/null; then
  echo "git pull success"
else
  echo "git pull failed"
  agree "Do you want to continue even though git pull failed?"
  if [ $? -eq 0 ]; then
    echo "Ok!"
  else
    echo "Bye"
    exit 1
  fi
fi

# setup .bashrc setup with .bash.d
if $(grep .bash.d $HOME/.bashrc  > /dev/null); then
  echo "Detected .bash.d setup in .bashrc already"
else
  echo "Setting .bash.d up in .bashrc"
  echo -e '\n\n# If interactive then do fancy setup stuff\nif [[ $- == *i* ]]; then\n  if [ -d $HOME/.bash.d ]; then\n    for I in $HOME/.bash.d/*.sh; do\n      source $I  \n    done\n  fi\nfi\n' >> ~/.bashrc
fi

# setup .bash.d folder
if [ ! -d $HOME/.bash.d ]; then
  echo "creating .bash.d folder"
  mkdir $HOME/.bash.d
fi

# add skel/t3x.bash.d to $HOME/.bash.d
echo "adding skel/t3x.bash.d to ~/.bash.d"
cp -nvl skel/t3x.bash.d/* $HOME/.bash.d/
if [ $? -eq 0 ]; then
  echo "success: skel setup of .bash.d"
  echo "note: to have this take effect close and re-open the terminal"
else
  echo "fail: skel setup of .bash.d"
fi

echo "##############################################"
echo "t3x bootstrap completed.  close the terminal and re-open it"
