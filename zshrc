# Load base-custom functions
source ~/.zsh-functions

# Autostart tmux
export TERM=screen-256color
ZSH_TMUX_AUTOSTART="true"
stty stop undef  # Ctrol-S stop freezing
setopt no_flowcontrol

# ZSH Configs
ZSH="$HOME/.oh-my-zsh"
ZSH_CUSTOM="$ZSH/custom"
ZSH_THEME='Shelvak'
DISABLE_CORRECTION="true"
DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"

plugins=(git rotsen bundler rails autoenv tmux docker docker-compose)
safe_source $ZSH/oh-my-zsh.sh

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

export DISPLAY=${DISPLAY:-:0} # fix for vim clipboard
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
alias sv="sudo vim"
alias ctl="sudo systemctl"
alias pq="psql -U docker -h localhost -p 5432"
alias rcp="rails c production"
alias rgm='rails g migration'
alias fuck='sudo $(fc -ln |tail -1)'
alias gpr="git pull --rebase origin master"
alias gpl="git pull --no-rebase origin master"
alias ..='cd ..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
alias minar="cd /Secundario/rotsen/crypto/xmrig-nvidia-2.6.0-beta1/build; sudo ./xmrig-nvidia"
alias tmux_reload="tmux source-file ~/.tmux.conf"

# Arch specific logic
export PATH="/home/rotsen/bins/:$PATH"
export PKGDEST=/home/rotsen/tmp/cache  # AUR cache
alias pac="sudo pacman"
alias install="pac -S"
alias power="sudo powerpill"
alias qinstall="power -S"
alias update_system="pac -Syy && power -Suu && pacaur -Syua"
alias clear_arch="pac -Rsn $(pacman -Qdtq)"
alias pacaur_apps="pac -Qm"

# Ruby logic
safe_source /usr/share/chruby/chruby.sh
chruby 2.4.3
safe_source /usr/share/chruby/auto.sh

# No se para que puta es esto pero estaba bueno
safe_source /etc/profile.d/vte.sh

# Pkgfile bin hook to find unknown commands
safe_source /usr/share/doc/pkgfile/command-not-found.zsh

# FuzzyFind Config
unalias rg 2>/dev/null >/dev/null # in some cases rg is set
safe_source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --follow --glob "!.git/*"'

# OPAM configuration
# safe_source /home/rotsen/.opam/opam-init/init.zsh

# GO logic
export GOPATH=/opt/go
