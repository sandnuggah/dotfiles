if not functions -q fundle; eval (curl -sfL https://git.io/fundle-install); end

fundle plugin 'tuvistavie/fish-fastdir'
fundle init

set -Up fish_user_paths /bin
set -Up fish_user_paths /sbin
set -Up fish_user_paths /usr/bin
set -Up fish_user_paths /usr/sbin
set -Up fish_user_paths /usr/local/bin
set -Up fish_user_paths /usr/local/sbin
set -Up fish_user_paths /opt/homebrew/bin
set -Up fish_user_paths ~/.cargo/bin
set -Up fish_user_paths ~/.local/bin
set -Up fish_user_paths ~/Library/Android/sdk/platform-tools
set -Up fish_user_paths ~/Library/Android/sdk/tools/bin

set -x EDITOR zed
set -x BAT_THEME 'ansi'
set -x BAT_STYLE 'plain'
set -x GIT_PAGER 'bat'
set -x MANPAGER "sh -c 'col -b | bat -l man -p'"
set -x HOMEBREW_NO_EMOJI 1
set -x HOMEBREW_NO_ENV_HINTS 1

alias ls 'eza'

abbr -a l 'ls'
abbr -a ll 'ls -l'
abbr -a la 'ls -la'
abbr -a gs 'git status'
abbr -a gd 'git diff'
abbr -a gl 'git log'
abbr -a gc 'git checkout'
abbr -a gb 'git branch'
abbr -a gco 'git commit'

# Direnv
eval (direnv hook fish)

# Starship
eval (starship init fish)
