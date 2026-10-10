# home-manager config for adam, loaded from darwin.nix via
# home-manager.users.adam.
{ pkgs, ... }:
{
  # Used for backwards compatibility, read the release notes before changing.
  home.stateVersion = "26.05";

  home.sessionVariables = {
    # --wait makes zed block until the file is closed, as git and other
    # tools expect from an editor.
    EDITOR = "zed --wait";
    VISUAL = "zed --wait";
    BAT_THEME = "ansi";
    BAT_STYLE = "plain";
    MANPAGER = "sh -c 'col -b | bat -l man -p'";
    HOMEBREW_NO_EMOJI = "1";
    HOMEBREW_NO_ENV_HINTS = "1";
  };

  programs.fish = {
    enable = true;

    # Prepended to PATH, first one wins. Global instead of universal, so
    # nothing lingers in fish_variables. Fish puts /etc/paths (/usr/bin, ...)
    # first in login shells, so the Nix profiles are listed here to move them
    # back in front of macOS's own git, vim, etc. /opt/homebrew/bin only holds
    # cask CLIs (brew, zed, ...) now, so it goes last.
    shellInit = ''
      set -g fish_user_paths \
        ~/.local/bin \
        ~/.cargo/bin \
        ~/.nix-profile/bin \
        /etc/profiles/per-user/$USER/bin \
        /run/current-system/sw/bin \
        /nix/var/nix/profiles/default/bin \
        /opt/homebrew/bin
    '';

    # Previously conf.d/fish_frozen_theme.fish, written by fish 4.3.
    interactiveShellInit = ''
      set -g fish_color_autosuggestion brblack
      set -g fish_color_cancel -r
      set -g fish_color_command normal
      set -g fish_color_comment red
      set -g fish_color_cwd green
      set -g fish_color_cwd_root red
      set -g fish_color_end green
      set -g fish_color_error brred
      set -g fish_color_escape brcyan
      set -g fish_color_history_current --bold
      set -g fish_color_host normal
      set -g fish_color_host_remote yellow
      set -g fish_color_normal normal
      set -g fish_color_operator brcyan
      set -g fish_color_param cyan
      set -g fish_color_quote yellow
      set -g fish_color_redirection cyan --bold
      set -g fish_color_search_match white --background=brblack
      set -g fish_color_selection white --bold --background=brblack
      set -g fish_color_status red
      set -g fish_color_user brgreen
      set -g fish_color_valid_path --underline
      set -g fish_pager_color_completion normal
      set -g fish_pager_color_description yellow -i
      set -g fish_pager_color_prefix normal --bold --underline
      set -g fish_pager_color_progress brwhite --background=cyan
      set -g fish_pager_color_selected_background -r
    '';

    shellAliases = {
      ls = "eza";
      # An alias, not a function, so it only applies in interactive shells
      # (a cat function would also replace cat in scripts, breaking cat -e).
      cat = "bat";
      nix-deploy = "make -C ~/.dotfiles deploy";
      nix-update = "make -C ~/.dotfiles update";
    };

    shellAbbrs = {
      l = "ls";
      ll = "ls -l";
      la = "ls -la";
      gs = "git status";
      gd = "git diff";
      gl = "git log";
      gc = "git checkout";
      gb = "git branch";
      gco = "git commit";
    };

    functions = {
      fish_greeting = "";
      fish_title = "";
      c = {
        description = "expand ~/Code/";
        body = "cd $argv";
      };
    };

    completions.c = "complete --command c --exclusive --arguments '(__fish_complete_directories ~/Code/)'";

    # Was installed at runtime by fundle; pinned to the commit fundle had.
    plugins = [
      {
        name = "fish-fastdir";
        src = pkgs.fetchFromGitHub {
          owner = "tuvistavie";
          repo = "fish-fastdir";
          rev = "dddc6c13b4afe271dd91ec004fdd199d3bbb1602";
          hash = "sha256-iu7zNO7yKVK2bhIIlj4UKHHqDaGe4q2tIdNgifxPev4=";
        };
      }
    ];
  };

  programs.git = {
    enable = true;

    # Written to ~/.config/git/ignore, which git reads when core.excludesfile
    # is unset (replaces ~/.gitignore_global).
    ignores = [
      "*~"
      ".DS_Store"
      ".envrc"
      ".topsecret"
    ];

    settings = {
      user = {
        name = "Adam Agnaou";
        email = "adam@fapfap.se";
      };
      core.editor = "zed --wait";
      pager.branch = false;
      push.default = "current";
      pull.rebase = false;
      fetch.prune = true;
      init.defaultBranch = "main";
      color.ui = true;
    };

    # Installs git-lfs and sets up the filter.lfs config.
    lfs.enable = true;
  };

  # programs.fish turns this on, but it needs programs.man.package, which is
  # null on macOS (the system man is used).
  programs.man.generateCaches = false;

  programs.starship = {
    enable = true;
    # Starship has no global "no emoji" switch; this built-in preset swaps
    # every module's symbol for plain text. See `starship preset --list`.
    presets = [ "plain-text-symbols" ];
  };

  # Also hooks `mise activate` into fish.
  programs.mise = {
    enable = true;
    globalConfig.tools = {
      python = "latest";
      rust = "latest";
      uv = "latest";
    };
  };

  # Zed itself comes from the Homebrew cask. Settings and keymaps stay
  # mutable: on every switch these values are merged into Zed's own files
  # (and win), while changes made in Zed's UI to anything else are kept.
  programs.zed-editor = {
    enable = true;
    package = null;

    # Installed by Zed on startup if missing (GitHub themes come from
    # github-theme).
    extensions = [
      "fish"
      "git-firefly"
      "github-theme"
      "html"
      "log"
      "macos-classic"
      "make"
      "nix"
      "toml"
      "xml"
      "xy-zed"
    ];

    userSettings = {
      proxy = "";
      disable_ai = false;
      cli_default_open_behavior = "new_window";
      format_on_save = "on";
      tab_size = 2;
      base_keymap = "VSCode";
      ui_font_size = 18;
      buffer_font_size = 16.0;
      scroll_beyond_last_line = "off";
      theme = {
        mode = "system";
        light = "GitHub Light";
        dark = "GitHub Dark";
      };
      telemetry = {
        diagnostics = false;
        metrics = false;
      };

      project_panel.dock = "left";
      outline_panel.dock = "left";
      collaboration_panel.dock = "left";
      git_panel.dock = "left";

      lsp.vtsls = {
        settings = {
          typescript.updateImportsOnFileMove.enabled = "always";
          javascript.updateImportsOnFileMove.enabled = "always";
        };
        enable_lsp_tasks = true;
      };

      agent = {
        dock = "right";
        default_model = {
          effort = "high";
          enable_thinking = true;
          provider = "anthropic";
          model = "claude-sonnet-5";
        };
        favorite_models = [ ];
        model_parameters = [ ];
      };
      edit_predictions.provider = "none";
    };

    userKeymaps = [
      {
        context = "Workspace";
        bindings = {
          ctrl-tab = "pane::ActivateNextItem";
          ctrl-shift-tab = "pane::ActivatePreviousItem";
        };
      }
      {
        context = "Editor";
        bindings."cmd-/" = [
          "editor::ToggleComments"
          { advance_downwards = false; }
        ];
      }
    ];
  };

  # Ghostty itself comes from the Homebrew cask.
  programs.ghostty = {
    enable = true;
    package = null;
    settings = {
      font-size = 18;
      window-padding-x = 8;
      window-padding-y = 8;
      shell-integration-features = "ssh-env";
      background-opacity = "0.75";
    };
  };

  # The private key itself stays out of the repo. enableDefaultConfig is off
  # so the file holds only what's set here.
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings."*" = {
      IdentityFile = "~/.ssh/baggio";
      # Apple's ssh reads the key's passphrase from the login keychain
      # (stored once with `ssh-add --apple-use-keychain ~/.ssh/baggio`) and
      # loads the key into the agent, so there's no passphrase prompt.
      UseKeychain = "yes";
      AddKeysToAgent = "yes";
      # UseKeychain only exists in Apple's ssh; other builds would reject the
      # whole file without this.
      IgnoreUnknown = "UseKeychain";
    };
  };

  # Podman runs containers in a Linux VM ("machine"). Deploys create the
  # machines declared here and delete any others, so the existing default
  # machine is declared by name. It isn't auto-started: the module's
  # watchdog would restart it within 30s of every stop. Start it with
  # `podman machine start` when needed.
  services.podman = {
    enable = true;
    useDefaultMachine = false;
    machines.podman-machine-default.autoStart = false;
  };
}
