# MacOS Configs

macOS Tahoe configs using [nix-darwin](https://github.com/nix-darwin/nix-darwin) and [home-manager](https://github.com/nix-community/home-manager).

## Prerequisites

[lix](https://lix.systems/install/) and [homebrew](https://brew.sh).

## Installation

```sh
$ git clone https://github.com/sandnuggah/dotfiles.git ~/.dotfiles
$ cd ~/.dotfiles
$ make deploy
```

The config is for the machine `Baggio` (user `adam`, uid 501); change the hostname and user in `flake.nix` and `darwin.nix` for another Mac.

## Usage

After the first deploy, run `nix-deploy` from any directory to apply changes.

To update nixpkgs, nix-darwin and home-manager, run `nix flake update` in `~/.dotfiles`, then `nix-deploy`. Homebrew apps update on every deploy.

## Layout

- `flake.nix`: inputs (nixpkgs, nix-darwin, home-manager) and how they fit together.
- `darwin.nix`: the system, i.e. Nix settings, packages, users, macOS defaults and Homebrew apps.
- `home.nix`: per-user config through home-manager (fish, git, starship, mise, Zed and Ghostty).
