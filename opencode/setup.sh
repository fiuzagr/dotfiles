#!/usr/bin/env sh

brew_install oven-sh/bun/bun
brew_install anomalyco/tap/opencode

# if is_macos; then
#   brew tap nguyenphutrong/tap
#   brew install --cask quotio
#   xattr -cr /Applications/Quotio.app
# elif is_linux; then
#   brew install cliproxyapi
#   brew services start cliproxyapi
# fi

create_symlink "$DOTFILES_PATH/opencode/config" "$HOME/.config/opencode"

# uv tool install --python 5.13 "headroom-ai[proxy,ml,code,mcp]"
# create_symlink "$DOTFILES_PATH/opencode/bin/hopencode" "$HOME/.local/bin/hopencode"
