#!/usr/bin/env sh
# shellcheck disable=SC2005 # useless echo?

set -ae

DOTFILES_PATH="$(cd -P -- "$(dirname -- "${0}")" && printf '%s\n' "$(pwd -P)")"
export DOTFILES_PATH
DOTFILESRC_PATH="$HOME/.dotfilesrc"
export DOTFILESRC_PATH

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

echo "$(hr)"
echo "Setup started at: $(date)"
echo "User: $(whoami)"
echo "System: $(uname -a)"
echo "$(hr)"

echo >&3
echo "$(hr)" >&3
echo "$(a bold 'Running Setup...')" >&3
echo "Log file: $LOG_FILE" >&3
echo "$(hr)" >&3

if [ $# -eq 0 ]; then
  # (re)create .dotfilesrc in full setup
  echo "#!/usr/bin/env bash" > "$HOME/.dotfilesrc"
  to_dotfilesrc "export DOTFILES_PATH=\"$DOTFILES_PATH\""
  to_dotfilesrc "export DOTFILESRC_PATH=\"$DOTFILESRC_PATH\""
  to_dotfilesrc "alias dotfiles='sh \$DOTFILES_PATH/setup.sh'"

  # the order here matters!
  modules="base local fonts ssh gpg cargo flatpak homebrew git vim terminal-tools podman node uv alacritty devtoolbox"

  echo >&3
  echo "$(hr)" >&3
  echo 'Performing FULL setup...' >&3
  echo "modules: $modules" >&3
  echo >&3
else
  if [ ! -f "$DOTFILESRC_PATH" ]; then
    echo "Error: Please run full setup first (without parameters)" >&3
    exit 1
  fi

  modules="$*"
fi

save_IFS=$IFS
IFS=' '
for module in $modules; do
  echo >&3
  echo "$(hr)" >&3
  echo "Performing '$module' module setup..." >&3

  if [ ! -f "$DOTFILES_PATH/$module/setup.sh" ]; then
    echo "Error: Module '$module' does not exist." >&3
    exit 1
  fi

  # shellcheck disable=SC1090
  . "$DOTFILES_PATH/$module/setup.sh"
done
IFS=$save_IFS

to_bashrc ". \"$DOTFILESRC_PATH\""

echo >&3
echo "$(hr)" >&3
echo "$(fgc green)$(e check) Setup done!$(fgc end)" >&3
echo "Reopen your terminal" >&3
echo "$(hr)" >&3

exit 0
