#!/usr/bin/env sh

if is_linux; then
  sudo apt update -y
  sudo apt install -y dpkg \
      build-essential \
      make \
      perl \
      gcc \
      curl \
      file \
      git \
      unzip \
      wget \
      xsel \
      xclip \
      cmake \
      pkg-config \
      libfreetype6-dev \
      libfontconfig1-dev \
      libxcb-xfixes0-dev \
      libxkbcommon-dev \
      python3 \
      stow
elif is_macos; then
  # Install Xcode Command Line Tools if not present
  if ! xcode-select -p >/dev/null 2>&1; then
    log "Installing Xcode Command Line Tools..."
    xcode-select --install
    log "Waiting for Xcode Command Line Tools installation..."
    until xcode-select -p >/dev/null 2>&1; do sleep 5; done
    log "Xcode Command Line Tools installation complete"
  else
    log "Xcode Command Line Tools already installed"
  fi
fi

