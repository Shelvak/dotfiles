# ZSH constants
ZSH="$HOME/.oh-my-zsh"
ZSH_THEME='Shelvak'
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
  alias rtest="be rake test:all"
  alias brc="be rails c"
else
  alias pac="sudo pacman"
  alias install="sudo pacman -S"
  alias update_system="pac -Syyuu && yaourt -Syua"
  alias clear_arch="pac -Rsn $(pacman -Qdtq)"
fi

# Plugins
plugins=(git cd_rails bundler rails)

source $ZSH/oh-my-zsh.sh

if test "$(uname)" = "Darwin"; then
  export LANG=es_ES.UTF-8
  source /usr/local/share/chruby/chruby.sh
  chruby ruby-2.0
fi
