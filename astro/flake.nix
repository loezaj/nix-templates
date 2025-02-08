# NOTE: installing the prettier plugin for astro seemed impossible with nix.
# you will have to install `prettier-plugin-astro` in your project as a
# dev dependency if you want to use prettier with astro
# $ pnpm add -D prettier-plugin-astro

# NOTE: the astro-language-server requires typescript to work
# make sure to add typescript as a dev dependency in your project
# $ pnpm add -D typescript
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      utils,
    }:
    utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShell =
          with pkgs;
          mkShell {
            buildInputs = [
              nodejs_23
              pnpm_10
              astro-language-server # Astro LSP
              typescript-language-server # JS & TS LSP
              vscode-langservers-extracted # HTML & CSS LSP
              nodePackages.prettier # formatter
            ];
          };
      }
    );
}
