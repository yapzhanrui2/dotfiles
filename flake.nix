{
  description = "Ray's macOS dotfiles";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";

    nix-darwin.url =
      "github:nix-darwin/nix-darwin/nix-darwin-26.05";

    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nix-homebrew,
      nixpkgs,
      ...
    }:
    let
      user = "zryy";
    in
    {
      darwinConfigurations.mac =
        nix-darwin.lib.darwinSystem {
          specialArgs = {
            inherit user;
          };

          modules = [
            ./configuration.nix
            nix-homebrew.darwinModules.nix-homebrew
          ];
        };
    };
}
