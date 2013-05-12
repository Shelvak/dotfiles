# ZSH constants
ZSH="$HOME/.oh-my-zsh"
ZSH_THEME='cloud'
DISABLE_CORRECTION="true"
DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"

# Aliases
alias zc="vim ~/.zshrc"
alias vc="vim ~/.vimrc"
alias pg-pgsql="sudo su postgres;psql"
alias rs="rails s"
alias rc="rails c"
alias rcp="rails c production"
alias ..='cd ..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias a-g-i="sudo apt-get install"
alias dotfiles_update="cd ~/.dotfiles; rake update; cd -"
alias v='vim'

# Plugins 
plugins=(git cd_rails rails3 bundler)

source $ZSH/oh-my-zsh.sh

# RBenv init
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
