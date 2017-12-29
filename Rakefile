require 'rake'

def sym_link(origin, destiny)
  puts %x{ln -fvs #{origin} #{destiny}}
end

def sym_link_dir(origin, destiny)
  puts %x{ln -fvsT #{origin} #{destiny}}
end

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
    sym_link_dir "$PWD/#{folder}", "$HOME/.#{folder}"
  end

  puts 'Linking zsh customs...'
  sym_link_dir '$PWD/zsh-themes',  '$PWD/oh-my-zsh/custom/themes'
  `ls $PWD/zsh-plugins`.split("\n").each do |dir|
    sym_link_dir "$PWD/zsh-plugins/#{dir}", "$PWD/oh-my-zsh/custom/plugins/#{dir}"
  end

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
    sym_link "$PWD/#{file}", "$HOME/.#{file}"
  end

  puts 'linking custom-dir files'
  %x{mkdir -p $HOME/.bundle}
  sym_link '$PWD/bundle-config', '$HOME/.bundle/config'

  puts 'Installing vim plugins'
  puts %x{vim +PlugUpgrade! +PlugInstall! +qall}

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
  %x{vim +PlugUpgrade! +PlugUpdate! +qall 2>&1}
  puts 'Done ^^'
end
