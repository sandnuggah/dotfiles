# dotfiles

Simple macOS Tahoe dotfiles using [nix-darwin](https://github.com/nix-darwin/nix-darwin) and [stow](http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html).

## Prerequisites

[lix](https://lix.systems/install/) and [homebrew](https://brew.sh).

## Installation

```sh
$ git clone https://github.com/sandnuggah/dotfiles.git ~/.dotfiles && cd .dotfiles/nix-darwin
$ make deploy
# ...will install for a few minutes. Later, `stow` the packages you're interested in
$ cd .. && stow fish git starship
```
