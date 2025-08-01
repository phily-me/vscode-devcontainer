# Development commands for the project

# Start the Nix development environment
dev:
    @echo "🎯 Starting Nix development environment..."
    @nix-develop

# Run a command in the Nix development environment
dev-run *ARGS:
    @echo "▶️  Running in Nix environment: {{ARGS}}"
    @nix-develop {{ARGS}}

# Show available tools in the development environment
dev-tools:
    @nix-develop bash -c "echo '📦 Available development tools:' && echo '• Node.js:' \$(node --version) && echo '• Deno:' \$(deno --version | head -1) && echo '• Python:' \$(python --version) && echo '• uv:' \$(uv --version) && echo '• Just:' \$(just --version) && echo '• Git:' \$(git --version) && echo '• GitHub CLI:' \$(gh --version | head -1)"

# Test the development environment setup
dev-test:
    @echo "🧪 Testing development environment..."
    @nix-develop bash -c "node --version && deno --version && python --version && uv --version && just --version && git --version && gh --version"

# Clean up any leftover Docker containers/volumes
clean:
    @echo "🧹 Cleaning up Docker resources..."
    @docker container prune -f || true
    @docker volume prune -f || true

# Show help
help:
    @echo "📚 Available commands:"
    @just --list