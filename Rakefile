require 'rake'

desc "install the dot files into user's home directory"
task :install do
  puts %x{git clone https://github.com/robbyrussell/oh-my-zsh.git}
  puts %x{chsh -s `which zsh`}

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

end
