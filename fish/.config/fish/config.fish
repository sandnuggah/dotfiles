if not functions -q fundle; eval (curl -sfL https://git.io/fundle-install); end

fundle plugin 'tuvistavie/fish-kubectl'
fundle plugin 'tuvistavie/fish-fastdir'
fundle plugin 'barnybug-archive/docker-fish-completion'
fundle init

set -x PATH /bin $PATH
set -x PATH /sbin $PATH
set -x PATH /usr/bin $PATH
set -x PATH /usr/sbin $PATH
set -x PATH /usr/local/bin $PATH
set -x PATH /usr/local/sbin $PATH

set -x EDITOR code
set -x BAT_THEME 'ansi-dark'
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
abbr -a brewup 'brew update; and brew upgrade; and brew cask upgrade; and brew cleanup;'

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
