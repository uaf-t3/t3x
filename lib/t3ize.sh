# to be sourced from the t3x (or other) commands

if [[ ! -n "_T3XIZE_LOADED" ]]; then
  return
else
  _T3XIZE_LOADED=true
fi

# figure out the location of this t3ize.sh file and include the common functions relative to it.
# this is a bit of a hack, but it works for now.
T3X_LIB_DIR=$( cd $( dirname "${BASH_SOURCE[0]}" ) && pwd )
T3X_DIR=$( cd $(dirname $BASH_SOURCE[0])/../ > /dev/null; pwd)
T3X_VERSION=$(cat $T3X_LIB_DIR/../VERSION)

# Want more messages in life? Try running like:
# T3X_DEBUG=true t3x 
if [ -z "$T3X_DEBUG" ]; then
  T3X_DEBUG=false
fi

source "$T3X_LIB_DIR/load.sh"

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
