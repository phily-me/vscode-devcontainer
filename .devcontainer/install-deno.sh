#!/bin/bash
set -euo pipefail

# configuration
org=denoland
app=deno
version="v2.2.1"
archive=zip

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

filename="$app-${arch_str}-${os_str}.$archive"
echo $filename
url="https://github.com/$org/$app/releases/download/${version}/${filename}"

echo "Downloading $url..."
curl --proto '=https' --tlsv1.2 -LsSf "$url" -o "$filename"

tmp_dir="/tmp/$app-$(date +%s)"
echo "Extracting binaries to /usr/local/bin"
mkdir ${tmp_dir}

if [ "$archive" = "tar.gz" ]; then
  tar -xzf "$filename" -C ${tmp_dir}
elif [ "$archive" = "zip" ]; then
  unzip "$filename" -d ${tmp_dir}
else
  echo "Unsupported archive format: $archive"
  exit 1
fi

find ${tmp_dir} -type f -exec mv {} /usr/local/bin/ \;

echo "Setting executable permissions..."
find /usr/local/bin/ -type f -exec chmod +x {} \;

echo "Cleaning up..."
rm "$filename"

echo "Installation complete."
