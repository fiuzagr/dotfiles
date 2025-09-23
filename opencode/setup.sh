#!/usr/bin/env sh

brew install sst/tap/opencode

CONFIG_DIR=~/.config/opencode
if [ -d "$CONFIG_DIR" ]; then
    BACKUP_DIR="${CONFIG_DIR}_backup_$(date +%Y%m%d_%H%M%S)"
    mv "$CONFIG_DIR" "$BACKUP_DIR" || { echo "Failed to create backup"; exit 1; }
    echo "Existing opencode configuration backed up to $BACKUP_DIR" >&3
fi

ln -sf "$DOTFILES_PATH/opencode/config" "$CONFIG_DIR" || { echo "Failed to create symbolic link"; exit 1; }
