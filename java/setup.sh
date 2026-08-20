#!/usr/bin/env sh

# OpenJDK 17 via brew (cross-platform, keg-only)
brew_install openjdk@17

# jenv for Java version management
brew_install jenv

# Initialize jenv and register the JDK
mkdir -p "$HOME/.jenv/versions"
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

if is_macos; then
  jenv add "$(brew --prefix openjdk@17)/libexec/openjdk.jdk/Contents/Home"
else
  jenv add "$(brew --prefix openjdk@17)"
fi

jenv global 17 2>/dev/null || jenv global 17.0 2>/dev/null || true
jenv enable-plugin export 2>/dev/null || true

to_dotfilesrc ". \"\$DOTFILES_PATH/java/env\""

. "$DOTFILES_PATH/java/env"

log "Java installed: $(java -version 2>&1 | head -1)"
