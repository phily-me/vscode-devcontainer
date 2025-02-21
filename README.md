# VSCode devcontainer

This repository contains a VS Code DevContainer configuration for a development environment with the following features:

- Node.js
- Deno
- MongoDB (running as a service)
- uv (Python dependency management)

## Getting Started

1. **Clone the repository:**
  ```sh
  git clone <repository-url>
  cd <repository-directory>
  ```

2. **Open the repository in VS Code:**
  ```sh
  code .
  ```

3. **Reopen in Container:**
  - Press `F1` and select `Remote-Containers: Reopen in Container`.

## Features

### Node.js
Node.js is installed for server-side JavaScript development.

### Deno
Deno is included as a secure runtime for JavaScript and TypeScript.

### MongoDB
MongoDB is installed and running as a service for database management.

### uv
uv is a Python dependency management tool for managing virtual environments and dependencies.

## Configuration

The DevContainer is configured using the `.devcontainer` folder which includes:

- `Dockerfile`: Defines the custom image with the required tools.
- `devcontainer.json`: Configuration file for the DevContainer.

## Usage

- Start coding with Node.js, Deno, and MongoDB.
- MongoDB service is running and accessible within the container.

## Contributing

Feel free to submit issues and pull requests for improvements.

## License

This project is licensed under the MIT License.