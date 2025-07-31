#!/bin/bash
set -e

# Install Nix package manager with flakes support
echo "Installing Nix with flakes support..."

# Install Nix using the official installer with multi-user mode
curl -L https://nixos.org/nix/install | sh -s -- --daemon

# Enable experimental features (flakes and nix-command)
mkdir -p /etc/nix
echo "experimental-features = nix-command flakes" > /etc/nix/nix.conf

# Add Nix to PATH for all users by updating system profile
echo 'if [ -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]; then' >> /etc/bash.bashrc
echo '  . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' >> /etc/bash.bashrc
echo 'fi' >> /etc/bash.bashrc

# Also add to zsh if it exists
if [ -f /etc/zsh/zshrc ]; then
    echo 'if [ -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]; then' >> /etc/zsh/zshrc
    echo '  . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' >> /etc/zsh/zshrc
    echo 'fi' >> /etc/zsh/zshrc
fi

echo "Nix installation completed with flakes support enabled"