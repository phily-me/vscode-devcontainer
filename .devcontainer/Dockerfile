FROM ubuntu:latest

# Install essential tools for Nix installer
RUN apt-get update && apt-get install -y curl direnv sudo xz-utils git ca-certificates && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Nix using Determinate Systems installer with container-optimized settings
# - Uses --init none for containers without systemd
# - Disables sandbox for container compatibility 
# - Enables flakes and nix-command for modern Nix features
# - Supports multi-architecture builds (amd64, arm64)
RUN curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install linux \
    --extra-conf "sandbox = false" \
    --extra-conf "experimental-features = nix-command flakes" \
    --init none \
    --no-confirm

# Add Nix to PATH for all users
ENV PATH="${PATH}:/nix/var/nix/profiles/default/bin"

# Copy project files
COPY flake.nix flake.lock* devshell.nix .envrc /workspace/

# Set working directory  
WORKDIR /workspace

# Allow direnv for this directory
RUN direnv allow

# Build the development environment to warm up the cache
RUN nix develop --command echo "Development environment ready"

# Set the default command to bash (VS Code will manage the shell)
CMD ["/bin/bash"]