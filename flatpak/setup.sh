#!/usr/bin/env sh

sudo apt install -y flatpak gnome-software-plugin-flatpak

flatpak remote-add --if-not-exists --user flathub https://dl.flathub.org/repo/flathub.flatpakrepo
