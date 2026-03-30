# AGENTS.md - Agent Guide for Dotfiles

This guide helps AI agents navigate and work effectively with the dotfiles codebase.

---

## Quick Reference

### Build/Test Commands

```bash
# Full setup (installs all modules)
sh setup.sh

# Selective module setup
sh setup.sh <module1> <module2> ...

# Run tests
sh test.sh

# Verify specific function
# Edit test.sh to isolate individual test functions
```

### Available Modules

**System Setup:** base, shell, local, fonts, homebrew
**Development:** git, nvim, node, rustup, uv, docker
**Terminal:** terminal-tools, tmux, ghostty
**Optional:** opencode, devtoys, flatpak, android, gpg, ssh

---

## Project Context Summary

**Type:** Cross-platform shell-based dotfiles for macOS & Linux
**Tech:** POSIX sh (no bash/zsh features)
**Purpose:** Reduce new machine setup from hours to minutes with idempotent scripts
**Scope:** 20+ modules covering development tools, terminal config, and system setup

**For complete project context, see:** `.specs/project/PROJECT.md`

---

## When to Load Spec Files

The `.specs/` directory contains detailed specifications. Reference these files based on your task:

### Planning & Understanding Project

| Task | Load File | When/Why |
|------|-----------|----------|
| **Understand project vision** | `.specs/project/PROJECT.md` | Project goals, scope, tech decisions, and constraints |
| **Check current status** | `.specs/project/STATE.md` | Project progress, decisions made, known issues, blockers |
| **See roadmap** | `.specs/project/ROADMAP.md` | Planned features, milestones, upcoming work |

**When to load:** Before starting work, when understanding project direction, when evaluating scope of changes

---

### Implementation & Code Changes

| Task | Load File | When/Why |
|------|-----------|----------|
| **Check supported tech** | `.specs/codebase/STACK.md` | All tools/languages, versions, platform-specific details |
| **Understand patterns** | `.specs/codebase/ARCHITECTURE.md` | Module patterns, data flow, orchestration, error handling, dependencies |
| **Follow code style** | `.specs/codebase/CONVENTIONS.md` | Naming, formatting, POSIX compliance, comments, error handling patterns |
| **Find file locations** | `.specs/codebase/STRUCTURE.md` | Directory tree, file organization, configuration locations, module layout |
| **Integrate external services** | `.specs/codebase/INTEGRATIONS.md` | External APIs/services, configuration, auth methods, usage patterns |
| **Modify/extend tests** | `.specs/codebase/TESTING.md` | Testing frameworks, current coverage, best practices, planned improvements |

**When to load:**
- **STACK.md** → When adding dependencies or checking tool versions
- **ARCHITECTURE.md** → When modifying core scripts or adding new modules
- **CONVENTIONS.md** → When writing any shell code (critical for consistency)
- **STRUCTURE.md** → When creating new files or understanding file organization
- **INTEGRATIONS.md** → When connecting to external services or tools
- **TESTING.md** → When writing or modifying tests

---

## Essential Conventions (Summary)

**Load full version from `.specs/codebase/CONVENTIONS.md` for complete details.**

### Critical Rules

**POSIX Compliance:**
- Use only `#!/usr/bin/env sh` shebang
- No bash/zsh-specific features
- Use `[ ... ]` for conditionals, never `[[ ... ]]`
- Use `$()` for command substitution, never backticks
- No arrays, associative arrays, or substring expansion

**Safety & Error Handling:**
- Always use `set -ae` (abort on error, auto-export)
- Send errors to stderr with `>&2`
- Use `exit 1` for failures, `exit 0` for success
- Check file/directory existence before operations

**Naming Conventions:**
- **Functions:** lowercase_with_underscores
- **Exports:** UPPERCASE_WITH_UNDERSCORES
- **Local variables:** lowercase_with_underscores, function-scoped
- **Files:** lowercase-with-hyphens (setup.sh, helpers.sh)

**Code Style:**
- Indentation: 2 spaces (enforced by .editorconfig)
- Line length: 80 characters max
- Final newline: Required in all files
- Quote all variable expansions: `"$var"` not `$var`

**Documentation:**
- Document functions above definition with parameters and examples
- Comment *why*, not *what*
- Keep inline comments minimal
- Reference external resources for complex logic

---

## Helper Functions Quick Reference

**Load full documentation from `.specs/codebase/ARCHITECTURE.md` for usage examples.**

### OS/Shell Detection

```sh
get_os()              # Returns "darwin" or "linux"
is_macos()            # Returns 0 on macOS, 1 otherwise
is_linux()            # Returns 0 on Linux, 1 otherwise
get_shell()           # Returns "zsh" or "bash"
```

### File Operations

```sh
to_file()             # Append line to file with regex test (core implementation)
to_bashrc()           # Append to ~/.bashrc if not exists
to_zshrc()            # Append to ~/.zshrc if not exists
to_dotfilesrc()       # Append to ~/.dotfilesrc if not exists
to_shell_rc()         # Platform-agnostic RC appender (calls bash/zsh)
create_symlink()      # Create symlink with auto-backup of existing
link_tree()           # Create tree of symlinks from source directory
```

### Utilities

```sh
copy_to_clipboard()   # Cross-platform clipboard (pbcopy/xclip)
log()                 # User-facing logging to console & log file
log_error()           # Error logging with formatting
```

**Key patterns:**
- All functions check prerequisites before executing
- Idempotent design (safe to run multiple times)
- Error messages to stderr with context
- Local variables use function-specific prefixes (tf_, cs_, etc.)

---

## Module Architecture

**Load full details from `.specs/codebase/ARCHITECTURE.md`**

### Module Structure

Each module directory contains:
- `setup.sh` - Installation and configuration script
- `env` (optional) - Environment variables and tool initialization

### Execution Pattern

```sh
# setup.sh runs in subshell with set -e
# 1. Install packages (brew/apt)
# 2. Create symlinks for configs
# 3. Register module/env in ~/.dotfilesrc
# 4. Source module/env if it exists
```

### Key Principles

- **Modular:** Each module is self-contained and order-independent (except noted dependencies)
- **Idempotent:** Can run multiple times without issues
- **Cross-platform:** Conditional logic for macOS vs Linux
- **Environment isolation:** Each module exports its own variables

### Module Dependencies

**Critical order (must run first):**
```
base → shell → local → fonts → homebrew → [others]
```

**Load detailed dependency graph from `.specs/codebase/ARCHITECTURE.md`**

---

## Code Quality Standards

### Before Committing

1. **Test your changes:**
   ```bash
   sh test.sh
   ```

2. **Check POSIX compliance:**
   - No bashisms or zsh-specific syntax
   - All variables quoted
   - Use `[ ... ]` not `[[ ... ]]`

3. **Follow conventions:**
   - Reference `.specs/codebase/CONVENTIONS.md`
   - 2-space indentation
   - 80-character line limit
   - Function documentation above definition

4. **Run helpers.sh tests:**
   ```bash
   sh test.sh
   ```

### Error Handling Checklist

- [ ] All error messages sent to stderr (`>&2`)
- [ ] Functions return proper exit codes (0 for success, 1 for error)
- [ ] File/directory existence checked before operations
- [ ] Idempotent behavior verified (run twice, same result)
- [ ] Temporary files cleaned up properly

---

## Workflow: Adding a New Module

1. **Reference architecture:** Load `.specs/codebase/ARCHITECTURE.md` for patterns
2. **Follow conventions:** Review `.specs/codebase/CONVENTIONS.md` for code style
3. **Create structure:** `mkdir [module] && touch [module]/setup.sh`
4. **Implement setup:** Follow module pattern from ARCHITECTURE.md
5. **Test thoroughly:** Add test cases to test.sh
6. **Document:** Add function documentation and comments
7. **Update:** Add module to setup.sh module list in correct order

**Reference:** `.specs/codebase/STRUCTURE.md` for directory organization

---

## Workflow: Fixing a Bug

1. **Understand scope:** Check `.specs/project/STATE.md` for known issues
2. **Analyze code:** Review `.specs/codebase/ARCHITECTURE.md` for pattern context
3. **Locate function:** Check `.specs/codebase/STRUCTURE.md` for file locations
4. **Check tests:** See `.specs/codebase/TESTING.md` for test patterns
5. **Implement fix:** Follow error handling from CONVENTIONS.md
6. **Add tests:** Extend test.sh with regression test
7. **Verify:** Run `sh test.sh` and verify idempotency

---

## Workflow: Adding Features

1. **Check roadmap:** `.specs/project/ROADMAP.md` for planned features
2. **Verify scope:** Ensure it fits project vision in PROJECT.md
3. **Plan implementation:** Reference ARCHITECTURE.md and STRUCTURE.md
4. **Code carefully:** Follow all CONVENTIONS.md rules
5. **Test extensively:** Add tests in test.sh
6. **Update docs:** Reference updated files in README.md and AGENTS.md
7. **Commit:** Clear commit message explaining *why* (not *what*)

---

## Troubleshooting

### Setup Failures

Check the setup log:
```bash
cat ~/.dotfiles/setup.log
```

Re-run with verbose output:
```bash
sh setup.sh 2>&1 | tee setup-debug.log
```

### Module-Specific Issues

**Load integration details from `.specs/codebase/INTEGRATIONS.md`** for service-specific troubleshooting

### Testing Issues

**Load testing guide from `.specs/codebase/TESTING.md`** for test execution and patterns

---

## File Locations Summary

| File | Purpose | Created By |
|------|---------|------------|
| `~/.dotfilesrc` | Main env exports | setup.sh |
| `~/.bashrc` | Bash config | to_bashrc() |
| `~/.zshrc` | Zsh config | to_zshrc() |
| `~/.gitconfig` | Git config | git/setup.sh |
| `~/.config/nvim/lua` | Neovim config | nvim/setup.sh |
| `~/.config/starship.toml` | Prompt config | terminal-tools/setup.sh |
| `~/.local/bin/` | Custom scripts | local/setup.sh |
| `~/.dotfiles/setup.log` | Setup output | setup.sh |

---

## Decision Log

**Load complete decision log from `.specs/project/STATE.md`**

Key architectural decisions:
1. **POSIX Shell:** Portability across different systems
2. **Homebrew First:** Consistency between platforms
3. **Module-Based:** Easy to enable/disable, test, and maintain
4. **Idempotent Design:** Safe to run multiple times

---

## Next Steps for Agents

When starting work on this codebase:

1. **Load `.specs/project/PROJECT.md`** - Understand vision and scope
2. **Load `.specs/codebase/ARCHITECTURE.md`** - Understand patterns
3. **Load `.specs/codebase/CONVENTIONS.md`** - Know code style rules
4. **Load `.specs/codebase/STRUCTURE.md`** - Know where everything is
5. **Check `.specs/codebase/TESTING.md`** - Know how to test
6. **Reference `.specs/codebase/INTEGRATIONS.md`** - For external service details

**Then start coding following the Essential Conventions summary above.**

---

Last Updated: 2025-01-28
