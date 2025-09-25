#!/usr/bin/env sh

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

