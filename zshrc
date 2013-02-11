# Path to your oh-my-zsh configuration.
ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME='miloshadzic'

# Aliases
alias zc="vim ~/.zshrc"
alias vc="vim ~/.vimrc"
alias cr="cd ~/rails/;echo $cwd" # Try to cr project
alias pg-pgsql="sudo su postgres;psql"

# Plugins 
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Customizes

# RBenv init
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
