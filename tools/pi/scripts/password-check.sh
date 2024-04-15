#!/usr/bin/env bash
source $(t3x -T)

#require_command "expect"
if ! command -v expect > /dev/null; then
  echo "Missing expect. This is required... installing"
  apt_install expect
fi
info "starting the raspberry default password sanity check"

$T3X_LIB_DIR/check_default_raspberry.expect $USER > /dev/null

if [ $? -eq 0 ]; then
  echo -e "${GREEN}Good: Default password of raspberry is not being used${NC}"
  exit 0
else
  echo -e "${RED}WARNING: Password is the default 'raspberry' this needs to be changed ASAP${NC}"
  slow_lol "change the password now by typing: passwd"
  exit 1
fi
