#!/usr/bin/env sh

if is_linux; then
  install_system_packages chromium
elif is_macos; then
  brew_install --cask chromium
fi

link_tree "$DOTFILES_PATH/chrome-devtools/bin" "$HOME/.local/bin"

chrome_bin=""
for cmd in chromium google-chrome google-chrome-stable chromium-browser; do
  if command -v "$cmd" >/dev/null 2>&1; then
    chrome_bin="$(command -v "$cmd")"
    break
  fi
done

if [ -z "$chrome_bin" ]; then
  log_error "No Chrome/Chromium binary found after install"
  exit 1
fi

chrome_version="$("$chrome_bin" --version 2>/dev/null || echo 'version unavailable')"
log "Chrome/Chromium: $chrome_bin ($chrome_version)"
log "Browser wrapper: ~/.local/bin/chromium-mcp-browser"
log "MCP wrapper: ~/.local/bin/chrome-devtools-mcp"
