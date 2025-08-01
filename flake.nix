{
  description = "Multi-language development environment with Node.js, Deno, Python, MongoDB, and more";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          name = "pme-dev";

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
            
            # System utilities
            curl
            wget
            jq
            
            # Shell utilities
            bash
            zsh
            
            # Development utilities
            direnv
            ripgrep
            fd
            bat
            eza
          ];

          shellHook = ''
            # Set up environment variables
            export UV_LINK_MODE=copy

            # Enable shell completions
            eval "$(deno completions bash 2>/dev/null || true)"
            eval "$(uv generate-shell-completion bash 2>/dev/null || true)"
            
            # Create helpful aliases
            alias ll="eza -la"
            alias cat="bat"
            alias find="fd"
            alias grep="rg"
            
          '';
        };

        # Provide the default devShell for backward compatibility
        devShell = self.devShells.${system}.default;
      }
    );
}