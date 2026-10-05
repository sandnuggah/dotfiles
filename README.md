# MacOS Configs

macOS Tahoe configs using [nix-darwin](https://github.com/nix-darwin/nix-darwin) and [home-manager](https://github.com/nix-community/home-manager).

## Prerequisites

- [lix](https://lix.systems/install/)
- [homebrew](https://brew.sh)

## Installation

```sh
$ git clone https://github.com/sandnuggah/dotfiles.git ~/.dotfiles
$ cd ~/.dotfiles
$ make bootstrap
```

The config is for the machine `Baggio` (user `adam`, uid 501); change the hostname and user in `flake.nix` and `darwin.nix` for another Mac.

## Usage

After the first install, run `nix-deploy` from any directory (or `make deploy` in the repo) to apply changes.

To update everything, run `nix-update` from any directory (or `make update` in the repo). It updates the flake inputs (nixpkgs, nix-darwin, home-manager), Homebrew and all its apps, including App Store apps, then deploys. Commit the changed `flake.lock` afterwards. Plain deploys don't update anything.

`nix fmt` formats the `.nix` files.

## Layout

- `flake.nix`: inputs (nixpkgs, nix-darwin, home-manager) and how they fit together.
- `darwin.nix`: the system, i.e. Nix settings, packages, users, macOS defaults and Homebrew apps.
- `home.nix`: per-user config through home-manager (fish, git, starship, mise, Zed and Ghostty).
