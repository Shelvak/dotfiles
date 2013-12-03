# ZSH constants
ZSH="$HOME/.oh-my-zsh"
ZSH_THEME='cloud'
DISABLE_CORRECTION="true"
DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"

# Aliases
alias zc="vim ~/.zshrc"
alias vc="vim ~/.vimrc"
alias rsync-personal="~/.dotfiles/rsync-personal"
alias ..='cd ..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias pac="sudo pacman"
alias install="sudo pacman -S"
alias dotfiles_update="cd ~/.dotfiles; rake update; cd -"
alias clear_rails_apps="~/.dotfiles/clear_rails_apps"
alias v='vim'
alias sv="sudo vim"
alias ctl="sudo systemctl"
alias pq="sudo psql -U postgres"
alias rcp="rails c production"
alias rgm='rails g migration'
alias update_system="pac -Syyuu && yaourt -Syua"
alias clear_arch="pac -Rsn $(pacman -Qdtq)"

# Plugins
plugins=(rbenv git cd_rails bundler rails4)

source $ZSH/oh-my-zsh.sh
