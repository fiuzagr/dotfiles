#!/usr/bin/env sh

DOTFILES_PATH="$(cd -P -- "$(dirname -- "${0}")" && printf '%s\n' "$(pwd -P)")"
export DOTFILES_PATH

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

echo ""
echo "All tests passed!"
