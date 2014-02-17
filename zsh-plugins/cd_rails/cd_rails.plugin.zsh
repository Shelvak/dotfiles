
if test "$(uname)" = "Darwin"; then
  cr() { cd ~/git/$1; }
  _cr() { _files -W ~/git -/; }
  compdef _cr cr
else
  cr() { cd ~/rails/$1; }
  _cr() { _files -W ~/rails -/; }
  compdef _cr cr
fi

