# The Baggio system: Nix settings, packages, users, macOS defaults and
# Homebrew apps. Loaded from flake.nix; per-user config lives in home.nix.
{ pkgs, ... }:
{
  nixpkgs.hostPlatform = "aarch64-darwin";

  nix = {
    # Without this nix-darwin installs its default CppNix as the system nix
    # and daemon. lixPackageSets.latest matches the Lix installer's version
    # (pkgs.lix lags behind).
    package = pkgs.lixPackageSets.latest.lix;

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
      htop
      httpie
      mas # App Store CLI, for `brew bundle upgrade` in make update
      ssh-copy-id
      vim
      # The Tailscale CLI from the App Store app, which keeps the CLI in step
      # with the app (pkgs.tailscale would run its own, older daemon).
      (writeShellScriptBin "tailscale" ''
        exec /Applications/Tailscale.app/Contents/MacOS/Tailscale "$@"
      '')
    ];

    # Adds fish to /etc/shells (programs.fish.enable alone doesn't).
    shells = [ pkgs.fish ];
  };

  programs = {
    # Installs fish from nixpkgs and sets up its system-wide config.
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
        show-recents = false;
        static-only = true;
        tilesize = 74;
        # Bottom-right hot corner: off (1 = no action).
        wvous-br-corner = 1;
      };
      finder = {
        FXPreferredViewStyle = "Nlsv"; # list view
        ShowPathbar = true;
      };
      hitoolbox.AppleFnUsageType = "Do Nothing";
      loginwindow.GuestEnabled = false;
      NSGlobalDomain = {
        AppleInterfaceStyle = "Dark";
        AppleScrollerPagingBehavior = true;
        InitialKeyRepeat = 25;
        KeyRepeat = 2;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSTableViewDefaultSizeMode = 3; # large sidebar icons
        "com.apple.trackpad.scaling" = 3.0;
      };
      # Needs Full Disk Access for the terminal running darwin-rebuild;
      # without it this write fails and aborts the rest of the switch.
      universalaccess.reduceMotion = true;
      WindowManager = {
        GloballyEnabled = true;
        AppWindowGroupingBehavior = false; # show one window at a time
        EnableStandardClickToShowDesktop = false; # only in Stage Manager
        HideDesktop = true;
        StageManagerHideWidgets = true;
      };
      CustomUserPreferences = {
        NSGlobalDomain.WebAutomaticSpellingCorrectionEnabled = false;
        "com.apple.finder".ShowRecentTags = false;
        # Hyperkey owns the caps lock remap, so don't use
        # system.keyboard.remapCapsLockTo* alongside it.
        "com.knollsoft.Hyperkey" = {
          capsLockRemapped = 2;
          executeQuickHyperKey = 1;
          hideMenuBarIcon = true;
          hyperFlags = 1966080; # cmd + ctrl + option + shift
          keyRemap = 1;
          launchOnLogin = true;
          quickHyperKeycode = 0;
          # Homebrew updates it (make update).
          SUEnableAutomaticChecks = false;
        };
      };
    };
  };

  # Homebrew handles only GUI apps and App Store apps;
  # command-line tools come from nixpkgs above.
  homebrew = {
    enable = true;

    # Deploys only install and remove apps; `make update` updates them.
    # "uninstall" (unlike "zap") keeps an app's data when it's removed from
    # the lists below, and also removes anything brew-installed by hand.
    onActivation = {
      cleanup = "uninstall";
      extraEnv.HOMEBREW_NO_ANALYTICS = "1";
    };

    # Points `brew bundle` at the generated Brewfile, for `make update`.
    global.brewfile = true;

    # Let `make update` also upgrade casks that normally update themselves
    # (Claude, Ghostty, Hyperkey, Keka, Signal, Waterfox, Zed); a plain
    # upgrade skips them. Deploys don't upgrade, so this only affects updates.
    greedyCasks = true;

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
