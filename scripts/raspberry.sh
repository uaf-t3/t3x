#!/usr/bin/env bash

t3ize_sh="${0%/*}/../lib/t3ize.sh"
source "$t3ize_sh"

# run environment sanity checker first so we can use cowsay and figlet

figlet "raspberry" | lolcat

require_command "expect"
info "starting the raspberry default password sanity check"

$T3IZE_LIB_DIR/check_default_raspberry.expect $USER > /dev/null
if [ $? -eq 0 ]; then
  yak "good job: Default password of raspberry is not being used"
else
  boom "WARNING: Password is the default 'raspberry' this needs to be changed ASAP"
fi
