#!/usr/bin/env sh

if command -v sdk >/dev/null 2>&1; then
  log "SDKMAN is already installed. Skipping installation."
else
  curl -s "https://get.sdkman.io" | bash
fi

sdk install java 17-zulu
sdk default java 17-zulu

# base (cmdline-tools + sdkmanager)
brew install --cask android-commandlinetools

. "$DOTFILES_PATH/android/env"
to_dotfilesrc ". \"\$DOTFILES_PATH/android/env\""

# build-tools
sdkmanager --install "platform-tools" "platforms;android-36" "build-tools;36.0.0"
# emulador + imagem (só se for usar emulador):
sdkmanager --install "emulator" "system-images;android-36;google_apis;arm64-v8a"
# NDK (só se compilar código nativo):
sdkmanager --install "ndk;27.0.12077973"
