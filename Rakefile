require 'rake'

desc "install the dot files into user's home directory"
task :install do
  puts 'Install all submodules (oh-my-zsh && vim-plugins)'
  puts %x{git submodule init}
  puts %x{git submodule update}

  puts 'Doing zsh the default'
  puts %x{chsh -s `which zsh`}
  
  puts 'Linking...'
  puts %x{ln -s .dotfiles/vim .vim}
  puts %x{ln -s .dotfiles/oh-my-zsh .oh-my-zsh}
  puts %x{ln -s .dotfiles/zshrc .zshrc}
  puts %x{ln -s .dotfiles/vimrc .vimrc}
  puts %x{ln -s .dotfiles/gitconfig .gitconfig}
  puts %x{cd .dotfiles/oh-my-zsh/custom}
  puts %x{ln -s ../../zsh-plugins plugins}
  puts 'Ready ^^'
end

desc 'Update all the _updatable_ things =)'
task :update do
  puts 'Updating vim plugins'
  puts %x{~/.vim/update_plugins.sh}
  puts 'Updating Oh-My-ZSH'
  puts %x{cd ~/.oh-my-zsh/; git pull}
end
