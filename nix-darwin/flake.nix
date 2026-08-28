{
  description = "The Baggio nix-darwin system flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-26.05-darwin";
    nix-darwin.url = "github:nix-darwin/nix-darwin/nix-darwin-26.05";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs =
    {
      self,
      nix-darwin,
      nixpkgs,
    }:
    let
      configuration = { pkgs, ... }: {
        nix.settings.experimental-features = "nix-command flakes";
        nixpkgs.hostPlatform = "aarch64-darwin";
        # List packages installed in system profile. To search by name, run:
        # $ nix-env -qaP | grep wget
        environment.systemPackages = [
          pkgs.vim
        ];
        networking = {
          hostName = "Baggio";
        };
        programs = {
          fish.enable = true;
        };
        system = {
          # Set Git commit hash for darwin-version.
          configurationRevision = self.rev or self.dirtyRev or null;

          # Used for backwards compatibility, please read the changelog before changing.
          # $ darwin-rebuild changelog
          stateVersion = 6;

          primaryUser = "adam";
          defaults = {
            dock.autohide = true;
            NSGlobalDomain.AppleScrollerPagingBehavior = true;
            WindowManager.GloballyEnabled = true;
            dock.mru-spaces = false;
            dock.orientation = "left";
            dock.tilesize = 74;
            dock.static-only = true;
            loginwindow.GuestEnabled = false;
            universalaccess.reduceMotion = true;
          };
        };
        security = {
          pam.services.sudo_local.touchIdAuth = true;
        };
        environment = {
          variables.HOMEBREW_NO_ANALYTICS = "1";
        };
        homebrew = {
          enable = true;
          onActivation = {
            autoUpdate = true;
            cleanup = "zap";
            upgrade = true;
          };
          taps = [
            "chamburr/tap"
          ];
          brews = [
            "bat"
            "cmatrix"
            "coreutils"
            "direnv"
            "eza"
            "fish"
            "git"
            "htop"
            "httpie"
            "mise"
            "ssh-copy-id"
            "starship"
          ];
          casks = [
            "chamburr/tap/glance"
            "claude"
            "ghostty"
            "hyperkey"
            "keka"
            "openscad@snapshot"
            "sensiblesidebuttons"
            "signal"
            "ungoogled-chromium"
            "utm"
            "waterfox"
            "zed"
          ];
          masApps = {
            Consent-O-Matic = 1606897889;
            Finer = 6738301953;
            linkding-For-Safari = 6763596375;
            Numbers = 361304891;
            Pages = 361309726;
            RedirectWeb = 1571283503;
            Tailscale = 1475387142;
            wBlock = 6746388723;
            xSearch = 1579902068;
          };
        };
      };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#Baggio
      darwinConfigurations."Baggio" = nix-darwin.lib.darwinSystem {
        modules = [ configuration ];
      };
    };
}
