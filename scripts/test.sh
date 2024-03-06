#!/usr/bin/env bash
t3ize_sh="${0%/*}/../lib/t3ize.sh"
source "$t3ize_sh"

info "information message"
debug "debug message"
yak "yak message"
warn "gonna run silly thing"
run "uptime"
