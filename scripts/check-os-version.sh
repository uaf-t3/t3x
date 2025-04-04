check_raspbian() {
  echo "check raspberryos: not yet done"
}

check_ubuntu() {
  echo "check ubuntu: not yet done"
}

check_debian() {
  echo "check debian: not yet done"
}

check_wsl() {
  if grep -qE "(Microsoft|WSL)" /proc/version &>/dev/null; then
    return 0
  fi
  return 1
}

check_os_release() {
  if [ -f /etc/os-release ]; then
     . /etc/os-release
     case "$ID" in
       raspbian)
         echo "Raspberry Pi OS detected"
         check_raspbian
         ;;
       ubuntu)
         echo "Ubuntu OS detected"
         check_ubuntu
         ;;
       debian)
         echo "Debian detected"
         check_debian
         ;;
       *)
         echo "Unknown Linux distribution: $ID"
         ;;
     esac
     return 0
  fi
  return 1
}

determine_os() {
  if check_wsl; then
    echo "WSL Environment detected"
    WSL_LINUX=true
  fi

  if check_os_release; then
    return
  fi
}

determine_os
