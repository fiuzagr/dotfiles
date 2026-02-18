# Project State

**Last Updated:** 2025-02-18

## Current Session Status

- **Status:** Feature implemented: LLM Command Generator
- **Task:** Completed implementation of `llm` CLI tool
- **Progress:** All tasks done, tests passing, documentation updated

## Key Decisions

1. **POSIX Shell:** Maintaining pure POSIX sh compatibility (no bashisms)
   - Reason: Portability across different systems and shells
   - Impact: Cannot use bash/zsh-specific features

2. **Homebrew First:** Prefer Homebrew over native package managers
   - Reason: Consistency between macOS and Linux
   - Impact: Requires Homebrew installation as first step

3. **Module-Based Architecture:** Each tool/feature in its own directory
    - Reason: Easy to enable/disable, test, and maintain
    - Impact: Some duplication (each module has setup.sh + env)

4. **Ghostty Terminal:** Migration from Alacritty to Ghostty
    - Reason: Ghostty is cross-platform (macOS + Linux) with better Rust-based architecture
    - Impact: Removed Alacritty module, updated documentation and module ordering

5. **LLM Command Generator:** Using OpenRouter API (not Ollama)
    - Reason: OpenRouter provides access to multiple LLM providers with single API
    - Impact: Requires `OPENROUTER_API_KEY` environment variable, no local LLM dependency
    - Default model: `anthropic/claude-3.5-sonnet` (best balance for command generation)

## Known Issues & TODOs

- [ ] test.sh needs expansion to cover more helpers.sh functions
- [ ] Missing documentation for individual modules
- [ ] No dry-run mode for setup.sh
- [ ] Limited error recovery in setup process
- [ ] OpenCode skills installation needs improvement (hardcoded npx commands)
- [x] **DONE:** Implement `llm` command generator (spec at `.specs/features/llm/`)

## Decisions to Make

- **Module Ordering:** Current order in setup.sh line 60 is critical - should document dependencies
- **Environment Variables:** Should centralize common exports across modules
- **Testing Framework:** Consider using shunit2 or bats for shell testing

## Session Notes

### Analysis Summary

Explored complete codebase structure:

**Total Modules:** 20+
- Core: base, shell, local, fonts, homebrew
- Development: git, node, rustup, uv, nvim
- Tools: terminal-tools, tmux, ghostty, docker
- Optional: devtoys, opencode, flatpak, android, gpg, ssh

**Key Files:**
- setup.sh (114 lines) - Main orchestrator
- helpers.sh (285 lines) - Core utilities
- test.sh (99 lines) - Basic test suite

**Architecture Pattern:** Modular setup system
- Each module has: setup.sh + optional env file
- Main setup.sh sources individual module scripts
- Order-dependent (homebrew must run before node, etc.)

**Tech Stack Identified:**
- POSIX shell (sh)
- Homebrew + apt package managers
- npm, Cargo, uv, etc. for language package managers
- Git integration with opencode

## Recent Changes (Feb 2025)

- **LLM Command Generator Implemented:** Created `local/bin/llm` script with OpenRouter API integration, confirmation prompts, clipboard support, and command history
- **LLM Command Generator Planning:** Created spec-driven documentation at `.specs/features/llm/` with spec.md, design.md, and tasks.md
- **Terminal Migration:** Migrated from Alacritty to Ghostty as default terminal emulator
- **Nvim Plugins Activated:** Enabled `diagram.nvim` and `image.nvim` plugins in LazyVim configuration
- **Simplified Alacritty Setup:** Removed Linux-specific update-alternatives code from alacritty/setup.sh
- **Updated Module Order:** Ghostty now replaces Alacritty in setup.sh execution order

## Blockers

None currently identified - project is in active development phase.

## Next Steps (After This Session)

1. **Immediate:** Test `llm` command with real OpenRouter API key
2. **Short-term:** Document each module in README
3. **Medium-term:** Expand test coverage with proper shell test framework
4. **Long-term:** Build community feedback loop for module improvements
