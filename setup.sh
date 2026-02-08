#!/usr/bin/env sh
# shellcheck disable=SC2005 # useless echo?

set -ae

DOTFILES_PATH="$(cd -P -- "$(dirname -- "${0}")" && printf '%s\n' "$(pwd -P)")"
export DOTFILES_PATH

DOTFILESRC_PATH="$HOME/.dotfilesrc"
export DOTFILESRC_PATH

LOG_FILE="$DOTFILES_PATH/setup.log"
LOG_MAX_SIZE=$((3 * 1024 * 1024)) # 3MB in bytes

# Rotate log if it grows too large
if [ -f "$LOG_FILE" ]; then
  file_size=$(wc -c <"$LOG_FILE")
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

# Export OS and shell detection
DOTFILES_OS=$(get_os)
export DOTFILES_OS

DOTFILES_SHELL=$(get_shell)
export DOTFILES_SHELL

echo "$(hr)"
echo "Setup started at: $(date)"
echo "User: $(whoami)"
echo "System: $(uname -a)"
echo "$(hr)"

log
log "$(hr)"
log "$(a bold 'Running Setup...')"
log "Log file: $LOG_FILE"
log "$(hr)"

if [ $# -eq 0 ]; then
  # (re)create .dotfilesrc in full setup
  echo "#!/usr/bin/env sh" >"$HOME/.dotfilesrc"
  to_dotfilesrc "export DOTFILES_PATH=\"$DOTFILES_PATH\""
  to_dotfilesrc "export DOTFILESRC_PATH=\"$DOTFILESRC_PATH\""
  to_dotfilesrc "export DOTFILES_SHELL=\"$DOTFILES_SHELL\""
  to_dotfilesrc "alias dotfiles='sh \$DOTFILES_PATH/setup.sh'"

  # the order here matters!
  modules="base shell local fonts homebrew flatpak node rustup uv ssh gpg git terminal-tools tmux nvim alacritty docker"

  log
  log "$(hr)"
  log 'Performing FULL setup...'
  log "modules: $modules"
  log
else
  if [ ! -f "$DOTFILESRC_PATH" ]; then
    log_error "Please run full setup first (without parameters)"
    exit 1
  fi

  modules="$*"
fi

save_IFS=$IFS
IFS=' '
for module in $modules; do
  log
  log "$(hr)"
  log "Performing '$module' module setup..."

  if [ ! -f "$DOTFILES_PATH/$module/setup.sh" ]; then
    log_error "Module '$module' does not exist."
    exit 1
  fi

  # Execute module in subshell to isolate error handling from set -e
  set +e
  # shellcheck disable=SC1090
  (
    set -e
    . "$DOTFILES_PATH/$module/setup.sh"
  )
  MODULE_EXIT_CODE=$?
  set -e

  if [ $MODULE_EXIT_CODE -ne 0 ]; then
    log_error "Module '$module' setup failed." "$LOG_FILE"
    exit 1
  fi
done
IFS=$save_IFS

to_shell_rc ". \"$DOTFILESRC_PATH\""

log
log "$(hr)"
log "$(fgc green)$(e check) Setup done!$(fgc end)"
log "Reopen your terminal"
log "$(hr)"

exit 0
