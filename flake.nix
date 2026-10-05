{
  description = "The Baggio nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nix-darwin,
      nixpkgs,
      home-manager,
    }:
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#Baggio
      darwinConfigurations."Baggio" = nix-darwin.lib.darwinSystem {
        modules = [
          ./darwin.nix
          home-manager.darwinModules.home-manager
          # Set Git commit hash for darwin-version.
          { system.configurationRevision = self.rev or self.dirtyRev or null; }
        ];
      };

      # `nix fmt` formats the .nix files.
      formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.nixfmt;
    };
}
