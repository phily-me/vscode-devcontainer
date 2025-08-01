{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    # Core development tools
    nodejs_22
    deno
    python312
    uv
    just
    
    # Git and GitHub tools  
    git
    gh
    
    # Database tools
    mongodb-tools
    
  ];

  shellHook = ''
    echo "🎉 Welcome to your Nix development environment!"
    echo ""
    echo "Available tools:"
    echo "  • Node.js $(node --version)"
    echo "  • Deno $(deno --version | head -n1)"
    echo "  • Python $(python --version)"
    echo "  • uv $(uv --version)"
    echo "  • Just $(just --version)"
    echo ""
    echo "💡 Tip: Use 'nix-search <package>' to find more tools"
    echo "💡 Tip: Use 'nix-install <package>' to install additional packages"
    echo ""
    
    # Set up environment variables
    export UV_LINK_MODE=copy
    export PYTHONPATH=""
  '';

  # Environment variables that should be set
  NIX_PATH = "nixpkgs=channel:nixos-unstable";
}