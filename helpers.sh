#!/usr/bin/env sh

# Append a line to .bashrc if it doesn't already exist
# $1 - file to test and append
# $2 - regex test OR line to append
# $3 - line to append (if $2 is regex test)
# Usages:
#   to_file '~/.bashrc' 'export PATH=$HOME/.local/bin:$PATH'
#   to_file '~/.bashrc' '\\.my_custom_script' 'source $HOME/.my_custom_script'
to_file() {
  if [ ! -f "$1" ]; then
    echo "Error: First parameter should be a file" >&2
    exit 1
  fi
  if [ -z "$2" ]; then
    echo "Error: Second parameter cannot be empty" >&2
    exit 1
  fi

  if ! grep -q "$2" "$1"; then
    echo '' >> "$1"
    if [ -n "$3" ]; then
      echo "$3" >> "$1"
    else
      echo "$2" >> "$1"
    fi
  fi

  return
}

# Append a line to ~/.bashrc if it doesn't already exist
# $1 - regex test OR line to append
# $2 - line to append (if $1 is regex test)
# Usages:
#   to_bashrc 'export PATH=$HOME/.local/bin:$PATH'
#   to_bashrc '\\.my_custom_script' 'source $HOME/.my_custom_script'
to_bashrc() {
  touch "$HOME/.bashrc"
  to_file "$HOME/.bashrc" "$1" "$2"
  return
}

# Create a symbolic link, backing up any existing file/directory at the destination
# $1 - source path
# $2 - destination path
# Usage:
#   create_symlink "$DOTFILES_PATH/opencode/config" "$HOME/.config/opencode"
create_symlink() {
  cs_src=$1
  cs_dst=$2

  if [ -z "$cs_src" ] || [ -z "$cs_dst" ]; then
    echo "Error: Both source and destination paths are required" >&2
    exit 1
  fi

  if [ ! -e "$cs_src" ]; then
    echo "Error: Source path '$cs_src' does not exist" >&2
    exit 1
  fi

  if [ ! -L "$cs_dst" ] && [ -e "$cs_dst" ]; then
    BACKUP_PATH="${cs_dst}_backup_$(date +%Y%m%d_%H%M%S)"
    mv "$cs_dst" "$BACKUP_PATH" || { echo "Failed to create backup of '$cs_dst'" >&2; exit 1; }
    echo "Existing file/directory '$cs_dst' backed up to '$BACKUP_PATH'" >&3
  fi

  ln -sf "$cs_src" "$cs_dst" || { echo "Failed to create symbolic link from '$cs_src' to '$cs_dst'" >&2; exit 1; }
  echo "Created symbolic link from '$cs_src' to '$cs_dst'" >&3

  return
}

# Create a directory tree at the destination and create symbolic links for all files from the source
# $1 - source directory
# $2 - destination directory
# Usage:
#   link_tree "$DOTFILES_PATH/local/bin" "$HOME/.local/bin"
link_tree() {
  lt_src=$1
  lt_dst=$2

  if [ -z "$lt_src" ] || [ -z "$lt_dst" ]; then
    echo "Error: Both source and destination paths are required" >&2
    exit 1
  fi

  if [ ! -e "$lt_src" ]; then
    echo "Error: Source path '$lt_src' does not exist" >&2
    exit 1
  fi

  find "$lt_src" -type d | while IFS= read -r d; do
    rel=${d#"${lt_src}/"}
    [ "$rel" = "$lt_src" ] && rel=""
    mkdir -p "$lt_dst/$rel" || {
      echo "Failed to create directory '$lt_dst/$rel'" >&2
      exit 1
    }
  done

  find "$lt_src" \( -type f \) | while IFS= read -r p; do
    rel=${p#"${lt_src}/"}
    create_symlink "$p" "$lt_dst/$rel"
  done

  return
}
