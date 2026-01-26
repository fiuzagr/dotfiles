#!/usr/bin/env sh

get_brew_prefix() {
  if is_macos; then
    if [ -d "/opt/homebrew" ]; then
      echo "/opt/homebrew"
    else
      echo "/usr/local"
    fi
  else
    echo "/home/linuxbrew/.linuxbrew"
  fi
}

BREW_PREFIX=$(get_brew_prefix)

if ! command -v brew >/dev/null 2>&1; then
  NONINTERACTIVE=1 bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

eval "$("$BREW_PREFIX"/bin/brew shellenv)"

to_dotfilesrc ". \"\$DOTFILES_PATH/homebrew/env\""
