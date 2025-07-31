#!/bin/bash

# Add shell completions for installed tools
cat <<EOF >> ~/.bashrc
eval "\$(uv generate-shell-completion bash)"
eval "\$(deno completions bash)"
export UV_LINK_MODE=copy
EOF

# Install Nix with flakes support (done at runtime for better compatibility)
echo "Installing Nix with flakes support..."
if ! command -v nix &> /dev/null; then
    /usr/local/bin/install-nix.sh
    echo "Nix installation completed. Please restart your shell or source the Nix profile."
else
    echo "Nix is already installed."
fi

echo "Post-installation script completed."
