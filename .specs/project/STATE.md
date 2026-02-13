# Project State

**Last Updated:** 2025-01-28

## Current Session Status

- **Status:** Initializing project with TLC Spec-Driven workflow
- **Task:** Setting up .specs/ documentation structure
- **Progress:** Creating PROJECT.md, ROADMAP.md, and brownfield mapping docs

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

## Known Issues & TODOs

- [ ] test.sh needs expansion to cover more helpers.sh functions
- [ ] Missing documentation for individual modules
- [ ] No dry-run mode for setup.sh
- [ ] Limited error recovery in setup process
- [ ] OpenCode skills installation needs improvement (hardcoded npx commands)

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
- Tools: terminal-tools, tmux, alacritty, docker
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

## Blockers

None currently identified - project is in active development phase.

## Next Steps (After This Session)

1. **Short-term:** Document each module in README
2. **Medium-term:** Expand test coverage with proper shell test framework
3. **Long-term:** Build community feedback loop for module improvements
