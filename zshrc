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
alias dotfiles_update="cd ~/.dotfiles; rake update; cd -"
alias clear_rails_apps="~/.dotfiles/clear_rails_apps"
alias v='vim'
alias sv="sudo vim"
alias ctl="sudo systemctl"
alias pq="sudo psql -U postgres"
alias rcp="rails c production"
alias rgm='rails g migration'

if test "$(uname)" = "Darwin"; then
  export RBENV_ROOT=/usr/local/var/rbenv
  export PATH=/usr/local/bin:/Users/shelvak/.rbenv/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/sbin
  alias rtest="be rake test:all"
else
  alias pac="sudo pacman"
  alias install="sudo pacman -S"
  alias update_system="pac -Syyuu && yaourt -Syua"
  alias clear_arch="pac -Rsn $(pacman -Qdtq)"
fi

# Plugins
plugins=(rbenv git cd_rails bundler rails)

export LC_ALL=es_ES.UTF-8
export LANG=es_ES.UTF-8
source $ZSH/oh-my-zsh.sh

eval "$(rbenv init -)"
