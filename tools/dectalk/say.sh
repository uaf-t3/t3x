#!/usr/bin/bash
# dectalk wrapper script by Dayne
# why? to avoid having to put the rest of the shared library
# in other areas.  

DECTALK_LOCATION_DEFAULT=$HOME/.local/share/dectalk/dist
DECTALK_LOCATION=${DECTALK_LOCATION:-$DECTALK_LOCATION_DEFAULT}

if [ -f $DECTALK_LOCATION/say ]; then
  #cd $DECTALK_LOCATION || exit 1
  exec $DECTALK_LOCATION/say  "$@"
else
  echo "$DECTALK_LOCATION missing say" 
  exit 1
fi
