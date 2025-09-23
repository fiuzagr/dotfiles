# ~/.dotfiles

Set up a fresh installation of **GNOME Debian-based** systems.

> Only `bash` is supported as a shell

## Installation

### 1. clone this repository

```shell
git clone https://github.com/fiuzagr/dotfiles.git ~/.dotfiles
```

### 2. run setup.sh script

> This is an idempotent tool. You can run it multiple times without any issues.

#### to set up a full installation

```shell
sh ~/.dotfiles/setup.sh
```

#### to set up a specific module

```shell
sh ~/.dotfiles/setup.sh <module>
```

## Features

### Package managers

- Homebrew (preferred)
- Cargo (used to install Alacritty)
- Flatpak (used to install Dev Toolbox)
- NVM (used to install Node.js)
- NPM

### Terminals

- Alacritty as your default terminal

### Terminal tools

- Starship as your prompt
- Atuin as your shell history
- Carapace as your shell completion
- and more...

### And more

- [Dev Toolbox](https://flathub.org/en/apps/me.iepure.devtoolbox)
- [opencode](https://opencode.ai/)
- Vim from Homebrew
- Git from Homebrew
- ...

---

> Chupinhado from https://github.com/luanfrv0/dotfiles
