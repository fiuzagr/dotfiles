# Code Conventions

**Analyzed:** 2025-01-28

## Naming Conventions

### Files

**Pattern:** Lowercase with hyphens for word separation

**Examples from codebase:**
- `setup.sh` - Module setup scripts
- `helpers.sh` - Utility functions
- `gitconfig` - Git configuration
- `.zshrc`, `.bashrc` - Shell RC files
- `alacritty.toml` - Tool config files
- `starship.toml` - Starship prompt config

**Convention:** No special prefixes, descriptive names

### Functions

**Pattern:** Lowercase with underscores, prefixed with module or purpose

**Examples from codebase:**

```sh
# Helpers (no prefix, globally available)
get_os()
is_macos()
is_linux()
get_shell()
create_symlink()
link_tree()
to_file()
to_bashrc()
to_zshrc()
to_dotfilesrc()
to_shell_rc()
copy_to_clipboard()
log()
log_error()

# Module-specific (prefixed)
get_brew_prefix()  # In homebrew/setup.sh
```

**Naming Rules:**
- Lowercase with underscores
- Descriptive and concise
- Action-oriented verbs (get_, is_, create_, to_)
- No CamelCase or PascalCase

### Variables

**Pattern:** UPPERCASE for environment exports, lowercase for local

**Examples from codebase:**

```sh
# Environment exports (UPPERCASE)
export DOTFILES_PATH
export DOTFILESRC_PATH
export DOTFILES_OS
export DOTFILES_SHELL
export DISABLE_TELEMETRY
export BREW_PREFIX
export PATH
export CARAPACE_BRIDGES

# Local variables (lowercase with underscores)
module=
modules=
file_size=
tf_file=
cs_src=
cs_dst=
cs_src_abs=
save_IFS=
```

**Scope Indicators:**
- Short prefixes for local function scope: `tf_`, `cs_`, `lt_`, `go_`
- Used to avoid variable collision in functions
- Example: `to_file()` uses `tf_*` prefix (tf_file, tf_test_or_line, etc.)

### Constants

**Pattern:** UPPERCASE for hardcoded values

**Examples from codebase:**

```sh
LOG_MAX_SIZE=$((3 * 1024 * 1024))  # 3MB in bytes
NONINTERACTIVE=1                    # For unattended brew install
```

## Code Organization

### Import/Dependency Declaration

**Pattern:** Load helpers.sh first, then conditional logic

**Example from setup.sh (lines 30-44):**

```sh
. "$DOTFILES_PATH/helpers.sh"

# Export OS and shell detection
DOTFILES_OS=$(get_os)
export DOTFILES_OS

DOTFILES_SHELL=$(get_shell)
export DOTFILES_SHELL
```

**Ordering:**
1. Shebang and mode settings (set -ae)
2. Path setup
3. Source dependencies (helpers.sh)
4. Environment detection
5. Main logic

### File Structure

**Pattern:** Setup → Environment → Module logic

**Typical module structure:**

```sh
#!/usr/bin/env sh

# Comments explaining the module

# Installation/setup commands
brew install tool1
brew install tool2

# Configuration
create_symlink "source" "destination"
to_dotfilesrc "export VARIABLE=value"

# Source this module's env if it exists
. "$DOTFILES_PATH/module/env"
```

**Characteristics:**
- Minimal comments (self-documenting code)
- Direct execution (no wrapper functions in modules)
- Uses helper functions from helpers.sh

## Type Safety/Documentation

**Approach:** POSIX shell has no static typing; rely on function documentation

**Pattern:** Comments above functions explaining parameters

**Example from helpers.sh:**

```sh
# Append a line to .bashrc if it doesn't already exist
# $1 - file to test and append
# $2 - regex test OR line to append
# $3 - line to append (if $2 is regex test)
# Usages:
#   to_file '~/.bashrc' 'export PATH=$HOME/.local/bin:$PATH'
#   to_file '~/.bashrc' '\\.my_custom_script' 'source $HOME/.my_custom_script'
to_file() {
```

**Documentation Style:**
- Parameter descriptions ($1, $2, etc.)
- Usage examples with actual calls
- Return value behavior (if non-obvious)

## Error Handling

**Pattern:** Fail-fast with message logging

**Example from helpers.sh:**

```sh
if [ -z "$cs_src" ] || [ -z "$cs_dst" ]; then
  echo "Error: Both source and destination paths are required" >&2
  exit 1
fi

if [ ! -e "$cs_src" ]; then
  echo "Error: Source path '$cs_src' does not exist" >&2
  exit 1
fi
```

**Conventions:**
- Errors to stderr (`>&2`)
- Exit code 1 for failures
- Clear error messages with context
- `set -e` in subshells to fail on any error
- Idempotent operations (check before acting)

**Logging Pattern:**

```sh
log() {
  echo "$*" >&3  # Redirect to original stdout (setup.sh redirects 1>&3)
  return
}

log_error() {
  log
  log "$(hr)"
  log "$(fgc red)$(e x) Error: $1 $(fgc end)"
  if [ "$2" != "" ]; then
    log "See $2 for details."
  fi
  log "$(hr)"
}
```

## Comments/Documentation

**Style:** Sparse comments, self-documenting code

**Example from setup.sh:**

```sh
# Rotate log if it grows too large
if [ -f "$LOG_FILE" ]; then
  file_size=$(wc -c <"$LOG_FILE")
  if [ "$file_size" -gt "$LOG_MAX_SIZE" ]; then
    mv "$LOG_FILE" "$LOG_FILE.old"
    touch "$LOG_FILE"
  fi
fi

# redirect stdout/stderr to log file
# see https://serverfault.com/a/103569
exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3 15
exec 1>>"$LOG_FILE" 2>&1
```

**Rules:**
- Comment why, not what
- Reference external resources when complex
- Keep inline comments minimal
- Use function documentation for complex logic

## POSIX Shell Compliance

**Critical Rule:** No bash/zsh-specific features

**Forbidden:**
- Arrays/associative arrays (use loops instead)
- `[[` test operator (use `[` only)
- `${parameter:offset:length}` substring expansion
- `$'...'` ANSI-C quoting
- Local variables (use scope prefixes)

**Required:**
- `[ ... ]` for all conditionals
- `$()` for command substitution (not backticks)
- Double-quote all variable expansions
- Use `\` for line continuation (not \ at end of line in general)

**Validation:** ShellCheck annotations used

```sh
# shellcheck disable=SC2005 # useless echo?
# shellcheck disable=SC1090 # can't follow non-constant source
```

## Shebang & Mode Settings

**Pattern:** POSIX shell with strict error handling

```sh
#!/usr/bin/env sh
set -ae  # -a: export all; -e: exit on error
```

**Usage in modules:**
- Main setup.sh uses `set -ae`
- Modules run in subshells with `set -e`
- Controlled error handling to allow module failure isolation
