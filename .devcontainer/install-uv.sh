#!/bin/bash
set -euo pipefail

# Determine the operating system
os=$(uname -s | tr '[:upper:]' '[:lower:]')
case "$os" in
linux)
  os_str="unknown-linux-gnu"
  ;;
darwin)
  os_str="apple-darwin"
  ;;
*)
  echo "Unsupported OS: $os"
  exit 1
  ;;
esac

# Determine the architecture; use dpkg if available, otherwise uname -m
if command -v dpkg >/dev/null 2>&1; then
  arch=$(dpkg --print-architecture)
else
  arch=$(uname -m)
fi

case "$arch" in
amd64 | x86_64)
  arch_str="x86_64"
  ;;
arm64 | aarch64)
  arch_str="aarch64"
  ;;
i386 | i686)
  arch_str="i686"
  ;;
armhf | armv7l)
  if [ "$os_str" = "unknown-linux-gnu" ]; then
    arch_str="armv7-unknown-linux-gnueabihf"
  else
    arch_str="armv7"
  fi
  ;;
powerpc64)
  arch_str="powerpc64"
  ;;
powerpc64le)
  arch_str="powerpc64le"
  ;;
s390x)
  arch_str="s390x"
  ;;
*)
  echo "Unsupported architecture: $arch"
  exit 1
  ;;
esac

version="0.6.2"
filename="uv-${arch_str}-${os_str}.tar.gz"
url="https://github.com/astral-sh/uv/releases/download/${version}/${filename}"

echo "Downloading $url..."
curl --proto '=https' --tlsv1.2 -LsSf "$url" -o uv.tar.gz

tmp_dir="/tmp/uv-$(date +%s)"
echo "Extracting 'uv' and 'uvx' to /usr/local/bin"
mkdir ${tmp_dir}
tar -xzf uv.tar.gz -C ${tmp_dir}
find ${tmp_dir} -type f -name "uv*" -exec mv {} /usr/local/bin/ \;

echo "Setting executable permissions..."
chmod +x /usr/local/bin/uv /usr/local/bin/uvx

echo "Cleaning up..."
rm uv.tar.gz

echo "Installation complete."
