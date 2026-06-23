# usage: source lib/helpers.sh
# Dayne's basic shell helpers
# Feel free to use as needed
# Originally developed for d.init

# ====== Globals & Modes ======
RESET='\033[0m'
BOLD='\033[1m'
BLINK='\033[5m'
GREEN='\033[32m'
YELLOW='\033[33m'
CYAN='\033[36m'
RED='\033[31m'
MAGENTA='\033[35m'

DRAMATIC="${DRAMATIC:-true}"
DRY_RUN="${DRY_RUN:-false}"

# ====== Core Logging ======
function info()   { echo -e "\e[32m${1}\e[0m"; }
function warn()   { echo -e "\e[93m${1}\e[0m"; sleep 0.5; }
function error()  { echo -e "\e[31m\e[1m${1}\e[0m"; sleep 1; }
function debug()  { [ "$T3X_DEBUG" != false ] && echo "# DEBUG: ${1}"; }
function boom()   { error "$1"; exit 1; }
function yak()    { info "$1"; sleep 1; }

# ====== Command & Network Checks ======
function got_command() {
  command -v "$1" &>/dev/null
}

function require_command() {
  if ! got_command "$1"; then
    [ "$2" != "" ] && echo "#>> POSSIBLE FIX: $2"
    boom "required command not found: $1"
  fi
}

function verify_internet() {
  if ping -c 1 google.com > /dev/null 2>&1 || ping -c 1 8.8.8.8 > /dev/null 2>&1; then
    echo "Internet detected"
    return 0
  else
    echo "Unable to ping the internet!"
    return 1
  fi
}



# ====== APT Utilities ======
function apt_update() {
  verify_internet && sudo apt update
}

function apt_install() {
  info "apt_install $1"
  dpkg -s "$1" &>/dev/null || sudo apt-get install -yq "$1"
}

# ====== Directory & File Helpers ======
function ensure_mkdir() {
  [[ ! -d $1 ]] && mkdir -p "$1" || echo "# >> exists: $1"
}

function cp_file() {
  [[ ! -f $2 ]] && cp -v "$1" "$2"
}

function require_root() {
  [[ $USER != 'root' ]] && boom "this script requires root - please run with sudo"
}


# ====== Run Helpers ======
function run_cmd() {
  info "#run START: $1"
  [ "$T3X_RUN" = "false" ] && info "# FAKE: $1" && return 0
  $1
  local RET=$?
  [[ $RET -eq 0 ]] && info "# DONE: $1" || warn "# FAIL: $1"
  return $RET
}

function sudo_run() {
  echo "SUDO run of: $1"; sleep 0.5; run_cmd "sudo $1"
}

function run_install_unless() {
  got_command "$2" && echo "# skip install: $1" || run_cmd "$1"
}


# ====== Interaction ======
function agree() {
  while true; do
    read -p "$1 (y/n): " answer
    case $answer in
      y) return 0;;
      n) return 1;;
      *) echo "Invalid answer. Type y or n.";;
    esac
  done
}

# ====== T3X Script Discovery ======
function t3x_scripts_list() {
  local dir="${1}/scripts"
  shopt -q nullglob
  old=$?
  shopt -s nullglob
  debug "listing scripts form dir: $dir"
  for script in "$dir"/*.sh; do
    basename "$script" .sh
  done
  (( old == 0 )) || shopt -u nullglob
}

function t3x_help_sub() {
  local base_dir="${1:-$SCRIPT_DIR}"
  local scripts_dir="$base_dir/scripts"
  mapfile -t scripts < <(t3x_scripts_list "$base_dir")
  for script in "${scripts[@]}"; do
    local f="$scripts_dir/$script.sh"
    [[ -f "$f" ]] || continue

    # Only include files that contain the T3XHELP: flag
    help=$(grep -m1 -F 'T3XHELP: ' "$f" | awk -F'T3XHELP: ' '{print $2; exit}')
    [[ -n "$help" ]] || continue
    printf " %-12s : " "$script" 
    echo "$help"
  done
}

# ====== Vegas Mode Utilities (Logging, State, Animations) ======

function parse_flags() {
  for arg in "$@"; do
    if [[ "$arg" == "--dry-run" ]]; then
      DRAMATIC=true
      export DRY_RUN=true
    fi
  done
}

function run() {
  if [ "$DRY_RUN" = true ]; then
    echo "[dry-run] $*"
  else
    "$@"
  fi
}

function parse_flags() {
  for arg in "$@"; do
    if [[ "$arg" == "--dramatic" ]]; then
      DRAMATIC=true
    elif [[ "$arg" == "--dry-run" ]]; then
      DRY_RUN=true
    fi
  done
}

function pause() {
  $DRAMATIC && sleep "${1:-0.5}"
}

function log() {
  local icon="💬"
  local indent="    "
  local first_line=true

  while IFS= read -r line || [[ -n "$line" ]]; do
    if [ "$first_line" = true ]; then
      echo -e "${CYAN}${icon} $line${RESET}"
      first_line=false
    else
      echo -e "${CYAN}${indent}$line${RESET}"
    fi
  done <<< "$1"
}



function success() {
  local icon="✅"
  local indent="    "
  local first_line=true

  while IFS= read -r line || [[ -n "$line" ]]; do
    if [ "$first_line" = true ]; then
      echo -e "${GREEN}${BOLD}${icon} $line${RESET}"
      first_line=false
    else
      echo -e "${GREEN}${indent}$line${RESET}"
    fi
  done <<< "$1"
}

function warn() {
  local icon="⚠️ "
  local indent="    "
  local first_line=true

  while IFS= read -r line || [[ -n "$line" ]]; do
    if [ "$first_line" = true ]; then
      echo -e "${YELLOW}${BLINK}${icon} $line${RESET}"
      first_line=false
    else
      echo -e "${YELLOW}${indent}$line${RESET}"
    fi
  done <<< "$1"
}

# 📦 For clean multi-line blocks (e.g. file contents or indented output)
function log_block() {
  local indent="    "
  while IFS= read -r line || [[ -n "$line" ]]; do
    echo -e "${CYAN}${indent}${line}${RESET}"
  done <<< "$1"
}

# Spinner setup
function spin() {
  local pid=$1
  local delay=0.1
  local spinstr='|/-\'
  tput civis  # hide cursor
  while kill -0 $pid 2>/dev/null; do
    for i in $(seq 0 3); do
      printf "\r${CYAN}🔄  Checking status ${spinstr:$i:1} ${RESET}"
      pause $delay
    done
  done
  printf "\r${CYAN}🔍  Status check complete!     ${RESET}\n"
  tput cnorm  # restore cursor
}

function dramatic_check() {
  local label="$1"
  local service="$2"
  printf "${CYAN}  🔎 ${label}: ${RESET}"
  $DRAMATIC && pause 0.5

  if systemctl is-active --quiet "$service"; then
    echo -e "${GREEN}${BOLD}ACTIVE${RESET}"
  else
    echo -e "${RED}${BOLD}INACTIVE${RESET}"
  fi
}

# 🔄 Spinner animation wrapper
function spinner_wrap() {
  local message="$1"
  shift
  local cmd=("$@")

  echo -ne "${CYAN}🔄  ${message}...${RESET}"

  "${cmd[@]}" &
  local pid=$!
  local spinstr='|/-\'
  local delay=0.1
  tput civis

  while kill -0 $pid 2>/dev/null; do
    for i in $(seq 0 3); do
      printf "\r${CYAN}🔄  ${message}... ${spinstr:$i:1} ${RESET}"
      pause $delay
    done
  done

  wait $pid
  local status=$?

  printf "\r${CYAN}✅  ${message} complete.     ${RESET}\n"
  tput cnorm
  return $status
}

function divider() {
  local char=${1:-─}
  local width=$(tput cols)
  printf "${CYAN}%*s${RESET}\n" "$width" '' | tr ' ' "$char"
}

function header() {
  local title="$1"
  divider
  printf "${BOLD}${MAGENTA}%*s\n" $(((${#title} + $(tput cols)) / 2)) "$title"
  divider
}

function type_header() {
  local text="$1"
  local delay="${2:-0.03}"
  local width=$(tput cols)
  local pad=$(( (width - ${#text}) / 2 ))
  printf "${MAGENTA}%*s" "$pad" ""
  for ((i=0; i<${#text}; i++)); do
    printf "${BOLD}${MAGENTA}${text:$i:1}${RESET}"
    sleep "$delay"
  done
  echo
}

function transition_to() {
  local label="$1"
  clear
  type_header "$label"
  divider
  pause
}

function print_mode_status() {
  for entry in "${TOOLS[@]}"; do
    IFS=":" read -r label state script <<< "$entry"
    if is_enabled "$state"; then
      echo -e "✅ ${GREEN}$label${RESET} is ENABLED"
    else
      echo -e "❌ ${RED}$label${RESET} is DISABLED"
    fi
  done
}

function check_service_status() {
  local label="$1"
  local service="$2"
  local result

  if systemctl is-active --quiet "$service"; then
    result="${GREEN}ACTIVE${RESET}"
  else
    result="${RED}INACTIVE${RESET}"
  fi

  printf "${CYAN}🔎 %-20s ${RESET}%b\n" "$label" "$result"
}

function log_kv() {
  local key="$1"
  local value="$2"
  local width=$(tput cols)
  local left="  ${BOLD}${key}${RESET}"
  local right="${value}"
  local space=$((width - ${#key} - ${#value} - 5))
  printf "%s%*s%s\\n" "$left" "$space" "" "$right"
}
