if not functions -q fundle; eval (curl -sfL https://git.io/fundle-install); end

fundle plugin 'tuvistavie/fish-kubectl'
fundle plugin 'tuvistavie/fish-fastdir'
fundle plugin 'barnybug-archive/docker-fish-completion'
fundle plugin 'decors/fish-docker-machine'
fundle init

set -Up fish_user_paths /bin
set -Up fish_user_paths /sbin
set -Up fish_user_paths /usr/bin
set -Up fish_user_paths /usr/sbin
set -Up fish_user_paths /usr/local/bin
set -Up fish_user_paths /usr/local/sbin
set -Up fish_user_paths ~/.cargo/bin
set -Up fish_user_paths ~/.flutter/bin
set -Up fish_user_paths ~/Library/Android/sdk/tools/bin
set -Up fish_user_paths ~/Library/Android/sdk/platform-tools
set -Up fish_user_paths /usr/local/go/bin
set -Up fish_user_paths ~/.pub-cache/bin

set -x EDITOR code
set -x BAT_THEME 'ansi'
set -x BAT_STYLE 'plain'
set -x GIT_PAGER 'bat'
set -x MANPAGER "sh -c 'col -b | bat -l man -p'"
set -x HOMEBREW_NO_EMOJI 1

alias ls 'exa'

abbr -a l 'ls'
abbr -a ll 'ls -l'
abbr -a la 'ls -la'
abbr -a dc 'docker-compose'
abbr -a gs 'git status'
abbr -a gd 'git diff'
abbr -a gl 'git log'
abbr -a gc 'git checkout'
abbr -a gb 'git branch'
abbr -a gco 'git commit'
abbr -a brewup 'brew update; and brew upgrade; and brew upgrade --cask; and brew cleanup;'

# Local config and secrets
source ~/.config/fish/local.fish
source ~/.config/fish/secrets.fish

# Completions
kitty + complete setup fish | source

# Direnv
eval (direnv hook fish)

# Nodenv
status --is-interactive; and source (nodenv init -|psub)

# Starship
eval (starship init fish)
