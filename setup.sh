#!/usr/bin/env sh

set -ae

DOTFILES_PATH="$(cd -P -- "$(dirname -- "${0}")" && printf '%s\n' "$(pwd -P)")"
export DOTFILES_PATH

LOG_FILE="$DOTFILES_PATH/setup.log"
LOG_MAX_SIZE=$((3*1024*1024))  # 3MB in bytes

# Rotate log if it grows too large
if [ -f "$LOG_FILE" ]; then
    file_size=$(wc -c < "$LOG_FILE")
    if [ "$file_size" -gt "$LOG_MAX_SIZE" ]; then
        mv "$LOG_FILE" "$LOG_FILE.old"
        touch "$LOG_FILE"
    fi
fi

# redirect stdout/stderr to log file
# see https://serverfault.com/a/103569
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3 15
exec 1>>"$LOG_FILE" 2>&1

. "$DOTFILES_PATH/helpers.sh"

echo "--------------------------------"
echo "Setup started at: $(date)"
echo "User: $(whoami)"
echo "System: $(uname -a)"
echo "--------------------------------"

echo >&3
echo "--------------------------------" >&3
echo 'Running Setup...' >&3
echo "--------------------------------" >&3

to_bashrc "export DOTFILES_PATH=\"$DOTFILES_PATH\""

if [ $# -eq 0 ]; then
  # the order here matters!
  modules="base local fonts ssh gpg cargo flatpak homebrew git vim terminal-tools podman node alacritty opencode devtoolbox"

  echo 'Performing FULL setup...' >&3
  echo "modules: $modules" >&3
  echo >&3

  save_IFS=$IFS
  IFS=' '
  for module in $modules; do
    echo "Performing '$module' module setup..." >&3
    # shellcheck disable=SC1090
    . "$DOTFILES_PATH/$module/setup.sh"
  done
  IFS=$save_IFS
else
  echo "Performing '$1' module setup..." >&3

  # shellcheck disable=SC1090
  . "$DOTFILES_PATH/$1/setup.sh"
fi

# reload bashrc with all the new stuff
. "$HOME/.bashrc"

echo >&3
echo "--------------------------------" >&3
echo 'Setup done!' >&3
echo "--------------------------------" >&3

exit 0
