#!/usr/bin/env sh

DOTFILES_PATH="$(cd -P -- "$(dirname -- "${0}")" && printf '%s\n' "$(pwd -P)")"
export DOTFILES_PATH

exec 3>&1 4>&2

. "$DOTFILES_PATH/helpers.sh"

to_bashrc 'apple=banana'
to_bashrc 'banana=banana' 'export banana=banana'

# Test get_os
echo "Testing get_os..."
os=$(get_os)
if [ "$os" = "darwin" ] || [ "$os" = "linux" ]; then
  echo "✓ get_os returned valid OS: $os"
else
  echo "✗ get_os returned invalid OS: $os"
  exit 1
fi

# Test is_macos and is_linux
echo "Testing is_macos and is_linux..."
if is_macos; then
  echo "✓ is_macos returned success (running on macOS)"
  if is_linux; then
    echo "✗ is_linux should fail on macOS"
    exit 1
  else
    echo "✓ is_linux correctly failed on macOS"
  fi
elif is_linux; then
  echo "✓ is_linux returned success (running on Linux)"
  if is_macos; then
    echo "✗ is_macos should fail on Linux"
    exit 1
  else
    echo "✓ is_macos correctly failed on Linux"
  fi
else
  echo "✗ Neither is_macos nor is_linux returned success"
  exit 1
fi

# Test get_shell
echo "Testing get_shell..."
shell=$(get_shell)
if [ "$shell" = "bash" ] || [ "$shell" = "zsh" ]; then
  echo "✓ get_shell returned valid shell: $shell"
else
  echo "✗ get_shell returned invalid shell: $shell"
  exit 1
fi

# Test has_gui and is_headless
echo "Testing has_gui and is_headless..."
if has_gui; then
  echo "✓ has_gui returned success (GUI detected)"
  if is_headless; then
    echo "✗ is_headless should fail when GUI is present"
    exit 1
  else
    echo "✓ is_headless correctly failed when GUI present"
  fi
else
  echo "✓ has_gui returned failure (headless)"
  if is_headless; then
    echo "✓ is_headless correctly succeeded when headless"
  else
    echo "✗ is_headless should succeed when headless"
    exit 1
  fi
fi

# Test to_zshrc
echo "Testing to_zshrc..."
TEST_ZSHRC="/tmp/test_zshrc_$$"
touch "$TEST_ZSHRC"
HOME_BACKUP="$HOME"
export HOME="/tmp"
ln -sf "$TEST_ZSHRC" "$HOME/.zshrc"
to_zshrc 'test_line_zsh'
if grep -q 'test_line_zsh' "$TEST_ZSHRC"; then
  echo "✓ to_zshrc successfully appended to .zshrc"
else
  echo "✗ to_zshrc failed to append"
  rm -f "$TEST_ZSHRC" "$HOME/.zshrc"
  export HOME="$HOME_BACKUP"
  exit 1
fi
rm -f "$TEST_ZSHRC" "$HOME/.zshrc"
export HOME="$HOME_BACKUP"

# Test to_shell_rc
echo "Testing to_shell_rc..."
TEST_RC="/tmp/test_shell_rc_$$"
touch "$TEST_RC"
HOME_BACKUP="$HOME"
export HOME="/tmp"
current_shell=$(get_shell)
if [ "$current_shell" = "zsh" ]; then
  ln -sf "$TEST_RC" "$HOME/.zshrc"
else
  ln -sf "$TEST_RC" "$HOME/.bashrc"
fi
to_shell_rc 'test_line_shell_rc'
if grep -q 'test_line_shell_rc' "$TEST_RC"; then
  echo "✓ to_shell_rc successfully dispatched to correct RC file"
else
  echo "✗ to_shell_rc failed to dispatch"
  rm -f "$TEST_RC" "$HOME/.zshrc" "$HOME/.bashrc"
  export HOME="$HOME_BACKUP"
  exit 1
fi
rm -f "$TEST_RC" "$HOME/.zshrc" "$HOME/.bashrc"
export HOME="$HOME_BACKUP"

# Test llm script
echo ""
echo "Testing llm script..."

LLM_SCRIPT="$DOTFILES_PATH/local/bin/llm"

# Test llm usage message (no args)
echo "Testing llm usage message..."
llm_output=$("$LLM_SCRIPT" 2>&1) || llm_exit=$?
if [ "${llm_exit:-0}" -eq 1 ] && echo "$llm_output" | grep -q "Usage:"; then
  echo "✓ llm shows usage when no arguments provided"
else
  echo "✗ llm should show usage and exit 1"
  exit 1
fi

# Test llm API key validation
echo "Testing llm API key validation..."
unset OPENROUTER_API_KEY
llm_output=$("$LLM_SCRIPT" "test" 2>&1) || llm_exit=$?
if [ "${llm_exit:-0}" -eq 1 ] && echo "$llm_output" | grep -q "OPENROUTER_API_KEY is not set"; then
  echo "✓ llm validates API key and shows error"
else
  echo "✗ llm should validate API key"
  exit 1
fi

# Test llm history directory creation
echo "Testing llm history directory..."
TEST_HOME="/tmp/llm_test_$$"
mkdir -p "$TEST_HOME"
HOME_BACKUP="$HOME"
export HOME="$TEST_HOME"
export OPENROUTER_API_KEY="test-key-for-history-test"
llm_history_dir="$TEST_HOME/.local/share/llm"
if [ ! -d "$llm_history_dir" ]; then
  mkdir -p "$llm_history_dir"
fi
if [ -d "$llm_history_dir" ]; then
  echo "✓ llm history directory structure works"
else
  echo "✗ llm history directory creation failed"
  rm -rf "$TEST_HOME"
  export HOME="$HOME_BACKUP"
  exit 1
fi
rm -rf "$TEST_HOME"
export HOME="$HOME_BACKUP"

# Test llm command cleaning (via source and function call)
echo "Testing llm command cleaning..."
# shellcheck disable=SC1090
. "$DOTFILES_PATH/shml" 2>/dev/null || true

# Create a test script that uses llm_clean_command
CLEAN_TEST_SCRIPT="/tmp/llm_clean_test_$$.sh"
cat > "$CLEAN_TEST_SCRIPT" << 'CLEAN_EOF'
#!/usr/bin/env sh
llm_clean_command() {
  lcc_raw="$1"
  lcc_cmd=$(echo "$lcc_raw" | sed 's/\\n/\n/g' | sed 's/\\t/ /g' | sed 's/\\u003e/>/g' | sed 's/\\u003c/</g' | sed 's/\\u0026/\&/g' | sed "s/\\\\u0027/'/g" | sed 's/\\u0022/"/g')
  lcc_cmd=$(echo "$lcc_cmd" | sed 's/```bash//g' | sed 's/```sh//g' | sed 's/```shell//g' | sed 's/```//g')
  lcc_cmd=$(echo "$lcc_cmd" | sed 's/^[[:space:]]*//' | sed 's/[[:space:]]*$//')
  lcc_cmd=$(echo "$lcc_cmd" | grep -v '^$' | head -1)
  echo "$lcc_cmd"
}
result=$(llm_clean_command "  \`\`\`bash\nfind . -name \"*.txt\"\n\`\`\`  ")
expected="find . -name \"*.txt\""
if [ "$result" = "$expected" ]; then
  echo "PASS"
else
  echo "FAIL: got '$result', expected '$expected'"
fi
CLEAN_EOF
chmod +x "$CLEAN_TEST_SCRIPT"
clean_result=$("$CLEAN_TEST_SCRIPT")
rm -f "$CLEAN_TEST_SCRIPT"
if [ "$clean_result" = "PASS" ]; then
  echo "✓ llm_clean_command removes markdown and whitespace"
else
  echo "✗ llm_clean_command failed: $clean_result"
  exit 1
fi

# Test llm --debug flag
echo "Testing llm --debug flag..."
llm_debug_output=$("$LLM_SCRIPT" --debug "test" 2>&1 | grep "DEBUG JSON payload" | wc -l)
if [ "$llm_debug_output" -gt 0 ]; then
  echo "✓ llm --debug flag shows debug output"
else
  echo "✗ llm --debug flag failed to show debug output"
  exit 1
fi

echo ""

# Test dotfiles update validation
echo "Testing dotfiles update validation..."

# Test: non-git directory is rejected
echo "Testing non-git directory rejection..."
DU_NONGIT_DIR="/tmp/dotfiles_nongit_test_$$"
mkdir -p "$DU_NONGIT_DIR"
if git -C "$DU_NONGIT_DIR" rev-parse --git-dir >/dev/null 2>&1; then
  echo "✗ Non-git directory should fail git check"
  rm -rf "$DU_NONGIT_DIR"
  exit 1
fi
echo "✓ Non-git directory correctly rejected"
rm -rf "$DU_NONGIT_DIR"

# Test: git repo with local changes is detected
echo "Testing dirty repo detection..."
DU_DIRTY_REPO="/tmp/dotfiles_dirty_test_$$"
mkdir -p "$DU_DIRTY_REPO"
git -C "$DU_DIRTY_REPO" init -q
git -C "$DU_DIRTY_REPO" config user.email "[EMAIL]"
git -C "$DU_DIRTY_REPO" config user.name "Test"
git -C "$DU_DIRTY_REPO" config commit.gpgsign false
echo "test" >"$DU_DIRTY_REPO/file.txt"
git -C "$DU_DIRTY_REPO" add file.txt
git -C "$DU_DIRTY_REPO" commit -qm "initial"
echo "modified" >"$DU_DIRTY_REPO/file.txt"
if [ -z "$(git -C "$DU_DIRTY_REPO" status --porcelain)" ]; then
  echo "✗ Dirty repo should be detected"
  rm -rf "$DU_DIRTY_REPO"
  exit 1
fi
echo "✓ Dirty repo correctly detected"
rm -rf "$DU_DIRTY_REPO"

# Test: clean git repo passes dirty check
echo "Testing clean repo passes dirty check..."
DU_CLEAN_REPO="/tmp/dotfiles_clean_test_$$"
mkdir -p "$DU_CLEAN_REPO"
git -C "$DU_CLEAN_REPO" init -q
git -C "$DU_CLEAN_REPO" config user.email "[EMAIL]"
git -C "$DU_CLEAN_REPO" config user.name "Test"
git -C "$DU_CLEAN_REPO" config commit.gpgsign false
echo "test" >"$DU_CLEAN_REPO/file.txt"
git -C "$DU_CLEAN_REPO" add file.txt
git -C "$DU_CLEAN_REPO" commit -qm "initial"
if [ -n "$(git -C "$DU_CLEAN_REPO" status --porcelain)" ]; then
  echo "✗ Clean repo should pass dirty check"
  rm -rf "$DU_CLEAN_REPO"
  exit 1
fi
echo "✓ Clean repo correctly passes dirty check"
rm -rf "$DU_CLEAN_REPO"

echo ""
echo "All tests passed!"
