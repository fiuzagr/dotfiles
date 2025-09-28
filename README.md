# ~/.dotfiles

Set up a fresh installation of **GNOME Debian-based** systems.

> NOTE: Only `bash` is supported as a shell

## Installation

### 1. clone this repository

```shell
git clone https://github.com/fiuzagr/dotfiles.git ~/.dotfiles
```

### 2. run setup.sh script

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
- Cargo (used to install Alacritty)
- Flatpak (used to install Dev Toolbox)
- NVM (used to install Node.js and NPM)
- UV (phyton package manager)

### Terminals

- Alacritty as default terminal

### Terminal tools

- Starship as your prompt
- Atuin as your shell history
- Carapace as your shell completion
- and more...

### And more

- Podman from Homebrew as a Docker replacement
- Vim from Homebrew
- Git from Homebrew
- ...

## Additional modules

Install the following modules with `dotfiles <module1> <module2> ...` after a
full setup

- [devtoolbox](https://flathub.org/en/apps/me.iepure.devtoolbox)
- [opencode](https://opencode.ai/)
- jetbrains IDE (Webstorm only for now)

---

> Chupinhado from https://github.com/luanfrv0/dotfiles
