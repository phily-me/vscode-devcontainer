# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a VS Code DevContainer configuration repository that provides a hybrid multi-language development environment. It uses Ubuntu as the base for VS Code server compatibility, with Nix flakes available via Docker passthrough for reproducible development tools (Node.js, Deno, Python via uv, Just, etc.).

## Development Environment

### Container Setup
- **Base Container**: Ubuntu 22.04 for full VS Code server compatibility
- **Docker Passthrough**: Nix development environment runs in nested `nixos/nix` containers
- **Configuration**: Uses `.devcontainer/devcontainer.json` for VS Code DevContainer setup
- **Tools Access**: Development tools available via `just dev` command (Docker passthrough to Nix)
- **Port Forwarding**: All development ports (3000, 8000, 5000, etc.) automatically forwarded
- **Volume Mounting**: Project directory and Nix store properly mounted for persistence

### Available Tools

#### Base Container (Ubuntu)
- **Docker CLI**: For container management and Nix passthrough
- **Just**: Command runner for development workflows  
- **Git**: Version control
- **Standard Ubuntu utilities**: curl, wget, bash, etc.

#### Nix Development Environment (via Docker passthrough)
- **Node.js 22**: JavaScript runtime
- **Deno**: Modern TypeScript/JavaScript runtime  
- **Python 3.12**: Python runtime
- **uv**: Fast Python package manager
- **Just**: Command runner (also available in Nix shell)
- **Git**: Version control
- **GitHub CLI**: GitHub integration
- **MongoDB Tools**: Database utilities
- **Development utilities**: direnv, ripgrep, fd, bat, eza

### Development Workflow

#### Quick Start
1. Open repository in VS Code
2. Reopen in DevContainer when prompted
3. Use `just help` to see available commands
4. Run `just dev` to start Nix development environment
5. Use `just dev-run <command>` to run commands in Nix environment

#### Available Just Commands
- `just dev` - Start interactive Nix development shell
- `just dev-run <command>` - Run command in Nix environment
- `just dev-tools` - Show available development tools
- `just dev-test` - Test the development environment
- `just clean` - Clean up Docker resources
- `just help` - Show all available commands

#### Architecture Benefits
- **VS Code Compatibility**: Ubuntu base ensures full VS Code server support
- **Reproducible Environments**: Nix flakes provide consistent tool versions
- **CI/CD Friendly**: No Nix installation needed in CI - Docker handles everything
- **Fast Startup**: Base container starts immediately, Nix tools on-demand
- **Isolated Development**: Nix environment isolated in separate containers

## VS Code Extensions
The devcontainer automatically installs:
- `jnoortheen.nix-ide` - Nix language support
- `ms-python.python` - Python support
- `ms-python.debugpy` - Python debugging
- `charliermarsh.ruff` - Python linting
- `denoland.vscode-deno` - Deno TypeScript support
- `skellock.just` - Justfile syntax highlighting
- `ms-vscode.vscode-json` - JSON language support
- `mkhl.direnv` - Directory environment support

## Dependency Management
- **Renovate**: Configured in `renovate.json` to automatically update dependencies
  - Monitors tool versions in `flake.nix`
  - Updates Docker base image in Dockerfile
  - Runs monthly with "dependencies" label
- **Nix Flakes**: Provides reproducible dependency management
  - `flake.lock` pins all dependencies to specific versions
  - `nix flake update` updates to latest versions

## Docker Registry
Pre-built images are automatically published to GitHub Container Registry for faster startup:
- **Registry**: `ghcr.io/phily-me/vscode-devcontainer`
- **Tags**: `latest` (main branch), `v0.1`, `v0.2`, etc.
- **Platforms**: `linux/amd64`, `linux/arm64`

### Usage
- Open the repository in VS Code and it will prompt to reopen in the devcontainer
- The terminal starts with a regular bash shell in the Ubuntu container
- Use `just dev` to access the Nix development environment with all tools
- VS Code extensions work normally with the Ubuntu base container
- Development tools are accessed on-demand via Docker passthrough

## Architecture Notes
- This is primarily a template/configuration repository for hybrid development environments
- No application code exists - it's meant to be cloned and used as a starting point
- **Hybrid Design**: Combines Ubuntu base (VS Code compatibility) with Nix tools (reproducibility)
- **Docker-in-Docker**: Uses nested containers for Nix development environment
- **CI/CD Optimized**: No complex Nix installation in CI - standard Ubuntu base with Docker passthrough
- **Development Optimized**: Full tool reproducibility via Nix flakes when needed
- Just provides a convenient interface for accessing the Nix development environment
- Automated Docker builds ensure pre-built images are always up-to-date