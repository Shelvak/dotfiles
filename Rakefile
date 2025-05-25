require 'rake'

# unused apps
# element-desktop discord  google-cloud-sdk kubectl-bin
# phantomjs-bin pgadmin4 postgresql-libs
# teamviewer unetbootin
APPS = %w[
  alacritty
  binutils brave-bin
  chruby clang
  docker docker-compose
  exa expac
  ffmpeg fzf fakeroot
  google-chrome gstreamer gstreamer-vaapi git gcc gvim gromit-mpx
  gst-libav gst-plugins-bad gst-plugins-base gst-plugins-good gst-plugins-ugly git-delta
  htop
  icu iotop
  lib32-icu
  mlocate mtr make
  nmap nodejs npm nvm
  opera
  postman-bin pkgconf pkgfile
  resp-app ripgrep ruby-install ruby-build
  smplayer spotify sshfs
  telegram-desktop tmux ttf-ms-fonts
  wine
  xclip
  yajl yay
  zoom zstd
]

def splitted_apps
  puts 'Checking packages against official repos'
  pacman_checks = `pacman -Si #{APPS.join(' ')}  2>/dev/null`
  official_pkgs = pacman_checks.scan(/(Nombre|Name)\s+: (.+)/i).map do |_key, name|
    name if name && name.strip != ''
  end.uniq.compact.sort

  no_official = APPS - official_pkgs
  aur_pkgs = []
  if no_official.size > 0
    puts 'Checking packages against AUR repo'
    aur_pkgs = no_official.map do |pkg|
      pkg if `yay -Ss #{pkg} 2>/dev/null`.strip != ''
    end.compact.uniq.sort
  end

  unavailable = no_official - aur_pkgs
  puts "No se encontraron: #{unavailable.join(', ')}" if unavailable.size > 0

  [official_pkgs, aur_pkgs]
end

def sym_link(origin, destiny)
  puts %x{ln -fvs #{origin} #{destiny}}
end

def sym_link_dir(origin, destiny)
  puts %x{ln -fvsT #{origin} #{destiny}}
end

def puts_and_install(command)
  puts command
  system(command)
end

desc "Link files into user's home directory"
task :link_files do
  puts 'Linking folders...'
  ['vim', 'oh-my-zsh', 'autoenv'].each do |folder|
    puts "Linking #{folder}"
    sym_link_dir "$PWD/#{folder}", "$HOME/.#{folder}"
  end

  # Not dot-files
  %w(bins scripts).each do |folder|
    puts "Linking #{folder}"
    sym_link_dir "$PWD/#{folder}", "$HOME/#{folder}"
  end

  puts 'Linking zsh customs...'
  sym_link_dir '$PWD/zsh-themes/Shelvak.zsh-theme',  '$PWD/oh-my-zsh/custom/themes/Shelvak.zsh-theme'
  # `ls $PWD/zsh-plugins`.split("\n").each do |dir|
  #   sym_link_dir "$PWD/zsh-plugins/#{dir}", "$PWD/oh-my-zsh/custom/plugins/#{dir}"
  # end

  puts 'Linking files...'
  %w(
    ackrc
    agignore
    alacritty.yml
    axelrc
    eslintrc
    gemrc
    gitattributes
    gitconfig
    gitignore_global
    irbrc
    irbrc_color.rb
    railsrc
    rubocop.yml
    screenrc
    tmux.conf
    vim-plugins
    vim-plugins-rc
    vim-plugins-before-load
    vimrc
    zsh-functions
    zshrc
  ).each do |file|
    sym_link "$PWD/#{file}", "$HOME/.#{file}"
  end

  puts 'linking custom-dir files'
  %x{mkdir -p $HOME/.bundle}
  sym_link '$PWD/bundle-config', '$HOME/.bundle/config'

  puts 'Installing vim plugins'
  puts %x{vim +PlugUpgrade! +PlugInstall! +qall}

  puts 'Linking custon files'
  # custom link opening config
  sym_link '$PWD/custom-open-link/custom-open-link.desktop', '$HOME/.local/share/applications/custom-open-link.desktop'
end

desc "install the dot files into user's home directory"
task :install_dotfiles do
  puts 'Install all submodules oh-my-zsh'
  puts %x{git submodule init}
  puts %x{git submodule update}

  unless ENV['SHELL'].match(/\/zsh/)
    puts 'Doing zsh the default'
    puts %x{chsh -s `which zsh`}
  end

  Rake::Task['link_files'].invoke

  puts 'Ready ^^'
end

desc 'Update all the _updatable_ things =)'
task :update_dotfiles do
  puts 'Updating...'
  puts %x{git pull origin master}
  puts %x{git submodule init}
  puts %x{git submodule update}
  puts %x{git submodule foreach "git pull origin master"}

  puts 'Updating vim plugins'
  %x{vim +PlugUpgrade! +PlugUpdate! +qall 2>&1}
  puts 'Done ^^'
end

desc 'Update SO'
task :update_SO do
  official_pkgs, aur_pkgs = splitted_apps

  # Update repos
  system("sudo pacman -Syyuu --overwrite '*' --needed #{official_pkgs.join(' ')}")

  unless aur_pkgs.empty?
    `mkdir -p ~/tmp/cache`
    puts "Installing from AUR: #{aur_pkgs.join(', ')}\n"

    system("yay -Sa --requestsplitn 30 --nodiffmenu --noeditmenu --nocleanmenu --norebuild --noredownload --useask --batchinstall --needed #{aur_pkgs.join(' ')}")
  end

  puts "\n"

  puts 'Adding user to docker group'
  system('sudo gpasswd -a $USER docker')

  # puts 'Installing extra plugins:'
  # puts_and_install 'gem install bundler rubocop'
  # puts_and_install 'sudo npm install -g eslint npm'
end
