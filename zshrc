# ZSH constants
ZSH="$HOME/.oh-my-zsh"
DISABLE_CORRECTION="true"
DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"

if test "$(uname)" = "Darwin"; then
  ZSH_THEME='Shelvak-mac'
else
  ZSH_THEME='Shelvak'
fi

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
  alias rtest="mysql -u root -e 'DROP database eventioz_test;CREATE database eventioz_test;';
               mysql -u root eventioz_test < db/structure.sql;
               RAILS_ENV=test rake db:migrate; be rake test:all"
  alias brc="be rails c"
  alias t="ruby -I test"
else
  alias pac="sudo pacman"
  alias install="sudo pacman -S"
  alias update_system="pac -Syyuu && yaourt -Syua"
  alias clear_arch="pac -Rsn $(pacman -Qdtq)"
fi

# Plugins
plugins=(git cd_rails bundler rails rbenv)

source $ZSH/oh-my-zsh.sh

if test "$(uname)" = "Darwin"; then
  alias gpr="git pull --rebase eventioz master"
  export LANG="en_US.UTF-8"
  export LC_ALL="en_US.UTF-8"
  export PATH="/usr/local/sbin:/usr/local/bin:$PATH"
  source /usr/local/share/chruby/chruby.sh
  chruby 2.1.2
fi
