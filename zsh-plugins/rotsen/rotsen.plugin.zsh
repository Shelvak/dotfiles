# Search in projects dir
cr() { cd ~/git/$1; }
_cr() { _files -W ~/git -/; }
compdef _cr cr

cs() { tmux split-window -v -c ~/git/$1; }
_cs() { _files -W ~/git -/; }
compdef _cs cs

# test from path
t() { RAILS_ENV=test rails test test/$1; }
_t() { _files -W $PWD/test -/; }
compdef _t t
