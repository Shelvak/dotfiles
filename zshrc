# Path to your oh-my-zsh configuration.
ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME='miloshadzic'

# Aliases
alias zc="vim ~/.zshrc"
alias vc="vim ~/.vimrc"
alias cr="cd ~/rails/" # Try to cr project
alias pg-pgsql="sudo su postgres;psql"
alias rs="rails s"
alias rc="rails c"
alias rcp="rails c production"
alias ..='cd ..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias a-g-i="sudo apt-get install"

# Plugins 
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Customizes

# RBenv init
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
