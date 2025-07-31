#!/bin/bash
set -e

# Install Just command runner
echo "Installing Just command runner..."

# Get the latest version of Just
JUST_VERSION=$(curl -s https://api.github.com/repos/casey/just/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')

# Determine architecture
ARCH=$(uname -m)
case $ARCH in
  x86_64)
    ARCH="x86_64"
    ;;
  aarch64|arm64)
    ARCH="aarch64"
    ;;
  *)
    echo "Unsupported architecture: $ARCH"
    exit 1
    ;;
esac

# Download and install Just
JUST_URL="https://github.com/casey/just/releases/download/${JUST_VERSION}/just-${JUST_VERSION}-${ARCH}-unknown-linux-musl.tar.gz"
echo "Downloading Just from: $JUST_URL"

curl -L "$JUST_URL" | tar -xz -C /tmp
mv /tmp/just /usr/local/bin/just
chmod +x /usr/local/bin/just

echo "Just ${JUST_VERSION} installed successfully"
just --version