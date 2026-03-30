# Testing Infrastructure

**Analyzed:** 2025-01-28

## Test Frameworks

| Type | Framework | Status | Location |
|------|-----------|--------|----------|
| **Unit/Integration** | None (manual) | Basic | test.sh |
| **E2E** | None | Not implemented | - |
| **Coverage** | None | No coverage tooling | - |
| **Shell Testing** | Custom validation | Planned | - |

## Test Organization

**Location:** `test.sh` in project root

**Naming:** `test.sh` (not individual module tests)

**Structure:** Manual test functions with output validation

## Testing Patterns

### Current Approach: Manual Validation

**Location:** `test.sh` (99 lines)

**Pattern:** Simple shell script with validation checks

**Example:**

```sh
# Test get_os
echo "Testing get_os..."
os=$(get_os)
if [ "$os" = "darwin" ] || [ "$os" = "linux" ]; then
  echo "✓ get_os returned valid OS: $os"
else
  echo "✗ get_os returned invalid OS: $os"
  exit 1
fi
```

**Characteristics:**
- Prints test name
- Executes function
- Validates output with if/then
- Reports pass (✓) or fail (✗)
- Exits on first failure

### Current Test Coverage

**Tested Functions:**

1. `get_os()` - OS detection
2. `is_macos()` - macOS check
3. `is_linux()` - Linux check
4. `get_shell()` - Shell detection
5. `to_zshrc()` - Zsh RC append
6. `to_shell_rc()` - Shell-agnostic RC append

**Not Tested:**

- `create_symlink()` - Symlink creation with backup logic
- `link_tree()` - Tree symlink creation
- `to_file()` - File append with regex
- `to_bashrc()` / `to_dotfilesrc()` - RC file appends
- `copy_to_clipboard()` - Platform-specific clipboard
- `log()` / `log_error()` - Logging functions

## Test Execution

**Running tests:**

```bash
sh test.sh
```

**Output:**

```
Testing get_os...
✓ get_os returned valid OS: darwin
Testing is_macos and is_linux...
✓ is_macos returned success (running on macOS)
✓ is_linux correctly failed on macOS
...
All tests passed!
```

**Exit code:** 0 on success, 1 on failure

**Configuration:** Tests create temporary files in /tmp with PID suffix

```sh
TEST_ZSHRC="/tmp/test_zshrc_$$"
touch "$TEST_ZSHRC"
# ... run test ...
rm -f "$TEST_ZSHRC"
```

## Coverage Targets

**Current Coverage:** ~6/11 core functions (~55%)

**Goals:**

- **Next sprint:** 100% helpers.sh coverage
- **Medium-term:** Module integration tests
- **Long-term:** E2E setup validation tests

**Gaps:**

- `create_symlink()` - Critical for setup, needs comprehensive tests
  - Test idempotence (run twice)
  - Test backup creation
  - Test relative/absolute paths
  - Test parent directory creation

- `link_tree()` - Core helper, needs tests
  - Test directory recursion
  - Test file symlink creation
  - Test permission preservation

- `to_file()` - Generic appender, needs tests
  - Test with regex pattern
  - Test with direct line
  - Test idempotence

## Planned Testing Improvements

### Phase 1: Extend Manual Tests

**Task:** Add tests for:
- `create_symlink()` (including idempotence)
- `link_tree()` (directory recursion)
- `to_file()` (regex matching)
- `log()` and `log_error()` (output capture)

**Effort:** 2-4 hours

**Validation:** Run test.sh and verify all helpers.sh functions pass

### Phase 2: Test Framework Integration

**Consider:** shunit2 or bats (Bash Automated Testing System)

**Reason:** Structured test framework for better maintainability

**Approach:**
1. Research shunit2 vs bats vs custom
2. Create test infrastructure
3. Migrate existing tests
4. Add new test categories

**Effort:** 4-8 hours

### Phase 3: Module Integration Tests

**Test each module:**
- Verify setup.sh runs without error
- Verify tools are installed (command -v check)
- Verify configs are created/symlinked
- Verify env vars are exported

**Example test for node module:**

```sh
# After running node/setup.sh
node --version || exit 1
npm --version || exit 1
command -v nvm >/dev/null || exit 1
```

**Effort:** 4-6 hours for all 20+ modules

### Phase 4: E2E Testing with CI/CD

**Setup:** GitHub Actions workflow

**Tests:**
- Clean VM (macOS) - run full setup.sh
- Clean VM (Ubuntu/Debian) - run full setup.sh
- Verify all tools installed
- Verify configs present

**Effort:** 6-10 hours

## Test Execution (Current)

**Command:**

```bash
sh test.sh
```

**Output:**

```
Testing get_os...
✓ get_os returned valid OS: darwin
Testing is_macos and is_linux...
✓ is_macos returned success (running on macOS)
✓ is_linux correctly failed on macOS
...
All tests passed!
```

**Configuration:** None (tests are hardcoded values and temporary files)

## Coverage Metrics

**Approach:** Manual tracking (no automated coverage)

**Currently tracked:**

- helpers.sh functions: 6/11 tested (55%)
- Test locations: test.sh only
- Module tests: None

## Best Practices to Implement

1. **Idempotence Testing:** Run setup twice, verify no changes
2. **Isolation:** Each test cleans up temp files (already done)
3. **Clear Output:** ✓/✗ markers for quick scanning
4. **Fast Execution:** Tests should complete in <5 seconds
5. **Meaningful Names:** Test names describe what they test
6. **Error Messages:** Show actual vs expected on failure

## Known Testing Gaps

| Gap | Impact | Priority |
|-----|--------|----------|
| No create_symlink() tests | High - core functionality | High |
| No module integration tests | Medium - catches setup issues | Medium |
| No CI/CD pipeline | Medium - prevents regressions | Medium |
| No performance tests | Low - shell scripts are fast | Low |
| No cleanup validation | Low - manual inspection | Low |
