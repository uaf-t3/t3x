#!/usr/bin/env bash
# T3XHELP: Enable remote Node-RED access and password protection.
source $(t3x -T)

# Define the path to the Node-RED settings file
SETTINGS_FILE="$HOME/.node-red/settings.js"
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" > /dev/null; pwd)

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
    boom "could not enable password authentication (it may already be unlocked). Aborting unlock..."
fi

#comment all uiHosts
awk '/^[[:space:]]*uiHost:/ {gsub(/^[[:space:]]*uiHost:/, "\t//uiHost:")}1' "$SETTINGS_FILE.tmp1" > "$SETTINGS_FILE.tmp2"
cp "$SETTINGS_FILE.tmp2" "$SETTINGS_FILE.tmp1" #update source

cp "$SETTINGS_FILE" "$SETTINGS_FILE.old" #backup copy
cp "$SETTINGS_FILE.tmp2" "$SETTINGS_FILE" #apply destination to primary config
rm $SETTINGS_FILE.tmp1 $SETTINGS_FILE.tmp2 #cleanup
bash "${SCRIPT_DIR}/nodered_restart_if_running.sh"
