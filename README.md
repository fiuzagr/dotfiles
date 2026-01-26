# ~/.dotfiles

<!--toc:start-->

- [~/.dotfiles](#dotfiles)
  - [Installation](#installation)
    - [1. Clone this repository](#1-clone-this-repository)
    - [2. Run setup.sh script](#2-run-setupsh-script)
  - [Full setup features](#full-setup-features)
    - [Package managers](#package-managers)
    - [Terminal tools](#terminal-tools)
    - [And more](#and-more)
  - [Additional modules](#additional-modules)
  <!--toc:end-->

Set up a fresh installation of **GNOME Debian-based Linux** or **macOS** systems.

> NOTE: Supports `bash` and `zsh` shells

## Installation

### 1. Clone this repository

```shell
git clone https://github.com/fiuzagr/dotfiles.git ~/.dotfiles
```

### 2. Run setup.sh script

```shell
sh ~/.dotfiles/setup.sh
```

> TIP: This is an idempotent tool. You can run it multiple times without any
> issues.

> WARNING: If you cancel the full setup script, it will not revert any of the
> changes made, and it potentially crashes the previous dotfiles configuration.
> But this is not a problem, run the full setup again to ensure that all
> configurations are applied.

```shell
sh ~/.dotfiles/setup.sh
```

This creates an alias `dotfiles` to run `setup.sh`.

## Full setup features

### Package managers

- Homebrew (preferred)
- Cargo
- Flatpak
- NPM, Bun & Deno
- UV

### Terminal tools

- Starship as your prompt
- Atuin as your shell history
- Carapace as your shell completion
- and more...

### And more

- Docker Desktop
- NeoVim
- Alacritty Terminal
- ...

## Additional modules

Install the following modules with `dotfiles <module1> <module2> ...` after a
full setup

- [devtoys](https://devtoys.app)
- [opencode](https://opencode.ai/) (With [OmO](https://github.com/code-yeongyu/oh-my-opencode))

---

> Chupinhado from <https://github.com/luanfrv0/dotfiles>
