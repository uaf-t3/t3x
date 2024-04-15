# slow_lol & other silly things : Dayne Broderson 2024

requirements_met=true

command -v pv > /dev/null     || requirements_met=false
command -v lolcat > /dev/null || requirements_met=false

if [ "${requirements_met}" = "true" ]; then
  function slow_lol() {
    msg="$1"
    msg_len=${#msg}
    twidth=$(tput cols)

    padding=$(( (twidth - msg_len ) / 2 ))
    printf "%*s" $padding ""
    echo "$msg" | pv -qL 22 | lolcat -S 33  -F 0.01
  }
else
  slow_lol() {
    echo "$msg"
  }
fi
