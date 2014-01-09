if test "$(uname)" = "Darwin"; then
  dir='workspace'
else
  dir='rails'
fi

cr() { cd ~/$dir/$1; }
_cr() { _files -W ~/$dir -/; }
compdef _cr cr
