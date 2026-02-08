#!/usr/bin/env sh

. "$DOTFILES_PATH/shml"

log() {
  echo "$*" >&3
  return
}

copy_to_clipboard() {
  if is_macos; then
    pbcopy
  else
    xclip -selection clipboard
  fi
}

# Append a line to .bashrc if it doesn't already exist
# $1 - file to test and append
# $2 - regex test OR line to append
# $3 - line to append (if $2 is regex test)
# Usages:
#   to_file '~/.bashrc' 'export PATH=$HOME/.local/bin:$PATH'
#   to_file '~/.bashrc' '\\.my_custom_script' 'source $HOME/.my_custom_script'
to_file() {
  tf_file=$1
  tf_test_or_line=$2
  tf_line_if_test=$3

  if [ ! -f "$tf_file" ]; then
    echo "Error: First parameter should be a file" >&2
    exit 1
  fi
  if [ -z "$tf_test_or_line" ]; then
    echo "Error: Second parameter cannot be empty" >&2
    exit 1
  fi

  if ! grep -q "$tf_test_or_line" "$tf_file"; then
    echo '' >>"$tf_file"
    if [ -n "$tf_line_if_test" ]; then
      echo "$tf_line_if_test" >>"$tf_file"
    else
      echo "$tf_test_or_line" >>"$tf_file"
    fi
  fi

  return
}

# Append a line to ~/.dotfilesrc if it doesn't already exist
# $1 - regex test OR line to append
# $2 - line to append (if $1 is regex test)
# Usages:
#   to_dotfilesrc 'export PATH=$HOME/.local/bin:$PATH'
#   to_dotfilesrc '\\.my_custom_script' 'source $HOME/.my_custom_script'
to_dotfilesrc() {
  touch "$HOME/.dotfilesrc"
  to_file "$HOME/.dotfilesrc" "$1" "$2"
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

# Get current operating system
# Returns: "darwin" on macOS, "linux" on Linux, "unknown" otherwise
# Usage: os=$(get_os)
get_os() {
  go_uname=$(uname -s)
  case "$go_uname" in
  Darwin*)
    echo "darwin"
    ;;
  Linux*)
    echo "linux"
    ;;
  *)
    echo "unknown"
    ;;
  esac
  return
}

# Check if running on macOS
# Returns: 0 (success) on macOS, 1 otherwise
# Usage: if is_macos; then ...; fi
is_macos() {
  im_os=$(get_os)
  if [ "$im_os" = "darwin" ]; then
    return 0
  else
    return 1
  fi
}

# Check if running on Linux
# Returns: 0 (success) on Linux, 1 otherwise
# Usage: if is_linux; then ...; fi
is_linux() {
  il_os=$(get_os)
  if [ "$il_os" = "linux" ]; then
    return 0
  else
    return 1
  fi
}

# Get current shell type
# Returns: "zsh", "bash", or "bash" (fallback)
# Usage: shell=$(get_shell)
get_shell() {
  gs_shell="$SHELL"
  case "$gs_shell" in
  *zsh)
    echo "zsh"
    ;;
  *bash)
    echo "bash"
    ;;
  *)
    echo "bash"
    ;;
  esac
  return
}

# Append a line to ~/.zshrc if it doesn't already exist
# $1 - regex test OR line to append
# $2 - line to append (if $1 is regex test)
# Usages:
#   to_zshrc 'export PATH=$HOME/.local/bin:$PATH'
#   to_zshrc '\\.my_custom_script' 'source $HOME/.my_custom_script'
to_zshrc() {
  touch "$HOME/.zshrc"
  to_file "$HOME/.zshrc" "$1" "$2"
  return
}

# Append a line to shell RC file based on current shell
# $1 - regex test OR line to append
# $2 - line to append (if $1 is regex test)
# Usages:
#   to_shell_rc 'export PATH=$HOME/.local/bin:$PATH'
#   to_shell_rc '\\.my_custom_script' 'source $HOME/.my_custom_script'
to_shell_rc() {
  tsr_shell=$(get_shell)
  if [ "$tsr_shell" = "zsh" ]; then
    to_zshrc "$1" "$2"
  else
    to_bashrc "$1" "$2"
  fi
  return
}

# Create a symbolic link, backing up any existing file/directory at the destination
# This function is idempotent: running it multiple times with the same parameters
# will not recreate the link if it already exists pointing to the correct source.
# All symbolic links are created using absolute paths.
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

  # Convert source to absolute path
  if [ -d "$cs_src" ]; then
    cs_src_abs=$(cd "$cs_src" && pwd)
  else
    cs_src_abs=$(cd "$(dirname "$cs_src")" && pwd)/$(basename "$cs_src")
  fi

  # Check if destination already exists
  if [ -L "$cs_dst" ]; then
    # Destination is a symbolic link
    cs_current_target=$(readlink "$cs_dst")

    if [ "$cs_current_target" = "$cs_src_abs" ]; then
      # Idempotent: link already exists and points to correct source
      log "Symbolic link '$cs_dst' already exists and points to '$cs_src_abs'"
      return 0
    fi

    # Link points to different source, remove old link
    log "Removing old symbolic link '$cs_dst' (was pointing to '$cs_current_target')"
    rm "$cs_dst" || {
      echo "Failed to remove old symbolic link '$cs_dst'" >&2
      exit 1
    }
  elif [ -e "$cs_dst" ]; then
    # Destination exists but is not a symbolic link (regular file/directory)
    BACKUP_PATH="${cs_dst}_backup_$(date +%Y%m%d_%H%M%S)"
    mv "$cs_dst" "$BACKUP_PATH" || {
      echo "Failed to create backup of '$cs_dst'" >&2
      exit 1
    }
    log "Existing file/directory '$cs_dst' backed up to '$BACKUP_PATH'"
  fi

  # Create parent directory of destination if it doesn't exist
  cs_dst_dir=$(dirname "$cs_dst")
  if [ ! -d "$cs_dst_dir" ]; then
    mkdir -p "$cs_dst_dir" || {
      echo "Failed to create parent directory '$cs_dst_dir'" >&2
      exit 1
    }
  fi

  # Create symbolic link using absolute path
  ln -s "$cs_src_abs" "$cs_dst" || {
    echo "Failed to create symbolic link from '$cs_src_abs' to '$cs_dst'" >&2
    exit 1
  }
  log "Created symbolic link '$cs_dst' -> '$cs_src_abs'"

  return 0
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
