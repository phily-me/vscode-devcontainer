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

## Architecture Notes
- This is primarily a template/configuration repository
- No application code exists - it's meant to be cloned and used as a starting point
- The setup supports full-stack development with JavaScript/TypeScript (Node.js/Deno), Python, and MongoDB