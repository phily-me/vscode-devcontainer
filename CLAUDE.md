# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a VS Code DevContainer configuration repository that provides a multi-language development environment. It sets up a containerized environment with Node.js, Deno, MongoDB, and Python (via uv) for development workflows.

## Development Environment

### Container Setup
- Uses `.devcontainer/devcontainer.json` for VS Code DevContainer configuration
- MongoDB runs as a service via `docker-compose.yml`
- Custom Dockerfile extends `mcr.microsoft.com/devcontainers/javascript-node:1-22-bookworm`

### Available Tools
- **Node.js**: Pre-installed in the base image
- **Deno v2.2.1**: Installed via `.devcontainer/install-deno.sh`
- **uv v0.6.2**: Python package manager installed via `.devcontainer/install-uv.sh`
- **Nix**: Package manager with flakes support installed via `.devcontainer/install-nix.sh`
- **Just**: Command runner installed via `.devcontainer/install-just.sh`
- **MongoDB**: Available via mongosh and database tools
- **GitHub CLI**: Available through devcontainer features

### Post-Creation Setup
The `.devcontainer/post-container-creation.sh` script configures:
- Shell completions for uv and deno
- `UV_LINK_MODE=copy` environment variable

## VS Code Extensions
The devcontainer automatically installs:
- `mongodb.mongodb-vscode` - MongoDB integration
- `esbenp.prettier-vscode` - Code formatting
- `ms-python.python` - Python support
- `ms-python.debugpy` - Python debugging
- `charliermarsh.ruff` - Python linting
- `jnoortheen.nix-ide` - Nix language support
- `skellock.just` - Justfile syntax highlighting

## MongoDB Connection
- MongoDB service runs on default port 27017
- No authentication configured by default
- Database data persists in `mongodb-data` Docker volume

## Dependency Management
- **Renovate**: Configured in `renovate.json` to automatically update dependencies
  - Monitors Deno and uv versions in installation scripts
  - Tracks MongoDB tools version in Dockerfile
  - Updates Docker images in docker-compose.yml and Dockerfile
  - Runs monthly with "dependencies" label

## Docker Registry
Pre-built images are automatically published to GitHub Container Registry for faster startup:
- **Registry**: `ghcr.io/phily-me/vscode-devcontainer`
- **Tags**: `latest` (main branch), `v0.1`, `v0.2`, etc.
- **Platforms**: `linux/amd64`, `linux/arm64`

### Usage Options
1. **Pre-built Image** (faster startup):
   - Uncomment the `"image"` line in `devcontainer.json`
   - Comment out `"dockerComposeFile"` and `"service"` lines
   
2. **Local Build** (more customizable):
   - Keep current configuration (default)
   - Allows modifications to Dockerfile and installation scripts

## Architecture Notes
- This is primarily a template/configuration repository
- No application code exists - it's meant to be cloned and used as a starting point
- The setup supports full-stack development with JavaScript/TypeScript (Node.js/Deno), Python, MongoDB, and Nix-based project management
- Nix with flakes support enables reproducible development environments
- Just provides a convenient way to define and run project-specific commands
- Automated Docker builds ensure pre-built images are always up-to-date