#!/usr/bin/env sh

sudo apt install -y uidmap

brew install podman
brew install podman-compose
brew install podman-tui

PODMAN_DESKTOP_PACKAGE=io.podman_desktop.PodmanDesktop

flatpak install -y --user flathub $PODMAN_DESKTOP_PACKAGE
flatpak override --user --filesystem=/home/linuxbrew/.linuxbrew:ro $PODMAN_DESKTOP_PACKAGE
flatpak override --user --env=PATH=/app/bin:/usr/bin:/home/linuxbrew/.linuxbrew/bin $PODMAN_DESKTOP_PACKAGE

create_symlink "$(brew --prefix podman)/bin/podman" "$HOME/.local/bin/docker"
create_symlink "$(brew --prefix podman-compose)/bin/podman-compose" "$HOME/.local/bin/docker-compose"
