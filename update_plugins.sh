#!/bin/bash

function update_dir {
  ORIGINAL_DIR=$( pwd );

  cd $1;

  if [ -d ".git" ]; then
    echo -e "\n Updating $( pwd )...";
    git pull;
  fi

  cd "$ORIGINAL_DIR";
}

VIM_DIR="$HOME/.vim";
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";

#Update All vim/bundle-pluggins
echo "Updating Vim-pluggins"
cd "$VIM_DIR";

for plugin_dir in bundle/* ; do
  if [ -d "$plugin_dir" ]; then
    update_dir "$plugin_dir";
  fi
done

# Update all dotfiles-gitfolders
echo -e "\n\n"
echo "Updating dotfiles-pluggins"
cd "$HOME";

for plugin_dir in .dotfiles/*; do
  if [ -d "$plugin_dir" ]; then
    update_dir "$plugin_dir";
  fi
done

# Custom updates
update_dir "$HOME/.rbenv/plugins/ruby-build"


