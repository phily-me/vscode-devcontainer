# VS Code DevContainer Template

A comprehensive VS Code DevContainer template supporting modern development workflows with Node.js, Deno, Python, Nix, Just, and MongoDB.

## 🚀 Quick Start

1. **Clone this repository**
   ```bash
   git clone https://github.com/phily-me/vscode-devcontainer.git
   cd vscode-devcontainer
   ```

2. **Open in VS Code**
   - Install the [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
   - Open the folder in VS Code
   - Click "Reopen in Container" when prompted

3. **Choose your setup**:
   - **Fast startup**: Use pre-built image (see [Usage Options](#usage-options))
   - **Customizable**: Keep default local build

## 🛠️ Included Tools

- **Node.js** - JavaScript/TypeScript runtime
- **Deno v2.2.1** - Modern JavaScript/TypeScript runtime  
- **Python with uv v0.6.2** - Fast Python package manager
- **Nix** - Reproducible package management with flakes support
- **Just** - Command runner for project automation
- **MongoDB** - Database with mongosh and tools
- **GitHub CLI** - Git workflow automation

## 📦 Usage Options

### Option 1: Pre-built Image (Recommended)
Fastest startup using pre-built images from GitHub Container Registry.

1. Edit `.devcontainer/devcontainer.json`
2. Uncomment line 7: `"image": "ghcr.io/phily-me/vscode-devcontainer:latest"`
3. Comment out lines 10-11: `"dockerComposeFile"` and `"service"`

### Option 2: Local Build
Build the container locally for maximum customization.

Keep the default configuration (no changes needed).

## 🏗️ Architecture

- **MongoDB**: Runs as a separate service via Docker Compose
- **Multi-platform**: Supports both AMD64 and ARM64 architectures
- **VS Code Extensions**: Automatically installs relevant extensions
- **Shell Integration**: Properly configured for both Bash and Zsh

## 📋 Available Images

Images are automatically built and published to GitHub Container Registry:

- `ghcr.io/phily-me/vscode-devcontainer:latest` - Latest from main branch
- `ghcr.io/phily-me/vscode-devcontainer:v0.2` - Latest stable release
- `ghcr.io/phily-me/vscode-devcontainer:v0.1` - Previous release

## 🔧 Customization

1. **Fork this repository**
2. **Modify the configuration**:
   - Edit `.devcontainer/Dockerfile` for system-level changes
   - Update `.devcontainer/devcontainer.json` for VS Code settings
   - Add custom installation scripts following the existing pattern
3. **Rebuild your container**

## 📝 License

This project is open source and available under the MIT License.

## 🤝 Contributing

Contributions are welcome\! Please feel free to submit issues and pull requests.
EOF < /dev/null