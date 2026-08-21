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

dotfiles_update() {
  log
  log "$(hr)"
  log "$(a bold 'Updating dotfiles...')"
  log "$(hr)"

  if ! git -C "$DOTFILES_PATH" rev-parse --git-dir \
    >/dev/null 2>&1; then
    log_error "Not a git repository: $DOTFILES_PATH"
    exit 1
  fi

  if [ -n "$(git -C "$DOTFILES_PATH" status --porcelain)" ]; then
    log_error "Local changes in $DOTFILES_PATH. Commit or stash first."
    exit 1
  fi

  log "Fetching latest changes..."
  if ! git -C "$DOTFILES_PATH" fetch origin >&3 2>&3; then
    log_error "Failed to fetch from remote."
    exit 1
  fi

  log "Pulling (fast-forward only)..."
  if ! git -C "$DOTFILES_PATH" pull --ff-only >&3 2>&3; then
    log_error "Pull failed — branch diverged. Resolve manually."
    exit 1
  fi

  git -C "$DOTFILES_PATH" submodule update --init --recursive \
    2>/dev/null || true

  log
  log "$(fgc green)$(e check) Dotfiles updated!$(fgc end)"
  log
  printf "Re-run full setup now? [y/N]: " >&3
  read -r du_choice || true
  case "$du_choice" in
  y | Y)
    log "Re-running full setup..."
    exec 2>&4 1>&3
    exec sh "$DOTFILES_PATH/setup.sh"
    ;;
  *)
    log "Run 'dotfiles' manually when ready."
    exit 0
    ;;
  esac
}

if [ $# -gt 0 ] && [ "$1" = "update" ]; then
  dotfiles_update
  exit $?
fi

# Export OS, shell, and GUI detection
DOTFILES_OS=$(get_os)
export DOTFILES_OS

DOTFILES_SHELL=$(get_shell)
export DOTFILES_SHELL

DOTFILES_HAS_GUI=0
if has_gui; then
  DOTFILES_HAS_GUI=1
fi
export DOTFILES_HAS_GUI

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
  to_dotfilesrc "export DOTFILES_HAS_GUI=\"$DOTFILES_HAS_GUI\""
  to_dotfilesrc "alias dotfiles='sh \$DOTFILES_PATH/setup.sh'"

  # the order here matters!
  MODULES="base homebrew build-tools shell local fonts flatpak node rustup uv java ssh gpg git terminal-tools tmux nvim ghostty docker"
  GUI_MODULES="fonts flatpak ghostty alacritty devtoys"

  log
  log "$(hr)"
  log 'Performing FULL setup...'
  if [ "$DOTFILES_HAS_GUI" -eq 0 ]; then
    log 'No GUI detected — GUI modules will be skipped'
    log "GUI modules: $GUI_MODULES"
  fi
  log "modules: $MODULES"
  log
else
  if [ ! -f "$DOTFILESRC_PATH" ]; then
    log_error "Please run full setup first (without parameters)"
    exit 1
  fi

  MODULES="$*"
fi

save_IFS=$IFS
IFS=' '
for MODULE in $MODULES; do
  log
  log "$(hr)"
  log "Performing '$MODULE' module setup..."

  if [ ! -f "$DOTFILES_PATH/$MODULE/setup.sh" ]; then
    log_error "Module '$MODULE' does not exist."
    exit 1
  fi

  if [ "$DOTFILES_HAS_GUI" -eq 0 ]; then
    skip_module=0
    for gm in $GUI_MODULES; do
      if [ "$MODULE" = "$gm" ]; then
        skip_module=1
        break
      fi
    done
    if [ $skip_module -eq 1 ]; then
      log "Skipping GUI module '$MODULE' (no graphical environment)"
      continue
    fi
  fi

  # Execute module in subshell to isolate error handling from set -e
  set +e
  # shellcheck disable=SC1090
  (
    set -e
    . "$DOTFILES_PATH/$MODULE/setup.sh"
  )
  MODULE_EXIT_CODE=$?
  set -e

  if [ $MODULE_EXIT_CODE -ne 0 ]; then
    log_error "Module '$MODULE' setup failed." "$LOG_FILE"
    exit 1
  fi

  # Source module's env file into parent shell so subsequent
  # modules inherit exported variables (e.g. brew PATH from homebrew)
  if [ -f "$DOTFILES_PATH/$MODULE/env" ]; then
    # shellcheck disable=SC1090
    . "$DOTFILES_PATH/$MODULE/env"
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
