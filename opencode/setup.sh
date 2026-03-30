#!/usr/bin/env sh

brew install oven-sh/bun/bun
brew install anomalyco/tap/opencode

if is_macos; then
  brew tap nguyenphutrong/tap
  brew install --cask quotio
  xattr -cr /Applications/Quotio.app
elif is_linux; then
  brew install cliproxyapi
  brew services start cliproxyapi
fi

create_symlink "$DOTFILES_PATH/opencode/config" "$HOME/.config/opencode"

export DISABLE_TELEMETRY=1

npx --yes skills add https://github.com/vercel-labs/agent-browser --yes --global --copy --agent opencode --skill agent-browser
npx --yes skills add https://github.com/expo/skills --yes --global --copy --agent opencode --skill building-native-ui expo-api-routes
npx --yes @tech-leads-club/agent-skills install --global --copy --agent opencode --skill tlc-spec-driven
npx --yes @tech-leads-club/agent-skills install --global --copy --agent opencode --skill playwright-skill
npx --yes @tech-leads-club/agent-skills install --global --copy --agent opencode --skill figma
npx --yes @tech-leads-club/agent-skills install --global --copy --agent opencode --skill figma-implement-design
npx --yes @tech-leads-club/agent-skills install --global --copy --agent opencode --skill skill-creator
npx --yes @tech-leads-club/agent-skills install --global --copy --agent opencode --skill subagent-creator
npx --yes @tech-leads-club/agent-skills install --global --copy --agent opencode --skill technical-design-doc-creator
npx --yes @tech-leads-club/agent-skills install --global --copy --agent opencode --skill coding-guidelines
npx --yes @tech-leads-club/agent-skills install --global --copy --agent opencode --skill docs-writer
