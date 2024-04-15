# (c) Dayne Broderson
# https://gist.github.com/dayne/a97a258b487ed4d5e9777b61917f0a72

function check_interactive() {
  if [[ $- = *i* ]];then
    return 0  # interactive
  else
    return 1  # non-interactive
  fi
}

function check_forward_ssh_agent() {
  if [[ ! -S ${SSH_AUTH_SOCK} ]]; then
    # no: agent forward detected
    return 1
  else
    # detected agent forward
    return 0
  fi
}

function check_ssh_agent() {
  if [ -f $HOME/.ssh-agent ]; then
    source $HOME/.ssh-agent > /dev/null
  else
    # no agent file
    return 1
  fi

  which lsof > /dev/null
  if [ $? != 0 ]; then
    echo "missing lsof - needed for ssh-agent managment - apt install lsof"
    exit 1
  fi
  # thanks to @craighurley for this improvement that works on OSX & Ubuntu fine
  lsof -p $SSH_AGENT_PID 2> /dev/null | grep -q ssh-agent
  return $?
}

function launch_ssh_agent() {
  ssh-agent > $HOME/.ssh-agent
  source $HOME/.ssh-agent
}

function add_keys_to_agent() {
  ssh-add -l > /dev/null
  if [ $? -eq 0 ]; then
    # ssh-agent already has keys loaded - skipping scan & load logic
    return 0
  fi
  # add ~/.ssh/id_rsa-${HOSTNAME} otherwise add all keys in .ssh
  # echo "adding ssh keys"
  test -f $HOME/.ssh/id_rsa-${HOSTNAME}.pub && ssh-add ${_/.pub}
  if [ $? -ne 0 ]; then
    for I in $HOME/.ssh/*.pub ; do
      if [ -f ${I} ]; then
        echo "adding key: ${I/.pub/}"
        ssh-add ${I/.pub/}
      fi
    done
  fi
}

function find_existing_or_launch_new_agent() {
  check_forward_ssh_agent
  if [ $? -ne 0 ]; then
    # no forwarded agent found - look locally
    check_ssh_agent
    if [ $? -ne 0 ];then
      echo no local or forward agent found, launch one
      #### killall ssh-agent # verify there aren't any error state/lost agents running
      launch_ssh_agent
    fi

    # add keys (only if interactive terminal) 
    if [[ $- = *i* ]];then
      # interactive terminal .. but make sure it isn't tmux first
      if [ "$TERM" = "screen" ] && [ -n "$TMUX" ]; then
        # tmux session - lets avoid key adding magic here
        return 0
      else
        add_keys_to_agent
      fi
    else
      # non-interactive
      return 0
    fi
  fi
}

find_existing_or_launch_new_agent
