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
    vim-plugins-rc
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

desc 'Install all basic shit'
task :arch_install do
  if `which powerpill 2>/dev/null`.strip == ''
    puts "Powerpill is needed"
    exit 0
  end

  if `which pacaur 2>/dev/null`.strip == ''
    puts "pacaur is needed"
    exit 0
  end

  # crear temporal de AUR
  `mkdir -p ~/tmp/cache`

  all = %w(
    binutils
    chrome-gnome-shell clementine clang
    direnv docker docker-compose
    expac
    ffmpeg fzf fakeroot
    gst-libav gst-plugins-bad gst-plugins-base gst-plugins-good gst-plugins-ugly
    gstreamer gstreamer gstreamer-vaapi git gcc
    htop
    icu iotop
    lib32-icu
    mlocate mtr make
    nmap nodejs npm
    pgadmin3 postgresql-libs pkg-config
    redis-desktop-manager ripgrep
    slack-desktop smplayer spotify sshfs
    telegram-desktop-bin tmux
    whatsapp-desktop wine
    xclip
    yajl
  )

  puts 'Checking packages against official repos'
  pacman_checks = `pacman -Si #{all.join(' ')}  2>/dev/null`
  official_pkgs = pacman_checks.scan(/(Nombre|Name)\s+: (.+)/i).map do |_key, name|
    name if name && name.strip != ''
  end.uniq.compact.sort

  no_official = all - official_pkgs
  aur_pkgs = []
  if no_official.size > 0
    puts 'Checking packages against AUR repo'
    aur_pkgs = no_official.map do |pkg|
      pkg if `pacaur -sq #{pkg} 2>/dev/null`.strip != ''
    end.compact.uniq.sort
  end

  puts "Installing official packages: #{official_pkgs.join(', ')}\n"
  system("sudo powerpill -S --needed #{official_pkgs.join(' ')}")
  puts "\n"

  if aur_pkgs.size > 0
    puts "Installing from AUR: #{aur_pkgs.join(', ')}\n"
    aur_pkgs.each do |pkg|
      system("pacaur -S --noedit --noconfirm --needed #{pkg}")
    end
  end

  if (unavailable = no_official - aur_pkgs).size > 0
    puts "No se encontraron: #{unavailable.join(', ')}"
  end


  puts "Configs:"
  puts 'Run this to install the terminal bk'
  puts 'dconf load /org/gnome/terminal/ < gnome_terminal.bk'

  puts 'smplayer...'
  puts `mkdir -p ~/.config/smplayer/; cp -vf smplayer.ini ~/.config/smplayer/smplayer.ini`

  puts "Adding user to docker group"
  puts `sudo gpasswd -a $USER docker`
end
