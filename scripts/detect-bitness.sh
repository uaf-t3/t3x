#!/usr/bin/env bash
set -euo pipefail

deb_arch="$(dpkg --print-architecture)"   # armhf (32-bit) or arm64 (64-bit) on Raspberry Pi OS
kernel_arch="$(uname -m)"                 # armv7l/armv6l (32-bit) or aarch64 (64-bit)

echo "Debian arch:  $deb_arch"
echo "Kernel arch:  $kernel_arch"

is_64bit=false
is_32bit=false

case "$deb_arch" in
  arm64)
    is_64bit=true
    ;;
  armhf)
    is_32bit=true
    ;;
  *)
    echo "Unsupported Debian architecture: $deb_arch" >&2
    exit 1
    ;;
esac

if $is_64bit; then
  echo "Detected: 64-bit Raspberry Pi OS"
elif $is_32bit; then
  echo "Detected: 32-bit Raspberry Pi OS"
fi
