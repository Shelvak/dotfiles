# ZSH constants
ZSH="$HOME/.oh-my-zsh"
DISABLE_CORRECTION="true"
DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"
ZSH_THEME='Shelvak'

# Completion
autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit
autoload -U zmv
unsetopt correct

# Configuring history
unsetopt share_history
setopt inc_append_history
setopt hist_ignore_dups
setopt hist_find_no_dups
setopt hist_reduce_blanks
setopt hist_no_store
export HISTSIZE=10000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE

export EDITOR="nvim"
export USE_EDITOR=$EDITOR
export VISUAL=$EDITOR
# GNU Screen sets -o vi if EDITOR=vi, so we have to force it back.
set -o vi


# Autostart tmux
export TERM=screen-256color
ZSH_TMUX_AUTOSTART="true"


# Aliases
alias vim='nvim'
alias zc="vim ~/.zshrc"
alias vc="vim ~/.config/nvim/init.vim"
alias v='vim'
alias sv="sudo vim"
alias ctl="sudo systemctl"
alias pq="sudo psql -U postgres"
alias rcp="rails c production"
alias rgm='rails g migration'
alias fuck='sudo $(fc -ln |tail -1)'
alias t="bin/rake test"
alias gpr="git pull --rebase origin master"
alias rsync-personal="~/.dotfiles/rsync-personal"
alias ..='cd ..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias dotfiles_update="cd ~/.dotfiles; rake update; cd -"
alias clear_rails_apps="~/.dotfiles/clear_rails_apps"

source /usr/local/share/chruby/chruby.sh
chruby 2.3.1

sustituir() {
  egrep -rl "$1" * | xargs gsed -i "s/$1/$2/g"
}

if test "$(uname)" = "Darwin"; then
  export LANG="en_US.UTF-8"
  export LC_ALL="en_US.UTF-8"
  export PATH="/usr/local/sbin:/usr/local/bin:$PATH"
  export ARCANIST_INSTALL_DIR=/Users/rotsen/.evbdevtools
  source $ARCANIST_INSTALL_DIR/devtools/scripts/devenv_bash/arcanist_helpers.sh

  alias brc="be rails c"
  alias vg="ssh-add ; vagrant"
  alias vgu="vg up"
  alias vgs="vg ssh"
  alias core="cd ~/eventbrite/core"
  alias docker-dev="cd ~/eventbrite/docker-dev"
	function restart_sound() {
		sudo kill -9 "$(ps ax|grep 'coreaudio[a-z]' | awk '{print $1}')"
	}
else
  source /etc/profile.d/vte.sh
  export PKGDEST=/home/rotsen/tmp/cache
  export PATH="/home/rotsen/bins:$PATH"

  alias pac="sudo pacman"
  alias install="sudo pacman -S"
  alias update_system="pac -Syyuu && pacaur -Syua"
  alias clear_arch="pac -Rsn $(pacman -Qdtq)"
fi


plugins=(git cd_rails bundler rails)
if test "$(uname)" != "Darwin"; then
  plugins+=(tmux)
fi

source $ZSH/oh-my-zsh.sh
unalias rg

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
