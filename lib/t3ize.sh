# to be sourced from the t3x (or other) commands

# Quick check if all the key variables are set already ... and return if so
if [[ -n "$T3X_SCRIPTS_DIR" && -n "$T3X_LIB_DIR" && -n "$T3X_SCRIPTS_DIR" ]]; then
  return
fi

# figure out the location of this t3ize.sh file and include the common functions relative to it.
# this is a bit of a hack, but it works for now.
T3X_LIB_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
T3X_DIR=$( cd "$(dirname "${BASH_SOURCE[0]}")/../" && pwd )
T3X_VERSION=$(cat $T3X_LIB_DIR/../VERSION)

# Want more messages in life? Try running like:
# T3X_DEBUG=true t3x 
if [ -z "$T3X_DEBUG" ]; then
  T3X_DEBUG=false
fi

#echo "T3X_LIB_DIR: $T3X_LIB_DIR"
# include lib/helpers.sh 
source "$T3X_LIB_DIR/helpers.sh"
source "$T3X_LIB_DIR/silly.sh"
debug "helpers loaded - yak() is available"


# the scripts directory is ../scripts from this folder
debug "T3X_LIB_DIR: $T3X_LIB_DIR/../scripts"
T3X_SCRIPTS_DIR="$T3X_LIB_DIR/../scripts"
if [ ! -d $T3X_SCRIPTS_DIR ]; then
    boom "T3X_SCRIPTS_DIR not found: $T3X_SCRIPTS_DIR"
else
    export T3X_SCRIPTS_DIR
    export T3X_LIB_DIR
    export T3X_VERSION
    debug "T3X_SCRIPTS_DIR: $T3X_SCRIPTS_DIR"
    debug "T3X_LIB_DIR: $T3X_LIB_DIR"
    debug "T3X_VERSION: $T3X_VERSION"
fi
