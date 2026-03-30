# LLM Command Generator Tasks

**Design**: `.specs/features/llm/design.md`
**Status**: Done

---

## Execution Plan

### Phase 1: Foundation (Sequential)

Core script structure and API integration.

```
T1 → T2 → T3
```

### Phase 2: Interaction Features (Parallel OK)

After core works, add user interaction features.

```
     ┌→ T4 ─┐
T3 ──┤      ├──→ T6
     └→ T5 ─┘
```

### Phase 3: Polish (Sequential)

Documentation and optional module setup.

```
T6 → T7 → T8
```

---

## Task Breakdown

### T1: Create Script Skeleton with Argument Parsing

**What**: Create `local/bin/llm` with shebang, error handling setup, and argument validation.

**Where**: `local/bin/llm`

**Depends on**: None

**Reuses**: Patterns from `local/bin/gh-pr` (shebang, set -e, main function pattern)

**Tools**:
- MCP: `filesystem`
- Skill: NONE

**Done when**:
- [ ] File exists with `#!/usr/bin/env sh` shebang
- [ ] `set -e` for error handling
- [ ] Validates that at least one argument is provided
- [ ] Shows usage message when no arguments
- [ ] Follows POSIX conventions from CONVENTIONS.md

**Verify**:
```bash
chmod +x local/bin/llm
./local/bin/llm
# Should show usage message and exit 1
./local/bin/llm "test input"
# Should show error about missing OPENROUTER_API_KEY (T2)
```

---

### T2: Implement API Key Validation

**What**: Add function to check for `OPENROUTER_API_KEY` environment variable and exit with helpful message if missing.

**Where**: `local/bin/llm`

**Depends on**: T1

**Reuses**: Error message patterns from `helpers.sh` (stderr redirection)

**Tools**:
- MCP: `filesystem`
- Skill: NONE

**Done when**:
- [ ] Function `check_api_key()` exists
- [ ] Exits with code 1 if `OPENROUTER_API_KEY` is empty
- [ ] Error message to stderr includes setup instructions
- [ ] Shows current model being used (from `OPENROUTER_MODEL` or default)

**Verify**:
```bash
unset OPENROUTER_API_KEY
./local/bin/llm "test"
# Should print error about missing API key with instructions
export OPENROUTER_API_KEY="test-key"
./local/bin/llm "test"
# Should proceed (may fail at API call, that's T3)
```

---

### T3: Implement OpenRouter API Call

**What**: Add function to call OpenRouter API with system prompt and user input, extract command from response.

**Where**: `local/bin/llm`

**Depends on**: T2

**Reuses**: None (new implementation based on design.md API format)

**Tools**:
- MCP: `filesystem`
- Skill: NONE

**Done when**:
- [ ] Function `call_openrouter()` makes POST to `https://openrouter.ai/api/v1/chat/completions`
- [ ] Correct headers: `Authorization: Bearer $OPENROUTER_API_KEY`, `Content-Type: application/json`
- [ ] Payload includes system prompt (from design.md) and user message
- [ ] Function `extract_command()` parses JSON response using grep/sed (no jq)
- [ ] Handles API errors (non-200 responses) with clear messages
- [ ] Handles network failures gracefully

**Verify**:
```bash
export OPENROUTER_API_KEY="your-real-key"
./local/bin/llm "list current directory"
# Should print generated command (may have formatting issues, T4 fixes)
```

---

### T4: Implement Command Cleaning [P]

**What**: Add function to clean LLM output - remove markdown code blocks, trim whitespace, extract first line.

**Where**: `local/bin/llm`

**Depends on**: T3

**Reuses**: sed patterns from reference `llm-exec.sh`

**Tools**:
- MCP: `filesystem`
- Skill: NONE

**Done when**:
- [ ] Function `clean_command()` removes ```bash and ``` markers
- [ ] Removes leading/trailing whitespace
- [ ] Extracts first non-empty line only
- [ ] Handles unicode escapes if present
- [ ] Returns empty string if no valid command found

**Verify**:
```bash
./local/bin/llm "find large files"
# Should show clean command without any markdown or extra text
```

---

### T5: Implement Confirmation Prompt [P]

**What**: Add interactive confirmation with three options: execute (y/Enter), copy (c), cancel (n/q).

**Where**: `local/bin/llm`

**Depends on**: T3

**Reuses**: None (new implementation)

**Tools**:
- MCP: `filesystem`
- Skill: NONE

**Done when**:
- [ ] Displays command with visual highlighting (colors if terminal supports)
- [ ] Prompts: "Execute this command? (y/c/n)"
- [ ] `y` or `Enter` executes via `eval`
- [ ] `c` copies to clipboard (T6 will implement copy)
- [ ] `n` or `q` cancels with message
- [ ] Shows exit code after execution

**Verify**:
```bash
./local/bin/llm "echo hello"
# Press 'y' -> should execute and show "hello"
# Press 'n' -> should show "cancelled" message
```

---

### T6: Implement Clipboard and History Features

**What**: Add clipboard copy functionality and command history logging.

**Where**: `local/bin/llm`

**Depends on**: T4, T5

**Reuses**: `copy_to_clipboard()` from `helpers.sh` (or inline equivalent for standalone)

**Tools**:
- MCP: `filesystem`
- Skill: NONE

**Done when**:
- [ ] `c` option copies command to clipboard
- [ ] Fallback to stdout if clipboard fails
- [ ] Creates `~/.local/share/llm/` directory if needed
- [ ] Appends to `~/.local/share/llm/history.log` with format: `timestamp|request|command|action`
- [ ] Action is one of: `executed`, `copied`, `cancelled`

**Verify**:
```bash
./local/bin/llm "pwd"
# Press 'c' -> command in clipboard, verify with paste
cat ~/.local/share/llm/history.log
# Should show entry with timestamp and action
```

---

### T7: Add Tests to test.sh

**What**: Add test cases for the llm script to the project's test suite.

**Where**: `test.sh`

**Depends on**: T6

**Reuses**: Existing test patterns from `test.sh`

**Tools**:
- MCP: `filesystem`
- Skill: NONE

**Done when**:
- [ ] Test for missing API key error handling
- [ ] Test for argument validation
- [ ] Test for command extraction (mocked response)
- [ ] Test for command cleaning (various LLM output formats)
- [ ] All tests pass: `sh test.sh`

**Verify**:
```bash
sh test.sh
# All llm-related tests pass
```

---

### T8: Create Optional Module Setup

**What**: Create optional `llm/` module for users who want to manage via dotfiles setup system.

**Where**: `llm/setup.sh`, `llm/env`

**Depends on**: T7

**Reuses**: Module patterns from other modules (e.g., `git/setup.sh`)

**Tools**:
- MCP: `filesystem`
- Skill: NONE

**Done when**:
- [ ] `llm/setup.sh` creates history directory
- [ ] `llm/env` contains template for `OPENROUTER_API_KEY` export (commented out)
- [ ] Module can be run via `sh setup.sh llm`
- [ ] Updates STRUCTURE.md with new module

**Verify**:
```bash
sh setup.sh llm
# Should complete without errors
ls ~/.local/share/llm/
# Directory should exist
```

---

## Parallel Execution Map

```
Phase 1 (Sequential):
  T1 ──→ T2 ──→ T3

Phase 2 (Parallel):
  T3 complete, then:
    ├── T4 [P]  (cleaning)
    └── T5 [P]  (confirmation)
    
  T4, T5 complete:
    T6 (clipboard + history)

Phase 3 (Sequential):
  T6 ──→ T7 ──→ T8
```

---

## Task Granularity Check

| Task | Scope | Status |
|------|-------|--------|
| T1: Script skeleton | 1 file, basic structure | ✅ Granular |
| T2: API key validation | 1 function | ✅ Granular |
| T3: API call | 2 functions (call + extract) | ✅ Granular |
| T4: Command cleaning | 1 function | ✅ Granular |
| T5: Confirmation prompt | 1 interaction flow | ✅ Granular |
| T6: Clipboard + History | 2 related features, same file | ✅ Acceptable |
| T7: Tests | Multiple test functions, same file | ✅ Acceptable |
| T8: Module setup | 2 small files | ✅ Granular |