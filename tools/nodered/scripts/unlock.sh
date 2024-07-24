#!/usr/bin/env bash
source $(t3x -T)

# Define the path to the Node-RED settings file
SETTINGS_FILE="$HOME/.node-red/settings.js"
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null; pwd)

function nodered_restart_if_running
{
  if pgrep -x "node-red" >/dev/null; then
    echo "Outdated Node-RED is still running. Attempting to restart..."
    node-red-restart
    echo "Node-RED configuration updated. Please verify that Node-RED is running locally as intended."
  else
    echo "Node-RED configuration updated. It will be applied when Node-RED is started."
  fi
}

# tmp 1 = source, tmp 2 = destination
cp "$SETTINGS_FILE" "$SETTINGS_FILE.tmp1"
cp "$SETTINGS_FILE" "$SETTINGS_FILE.tmp2"

#check uihost not configured
if ! grep -q "^\s*uiHost:" "$SETTINGS_FILE.tmp1"; then
    info "uiHost not configured. Node-RED may already be unlocked."
fi

# Check if authentication is not enabled by t3x
if grep -q "/\*t3x_tag_pwAuth_begin" "$SETTINGS_FILE.tmp1" && grep -q "t3x_tag_pwAuth_end\*/" "$SETTINGS_FILE.tmp1"; then
    # uncomment the password auth section
    awk '/\/\*t3x_tag_pwAuth_begin/ {gsub(/.*/, "\t//t3x_tag_pwAuth_begin")}1' "$SETTINGS_FILE.tmp1" > "$SETTINGS_FILE.tmp2"
    cp "$SETTINGS_FILE.tmp2" "$SETTINGS_FILE.tmp1" #update source
    awk '/t3x_tag_pwAuth_end\*\// {gsub(/.*/, "\t//t3x_tag_pwAuth_end")}1' "$SETTINGS_FILE.tmp1" > "$SETTINGS_FILE.tmp2"
    cp "$SETTINGS_FILE.tmp2" "$SETTINGS_FILE.tmp1" #update source
else
    # preconfigured settings are not present
    boom "unable to enable password authentication. Aborting unlock..."
fi

#comment all uiHosts
awk '/^[[:space:]]*uiHost:/ {gsub(/^[[:space:]]*uiHost:/, "\t//uiHost:")}1' "$SETTINGS_FILE.tmp1" > "$SETTINGS_FILE.tmp2"
cp "$SETTINGS_FILE.tmp2" "$SETTINGS_FILE.tmp1" #update source

cp "$SETTINGS_FILE" "$SETTINGS_FILE.old" #backup copy
cp "$SETTINGS_FILE.tmp2" "$SETTINGS_FILE" #apply destination to primary config
rm $SETTINGS_FILE.tmp1 $SETTINGS_FILE.tmp2 #cleanup
bash "${SCRIPT_DIR}/nodered_restart_if_running.sh"