#!/usr/bin/env sh

if is_headless; then
  brew_install docker docker-buildx docker-compose docker-engine
  brew_install yq

  if ! getent group docker >/dev/null 2>&1; then
    sudo groupadd docker
  fi
  if ! id -nG "$(whoami)" | grep -qw docker; then
    sudo usermod -aG docker "$(whoami)"
    log "Added $(whoami) to docker group — re-login required"
  fi

  sudo --preserve-env=HOME "$(brew --prefix)/bin/brew" services start docker-engine &
  _ds_pid=$!
  _ds_wait=0
  while kill -0 "$_ds_pid" 2>/dev/null && [ "$_ds_wait" -lt 30 ]; do
    sleep 1
    _ds_wait=$((_ds_wait + 1))
  done
  if kill -0 "$_ds_pid" 2>/dev/null; then
    sudo kill "$_ds_pid" 2>/dev/null || true
    log "Warning: docker-engine service start timed out"
    log "Run manually: sudo brew services start docker-engine"
  fi

  mkdir -p "$HOME/.docker"
  DOCKER_CONFIG="$HOME/.docker/config.json"
  HOMEBREW_PREFIX="$(brew --prefix)"
  PLUGINS_DIR="$HOMEBREW_PREFIX/lib/docker/cli-plugins"

  if [ ! -f "$DOCKER_CONFIG" ]; then
    echo '{}' >"$DOCKER_CONFIG"
  fi
  yq -i ".cliPluginsExtraDirs = ((.cliPluginsExtraDirs // []) + [\"$PLUGINS_DIR\"]) | .cliPluginsExtraDirs |= unique" "$DOCKER_CONFIG"
  log "Configured Docker cliPluginsExtraDirs: $PLUGINS_DIR"
else
  brew_install --cask docker-desktop
fi
