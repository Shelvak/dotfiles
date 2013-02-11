#!/bin/bash

function update_dir {
  ORIGINAL_DIR=$( pwd );

  cd $1;

  if [ -d ".git" ]; then
    echo "Updating $( pwd )...";
    git pull;
  fi

  cd "$ORIGINAL_DIR";
}

VIM_DIR="$HOME/.vim";
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";

# Auto update
update_dir "$SCRIPT_DIR";

cd "$VIM_DIR";

for plugin_dir in bundle/* ; do
  if [ -d "$plugin_dir" ]; then
    update_dir "$plugin_dir";
  fi
done
