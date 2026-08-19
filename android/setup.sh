#!/usr/bin/env sh

brew_install --cask temurin@17

# base (cmdline-tools + sdkmanager)
brew_install --cask android-commandlinetools

. "$DOTFILES_PATH/android/env"
to_dotfilesrc ". \"\$DOTFILES_PATH/android/env\""

# accept all licenses
yes | sdkmanager --licenses >/dev/null 2>&1

# build-tools
sdkmanager --install "platform-tools" "platforms;android-36" "build-tools;36.0.0"
# NDK (só se compilar código nativo):
sdkmanager --install "ndk;27.0.12077973"
# emulador + imagem (GUI only):
if ! is_headless; then
  sdkmanager --install "emulator" "system-images;android-36;google_apis;arm64-v8a"
fi
