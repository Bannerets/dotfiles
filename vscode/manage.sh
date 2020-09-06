#!/usr/bin/env bash

# TODO: Default dirs for other OSes
_settings_dir=${VSCODE_SETTINGS_DIR:-"$HOME/Library/Application Support/Code/User"}

cd ~/dotfiles/vscode/

function _save_disabled_extensions {
  { set +x; } 2> /dev/null
  sqlite3 "$_settings_dir/globalStorage/state.vscdb" \
    'SELECT value FROM ItemTable WHERE key = "extensionsIdentifiers/disabled"' \
    | jq -r '.[].id' \
    > disabled-extensions.txt
}

case $1 in
  export)
    set -x
    cp "$_settings_dir/settings.json" settings.json
    cp "$_settings_dir/keybindings.json" keybindings.json
    code --list-extensions > extensions.txt
    _save_disabled_extensions || echo "Unable to save disabled extensions."
    ;;
  import)
    (
      set -x
      cp settings.json "$_settings_dir/settings.json"
      cp keybindings.json "$_settings_dir/keybindings.json"
      cat extensions.txt | xargs -L 1 code --install-extension
    )
    echo "Disable these extensions:"
    cat disabled-extensions.txt
    ;;
  *)
    exit 1
    ;;
esac
