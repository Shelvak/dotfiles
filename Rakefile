require 'rake'

dotfiles_dir = '/home/rotsen/.dotfiles'

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

  puts 'Copying ruby-build plugin'
  puts %x{mkdir #{dorfiles_dir}/rbenv/plugins}
  puts %x{ln -s #{dotfiles_dir}/ruby-build #{dotfiles_dir}/rbenv/plugins/ruby-build}

  puts 'Copying zsh plugins...'
  puts %x{ln -s #{dotfiles_dir}/zsh-plugins/* #{dotfiles_dir}/oh-my-zsh/custom/plugins/ }

  puts 'Linking files...'

  for_link_files = [
    'zshrc', 'vimrc', 'gitconfig', 'gitignore_global', 'railsrc', 'gemrc',
    'screenrc'
  ]

  for_link_files.each do |file|
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

  puts 'Copying zsh plugins...'
  puts %x{ln -s #{dotfiles_dir}/zsh-plugins/* #{dotfiles_dir}/oh-my-zsh/custom/plugins/ }

  puts 'Done ^^'
end
