{
  description = "Simple Neovim config wrapper";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        # Define runtime dependencies
        runtimeDeps = with pkgs; [
          go    # Add Go
          nodejs  # Add Node.js (includes npm)
          # any other dependencies you need
        ];

        neovimConfig = pkgs.stdenv.mkDerivation {
          name = "neovim-config";
          src = ./.;
          
          installPhase = ''
            mkdir -p $out
            cp -r ./init.lua $out/
            cp -r ./lua $out/
          '';
        };
        
        nvim-pkg = pkgs.neovim.override {
          configure = {
            customRC = ''
              lua << EOF
              vim.opt.rtp:prepend("${neovimConfig}")
              dofile("${neovimConfig}/init.lua")
              EOF
            '';
            packages.myVimPackage = {
              start = with pkgs.vimPlugins; [
                # your plugins...
              ];
            };
          };
        };

      in {
        packages.default = pkgs.symlinkJoin {
          name = "neovim-wrapped";
          paths = [ nvim-pkg ] ++ runtimeDeps;  # Include runtime deps in the final package
          buildInputs = [ pkgs.makeWrapper ];
          postBuild = ''
            wrapProgram $out/bin/nvim \
              --prefix PATH : ${pkgs.lib.makeBinPath runtimeDeps}
          '';
        };
        
        apps.default = {
          type = "app";
          program = "${self.packages.${system}.default}/bin/nvim";
        };
      }
    );
}
