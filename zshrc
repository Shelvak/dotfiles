# Autostart tmux
export TERM=screen-256color
ZSH_TMUX_AUTOSTART="true"
stty stop undef  # Ctrol-S stop freezing
setopt no_flowcontrol

# ZSH Configs
ZSH="$HOME/.oh-my-zsh"
DISABLE_CORRECTION="true"
DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"
ZSH_THEME='Shelvak'
plugins=(git cd_rails bundler rails)
if test "$(uname)" != "Darwin"; then
  plugins+=(tmux)
fi

source $ZSH/oh-my-zsh.sh

# Completion
# autoload -U +X compinit && compinit   # Already implemented on oh-my-zsh
autoload -U +X bashcompinit && bashcompinit
autoload -U zmv
unsetopt correct

# Configuring history
# setopt inc_append_history # Already implemented on oh-my-zsh
# setopt hist_ignore_dups   # Already implemented on oh-my-zsh
setopt hist_find_no_dups
setopt hist_reduce_blanks
setopt hist_no_store
unsetopt share_history
export HISTSIZE=10000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE

# Editor
export EDITOR="vim"
export USE_EDITOR=$EDITOR
export VISUAL=$EDITOR
# GNU Screen sets -o vi if EDITOR=vi, so we have to force it back.
# set -o vi

# Aliases
alias v=$EDITOR
alias zc="v ~/.zshrc"
alias vc="v ~/.vimrc"
alias sv="sudo v"
alias ctl="sudo systemctl"
alias pq="sudo psql -U postgres"
alias rcp="rails c production"
alias rgm='rails g migration'
alias fuck='sudo $(fc -ln |tail -1)'
alias t="bin/rake test"
alias gpr="git pull --rebase origin master"
alias ..='cd ..'
alias ..2='cd ../..'
alias ..3='cd ../../..'

if test "$(uname)" = "Darwin"; then
  # export LANG="en_US.UTF-8"
  # export LC_ALL="en_US.UTF-8"
  export PATH="/usr/local/sbin:/usr/local/bin:$PATH"
  export ARCANIST_INSTALL_DIR=/Users/rotsen/.evbdevtools
  source $ARCANIST_INSTALL_DIR/devtools/scripts/devenv_bash/arcanist_helpers.sh

  alias core="cd ~/eventbrite/core"
  alias docker-dev="cd ~/eventbrite/docker-dev"
	function restart_sound() {
		sudo kill -9 "$(ps ax|grep 'coreaudio[a-z]' | awk '{print $1}')"
	}
  alias flush_cache="sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder"
  export BAY_HOME=/Users/rotsen/eventbrite/docker-dev
  eval $(docker-machine env evbdev)
else
  export PKGDEST=/home/rotsen/tmp/cache

  alias pac="sudo pacman"
  alias install="sudo pacman -S"
  alias update_system="pac -Syyuu && pacaur -Syua"
  alias clear_arch="pac -Rsn $(pacman -Qdtq)"

fi

# Ruby version
# source /usr/share/chruby/chruby.sh
# chruby 2.3.4
# source /usr/share/chruby/auto.sh

# AutoHook for dir/.envrc
# eval "$(direnv hook zsh)"
# export DIRENV_LOG_FORMAT=''  # skip the script echo's

# No se para que puta es esto pero estaba bueno
[ -f /etc/profile.d/vte.sh ] && source /etc/profile.d/vte.sh

# Pkgfile bin hook to find unknown commands
[ -f /usr/share/doc/pkgfile/command-not-found.zsh ] && source /usr/share/doc/pkgfile/command-not-found.zsh

# FuzzyFind Config
unalias rg 2>/dev/null >/dev/null # in some cases rg is set
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --follow --glob "!.git/*"'

# OPAM configuration
# . /home/rotsen/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# Custom Fn
sustituir() {
  egrep -rl "$1" * | xargs sed -i "s/$1/$2/g"
}
# source $ZSH/oh-my-zsh.sh
#unalias rg

# export FZF_DEFAULT_COMMAND='rg --files --follow --glob "!.git/*"'
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export TERM=screen-256color
