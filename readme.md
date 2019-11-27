# dotfiles

[![Anarchism](https://img.shields.io/badge/anarchism-Ⓐ-000000.svg)](https://en.wikipedia.org/wiki/Anarchism)
[![Socialism](https://img.shields.io/badge/socialism-★-ff0000.svg)](https://en.wikipedia.org/wiki/Socialism)
![Ideology passing](https://img.shields.io/badge/ideology-passing-brightgreen.svg)

Simple macOS Catalina dotfiles using [stow](http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html).

## Installation

```sh
$ git clone https://github.com/sandnuggah/dotfiles.git ~/.dotfiles && cd .dotfiles
$ git submodule init
$ git submodule update
$ sh install
# ...will install for a few minutes. Later, `stow` the packages you're interested in
$ stow docker fish git kitty starship vscode
```
