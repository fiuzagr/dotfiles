#!/usr/bin/env sh

if command -v sdkman >/dev/null 2>&1; then
  log "SDKMAN is already installed. Skipping installation."
else
  curl -s "https://get.sdkman.io" | bash
fi

sdkman install java 17-zulu
sdkman default java 17-zulu

brew install --cask android-commandlinetools

. "$DOTFILES_PATH/android/env"
to_dotfilesrc ". \"\$DOTFILES_PATH/android/env\""

sdkmanager --install "platform-tools" "platforms;android-35" "build-tools;35.0.1" "emulator" "system-images;android-35;google_apis;arm64-v8a"
