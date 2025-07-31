#!/bin/bash
set -e

# Install Nix package manager with flakes support
echo "Installing Nix with flakes support..."

# Check if running as root and switch to node user if so
if [ "$(id -u)" -eq 0 ]; then
    echo "Installing Nix as node user (non-root)..."
    # Create nix config directory first
    mkdir -p /etc/nix
    chown -R node:node /etc/nix
    
    # Enable experimental features (flakes and nix-command) before installation
    echo "experimental-features = nix-command flakes" > /etc/nix/nix.conf
    echo "sandbox = false" >> /etc/nix/nix.conf
    echo "filter-syscalls = false" >> /etc/nix/nix.conf
    
    # Run the installation as the node user
    su - node -c "curl -L https://nixos.org/nix/install | sh -s -- --no-daemon"
    
    # Add Nix to PATH for all users by updating system profile
    echo 'if [ -e /home/node/.nix-profile/etc/profile.d/nix.sh ]; then' >> /etc/bash.bashrc
    echo '  . /home/node/.nix-profile/etc/profile.d/nix.sh' >> /etc/bash.bashrc
    echo 'fi' >> /etc/bash.bashrc
    
    # Also add to zsh if it exists
    if [ -f /etc/zsh/zshrc ]; then
        echo 'if [ -e /home/node/.nix-profile/etc/profile.d/nix.sh ]; then' >> /etc/zsh/zshrc
        echo '  . /home/node/.nix-profile/etc/profile.d/nix.sh' >> /etc/zsh/zshrc
        echo 'fi' >> /etc/zsh/zshrc
    fi
    
    # Test installation as node user
    su - node -c "source /home/node/.nix-profile/etc/profile.d/nix.sh && nix --version"
else
    # Running as regular user
    # Create nix config directory first
    mkdir -p ~/.config/nix
    
    # Enable experimental features (flakes and nix-command) before installation
    echo "experimental-features = nix-command flakes" > ~/.config/nix/nix.conf
    echo "sandbox = false" >> ~/.config/nix/nix.conf
    echo "filter-syscalls = false" >> ~/.config/nix/nix.conf
    
    # Install Nix using single-user mode
    curl -L https://nixos.org/nix/install | sh -s -- --no-daemon
    
    # Source the nix profile to make nix available immediately
    source ~/.nix-profile/etc/profile.d/nix.sh
    
    # Verify installation
    nix --version
fi

echo "Nix installation completed with flakes support enabled"