cr() { cd ~/git/$1; }
_cr() { _files -W ~/git -/; }
compdef _cr cr
