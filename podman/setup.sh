#!/usr/bin/env sh

sudo apt install -y uidmap

brew install podman
brew install podman-compose
brew install podman-tui

flatpak install -y --user flathub io.podman_desktop.PodmanDesktop

create_symlink "$(brew --prefix podman)/bin/podman" "$HOME/.local/bin/docker"
create_symlink "$(brew --prefix podman-compose)/bin/podman-compose" "$HOME/.local/bin/docker-compose"
