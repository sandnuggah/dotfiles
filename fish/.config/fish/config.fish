# Install fundle
if not functions -q fundle; eval (curl -sfL https://git.io/fundle-install); end

fundle plugin 'tuvistavie/fish-kubectl'
fundle plugin 'tuvistavie/fish-fastdir'
fundle plugin 'barnybug-archive/docker-fish-completion'
fundle init

# Paths
set -x PATH /bin $PATH
set -x PATH /sbin $PATH
set -x PATH /usr/bin $PATH
set -x PATH /usr/sbin $PATH
set -x PATH /usr/local/bin $PATH

# Abbreviations
abbr -a dc 'docker-compose'
abbr -a gs 'git status'
abbr -a gd 'git diff'
abbr -a gl 'git log'
abbr -a dmc 'docker-machine-connect'
abbr -a brewup 'brew update; and brew upgrade; and brew cleanup; and brew prune;'

# Editor
set -x EDITOR atom

# Load secrets (like GITHUB_API_TOKEN)
source ~/.config/fish/secrets.fish

# Load gcloud sdk paths
source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc

# Load direnv
eval (direnv hook fish)

# `bat` defaults
set -x BAT_THEME 'GitHub'
set -x BAT_STYLE 'plain,changes'
