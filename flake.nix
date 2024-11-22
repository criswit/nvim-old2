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
        # Package up the config files
        neovimConfig = pkgs.stdenv.mkDerivation {
          name = "neovim-config";
          src = ./.; # This looks for config files in current directory
          
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
                lazy-nvim
                telescope-nvim
                plenary-nvim
                material-nvim
                # other plugins...
              ];
            };
          };
        };
      in {
        packages.default = nvim-pkg;
        
        apps.default = {
          type = "app";
          program = "${nvim-pkg}/bin/nvim";
        };
      }
    );
}
