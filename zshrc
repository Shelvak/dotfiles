# Safe Require file
safe_source () { [ -f $1 ] && source $1 }

# Autostart tmux
TMUX_ENABLED=$(which tmux 2>&1)
if [[ "$TMUX_ENABLED" != "" ]]; then
  export ZSH_TMUX_TERM=screen-256color
  ZSH_TMUX_AUTOSTART="true"
  ZSH_TMUX_AUTOCONNECT="true"

  # Ctrol-S stop freezing
  stty stop undef
  setopt no_flowcontrol

  alias tmux_reload="tmux source-file ~/.tmux.conf"

  # tmux attach -t 0 # || tmux new -s 0
  if [ -z "$TMUX" ]
  then
    tmux attach -t $TMUX || tmux new -s $TMUX
  fi
fi

# ZSH Configs
export TERM=screen-256color
set -g default-terminal "screen-256color"
ZSH="$HOME/.oh-my-zsh"
ZSH_CUSTOM="$ZSH/custom"
ZSH_THEME='Shelvak'
DISABLE_CORRECTION="true"
DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"

plugins=(git autoenv tmux docker docker-compose autoswitch_virtualenv) # bundler rails kubectl mix)
# Skip directories aliaces
zstyle ':omz:lib:directories' aliases no
safe_source $ZSH/oh-my-zsh.sh

# Completion
# autoload -U +X compinit && compinit   # Already implemented on oh-my-zsh
autoload -U +X bashcompinit && bashcompinit
autoload -U zmv
unsetopt correct

# Configuring history
setopt inc_append_history # Already implemented on oh-my-zsh
# setopt hist_ignore_dups   # Already implemented on oh-my-zsh
setopt HIST_FIND_NO_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_REDUCE_BLANKS
setopt HIST_NO_STORE
unsetopt share_history
export HISTSIZE=20000
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
alias vv=v
alias :w=v
alias zc="v ~/.zshrc"
alias vc="v ~/.vimrc"
alias sv="sudo vim"
alias ctl="sudo systemctl"
# alias pq="psql -U docker -h localhost -p 5432"
# alias rcp="rails c production"
# alias rgm='rails g migration'
alias fuck='sudo $(fc -ln |tail -1)'
alias gpr="git pull --rebase origin master"
alias gpl="git pull --no-rebase origin master"
alias ..='cd ..'
alias ..2='cd ../..'
alias ..3='cd ../../..'
# alias refresh="gpr; bi --jobs 8; rdm"
# alias full_test="RAILS_ENV=test rails db:drop db:create db:migrate; rails test"
# alias ll="exa -lah"
# alias gcas="mix format; gca -m '[ci skip] Tmp'; ggpush"

# Clusters
# alias ktanga="k exec -it tanga -- bash"
# alias kteiqui="k --kubeconfig=/home/rotsen/.kube/teiqui --namespace production"

# Arch specific logic
export PATH="/home/rotsen/bins/:$PATH"
export PKGDEST=/home/rotsen/tmp/cache  # AUR cache
alias pac="sudo pacman"
alias install="pac -S"
alias update_system="cd ~/.dotfiles/ && rake update_SO; cd -"
alias clear_arch="pac -Rsn $(pacman -Qdtq)"
alias pacaur_apps="pac -Qm"

# Elixir alias
# alias dt="iex -S mix test --trace"

# Ruby logic
safe_source /usr/share/chruby/chruby.sh
chruby 3  #>> /dev/null 2>&1
safe_source /usr/share/chruby/auto.sh

# Unknown terminal improvements
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

# RXVT
# [[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# Yarn NPM bins
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Rust / Cargo bins
export PATH="$HOME/.cargo/bin:$PATH"
export CARGO_HOME="$HOME/.cargo"

# added by travis gem
# [ -f /home/rotsen/.travis/travis.sh ] && source /home/rotsen/.travis/travis.sh

# Elixir
# export ERL_AFLAGS="-kernel shell_history enabled  -kernel shell_history_file_bytes 2097152"

# NodeJS shit
if [ -e /home/rotsen/.nix-profile/etc/profile.d/nix.sh ]; then . /home/rotsen/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
export LD_LIBRARY_PATH=/nix/store/hs1zphws1iyddrvfyqs7qj9qw6qqs0mc-icu4c-68.2/lib

# Node manager NVM
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
([ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" || /usr/share/nvm/init-nvm.sh) # This loads nvm ] " ])"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Foundry / Forge
# export PATH="$PATH:/home/rotsen/.foundry/bin"

# Solana cli
export PATH="$PATH:/home/rotsen/.local/share/solana/install/active_release/bin"

alias dev='pnpm dev --character="characters/shelvak.character.json"'

# SHOULD BE AT THE END TO OVERRIDE ANY OTHER Fn
# Load custom functions
safe_source ~/.zsh-functions
