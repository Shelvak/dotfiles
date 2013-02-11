
let g:ackprg="ack-grep -H --nocolor --nogroup --column"

call pathogen#infect()

autocmd User Rails Rnavcommand fabricator  test/fabricators -suffix=_fabricator.rb -default=model()
autocmd User Rails Rnavcommand uploader  app/uploaders -suffix=_uploader.rb -default=model()
autocmd User Rails Rnavcommand inputs  app/inputs -suffix=_input.rb -default=model()

" :au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)


