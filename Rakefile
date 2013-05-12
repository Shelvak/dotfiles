require 'rake'

desc "install the dot files into user's home directory"
task :install do
  puts 'Install all submodules (oh-my-zsh && vim-plugins)'
  puts %x{git submodule init}
  puts %x{git submodule update}

  puts 'Doing zsh the default'
  puts %x{chsh -s `which zsh`}
  
  puts 'Linking folders...'

  ['vim', 'oh-my-zsh', 'rbenv'].each do |folder|
    puts %x{ln -s "$PWD/#{folder}" "$HOME/.#{folder}"}
  end

  puts 'Copying zsh plugins...'
  puts %x{cd oh-my-zsh/custom; ln -s ../../zsh-plugins plugins}

  puts 'Linking files...'

  ['zshrc', 'vimrc', 'gitconfig', 'railsrc', 'gemrc'].each do |file|
    puts %x{ln -s "$PWD/#{file}" "$HOME/.#{file}"}
  end

  puts 'Ready ^^'
end

desc 'Update all the _updatable_ things =)'
task :update do
  puts 'Updating...'
  puts %x{git pull}
  puts %x{git submodule update}
  puts %x{git submodule foreach "git pull origin master"}

  git_repos = ['.rbenv', '.rbenv/plugins/ruby-build', '.oh-my-zsh']

  git_repos.each do |repo|
    if File.directory?(File.join(ENV['HOME'], repo, '.git'))
      puts "Updating #{repo}"
      puts %x{cd $HOME/#{repo}; git pull; cd -} 
    end
  end

  puts %x{curl -Sso ~/.dotfiles/vim/autoload/pathogen.vim https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim}

  puts 'Done ^^'
end
