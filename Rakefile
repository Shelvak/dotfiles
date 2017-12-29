require 'rake'

dotfiles_dir = [Dir.home, '.dotfiles'].join('/')

desc "install the dot files into user's home directory"
task :install do
  puts 'Install all submodules oh-my-zsh'
  puts %x{git submodule init}
  puts %x{git submodule update}

  puts 'Doing zsh the default'
  puts %x{chsh -s `which zsh`}

  puts 'Linking folders...'
  ['vim', 'oh-my-zsh'].each do |folder|
    puts "Linking #{folder}"
    puts %x{ln -fs "$PWD/#{folder}" "$HOME/.#{folder}"}
  end

  puts 'Copying zsh customs...'
  omz_plugins = "#{dotfiles_dir}/oh-my-zsh/custom/plugins"
  omz_themes  = "#{dotfiles_dir}/oh-my-zsh/custom/themes"
  puts %x{mkdir -p #{omz_plugins} }
  puts %x{mkdir -p #{omz_themes} }
  puts %x{ln -sf #{dotfiles_dir}/zsh-plugins/* #{omz_plugins}/ }
  puts %x{ln -sf #{dotfiles_dir}/zsh-themes/*  #{omz_themes}/ }

  puts 'Linking files...'
  %w(
    ackrc
    agignore
    gemrc
    gitconfig
    gitignore_global
    irbrc
    irbrc_color.rb
    railsrc
    rubocop.yml
    screenrc
    tmux.conf
    vimrc
    zshrc
  ).each do |file|
    puts %x{ln -vfs "$PWD/#{file}" "$HOME/.#{file}"}
  end

  puts 'linking custom-dir files'
  puts %x{mkdir -o $HOME/.bundle}
  puts %x{ln -vfs $PWD/bundle-config $HOME/.bundle/}

  puts 'Installing vim plugins'
  puts %x{vim +PlugUpgrade +PlugInstall +qall}

  puts 'Ready ^^'
end

desc 'Update all the _updatable_ things =)'
task :update do
  puts 'Updating...'
  puts %x{git pull}
  puts %x{git submodule init}
  puts %x{git submodule update}
  puts %x{git submodule foreach "git pull origin master"}

  puts 'Updating vim plugins'
  puts %x{vim +PlugUpgrade +PlugUpdate +qall}
  puts 'Done ^^'
end
