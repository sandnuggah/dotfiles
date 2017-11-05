set -x PATH /bin $PATH
set -x PATH /sbin $PATH
set -x PATH /usr/bin $PATH
set -x PATH /usr/sbin $PATH
set -x PATH /usr/local/bin $PATH
set -x PATH /usr/local/sbin $PATH

set -x EDITOR atom
set -x HOMEBREW_GITHUB_API_TOKEN 1a5834b1a987e759d6980c0b518cf6a608207863

set -e fish_greeting

alias gs='git status'
alias gl='git log'
alias gb='git branches'
alias gd='git diff'

eval (direnv hook fish)
