# The Baggio system: Nix settings, packages, users, macOS defaults and
# Homebrew apps. Loaded from flake.nix; per-user config lives in home.nix.
{ pkgs, ... }:
{
  nixpkgs.hostPlatform = "aarch64-darwin";

  nix = {
    settings.experimental-features = "nix-command flakes";

    # Weekly garbage collection (Sunday 03:00) and store deduplication.
    # Remove both if you use Determinate Nix (nix.enable = false).
    gc = {
      automatic = true;
      interval = [
        {
          Weekday = 0;
          Hour = 3;
          Minute = 0;
        }
      ];
      options = "--delete-older-than 30d";
    };
    optimise.automatic = true;
  };

  networking.hostName = "Baggio";

  environment = {
    # List packages installed in system profile. To search by name, run:
    # $ nix search nixpkgs wget
    systemPackages = with pkgs; [
      bat
      cmatrix
      coreutils-prefixed # g-prefixed (gls, gcat, ...), same as Homebrew's coreutils
      eza
      git
      htop
      httpie
      mise
      ssh-copy-id
      starship
      vim
    ];

    variables.HOMEBREW_NO_ANALYTICS = "1";
  };

  programs = {
    # Installs fish from nixpkgs and adds it to /etc/shells.
    fish.enable = true;

    # Installs direnv (with nix-direnv) and hooks it into fish.
    direnv.enable = true;
  };

  # Let nix-darwin manage adam's login shell.
  # Never leave "adam" in knownUsers without the users.adam block below:
  # nix-darwin treats that as a request to delete the account.
  users = {
    knownUsers = [ "adam" ];
    users.adam = {
      uid = 501;
      home = "/Users/adam";
      shell = pkgs.fish;
    };
  };

  # fish, git and starship config for adam (see home.nix).
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    # Move aside, rather than fail on, files home-manager would replace.
    backupFileExtension = "before-home-manager";
    users.adam = import ./home.nix;
  };

  security.pam.services.sudo_local.touchIdAuth = true;

  system = {
    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    stateVersion = 6;

    primaryUser = "adam";

    defaults = {
      dock = {
        autohide = true;
        mru-spaces = false;
        orientation = "left";
        static-only = true;
        tilesize = 74;
      };
      loginwindow.GuestEnabled = false;
      NSGlobalDomain.AppleScrollerPagingBehavior = true;
      # Needs Full Disk Access for the terminal running darwin-rebuild.
      universalaccess.reduceMotion = true;
      WindowManager.GloballyEnabled = true;
    };
  };

  # Homebrew handles only GUI apps and App Store apps;
  # command-line tools come from nixpkgs above.
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
      linkding-for-Safari = 6763596375;
      Numbers = 361304891;
      Pages = 361309726;
      RedirectWeb = 1571283503;
      Tailscale = 1475387142;
      wBlock = 6746388723;
    };
  };
}
