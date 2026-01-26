#!/usr/bin/env sh

brew install sst/tap/opencode
brew install oven-sh/bun/bun

bunx oh-my-opencode install --no-tui --claude=no --gemini=no --copilot=no --openai=no --opencode-zen=no --zai-coding-plan=no

link_tree "$DOTFILES_PATH/opencode/bin" "$HOME/.local/bin"

create_symlink "$DOTFILES_PATH/opencode/config" "$HOME/.config/opencode"
