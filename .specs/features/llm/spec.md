# LLM Command Generator Specification

## Problem Statement

Developers frequently need to recall complex shell commands but struggle to remember exact syntax, flags, and combinations. Man pages are verbose, web searches interrupt flow, and AI chat interfaces require context switching. A CLI tool that converts natural language to executable shell commands directly in the terminal would eliminate this friction.

## Goals

- [ ] Reduce shell command lookup time from minutes to seconds
- [ ] Enable POSIX-compliant command generation for maximum portability
- [ ] Maintain safety through mandatory confirmation before execution

## Out of Scope

- Auto-execution mode (no `--yes` flag for automatic execution)
- Streaming responses from LLM
- Multi-turn conversations or context retention
- Command explanation/teaching mode
- Integration with local LLMs (Ollama, etc.)

---

## User Stories

### P1: Generate Command from Natural Language ⭐ MVP

**User Story**: As a developer, I want to describe a task in natural language so that I receive an executable shell command.

**Why P1**: This is the core functionality - without it, the tool has no value.

**Acceptance Criteria**:

1. WHEN user runs `llm "find files modified in last 24 hours"` THEN system SHALL call OpenRouter API and return a valid POSIX shell command
2. WHEN OpenRouter API returns a response THEN system SHALL extract only the command text (no markdown, no explanations)
3. WHEN API call fails (network, auth, rate limit) THEN system SHALL display a clear error message with guidance

**Independent Test**: Run `llm "list current directory"` and verify a valid `ls` variant is returned.

---

### P1: Command Confirmation Flow ⭐ MVP

**User Story**: As a developer, I want to review the generated command before execution so that I can verify it's safe and correct.

**Why P1**: Safety is non-negotiable - users must be able to inspect commands before running them.

**Acceptance Criteria**:

1. WHEN command is generated THEN system SHALL display it with visual highlighting
2. WHEN command is displayed THEN system SHALL prompt for confirmation with options: (y)es, (c)opy, (n)o
3. WHEN user presses `y` or `Enter` THEN system SHALL execute the command in current shell context
4. WHEN user presses `n` or `q` THEN system SHALL exit without executing

**Independent Test**: Generate any command, press `n`, verify no execution occurs.

---

### P2: Copy Command to Clipboard

**User Story**: As a developer, I want to copy the generated command to clipboard so that I can paste it elsewhere or modify it before running.

**Why P2**: Users often want to modify commands or use them in scripts/notes rather than execute immediately.

**Acceptance Criteria**:

1. WHEN user presses `c` at confirmation prompt THEN system SHALL copy command to system clipboard
2. WHEN clipboard copy succeeds THEN system SHALL display confirmation message
3. WHEN clipboard copy fails (no xclip/pbcopy) THEN system SHALL display error with fallback (print to stdout)

**Independent Test**: Generate command, press `c`, paste in another application.

---

### P2: Command History Logging

**User Story**: As a developer, I want my generated commands to be logged so that I can reference them later for learning or reuse.

**Why P2**: History enables learning patterns and recovering previously useful commands.

**Acceptance Criteria**:

1. WHEN command is generated THEN system SHALL append entry to `~/.local/share/llm/history.log`
2. WHEN writing to history THEN system SHALL include: timestamp, request, command, action taken
3. WHEN history directory doesn't exist THEN system SHALL create it automatically

**Independent Test**: Generate and execute a command, verify entry exists in history.log.

---

### P3: Custom Model Selection

**User Story**: As a developer, I want to specify which LLM model to use so that I can optimize for speed, cost, or capability.

**Why P3**: Default model works for most cases, but power users may want different models.

**Acceptance Criteria**:

1. WHEN `OPENROUTER_MODEL` environment variable is set THEN system SHALL use that model instead of default
2. WHEN model is invalid/unavailable THEN system SHALL display API error with available models hint

**Independent Test**: Set `OPENROUTER_MODEL=openai/gpt-4o-mini`, generate command, verify model used in logs.

---

## Edge Cases

- WHEN user input contains special characters (quotes, backticks, $) THEN system SHALL escape them properly in JSON payload
- WHEN LLM returns empty or invalid response THEN system SHALL display "Failed to generate command" error
- WHEN LLM returns multiple commands THEN system SHALL use only the first non-empty line
- WHEN command would be destructive (rm -rf, etc.) THEN system SHALL proceed normally (user can cancel via confirmation)
- WHEN `OPENROUTER_API_KEY` is not set THEN system SHALL display setup instructions and exit

---

## Success Criteria

How we know the feature is successful:

- [ ] User can generate valid POSIX commands from natural language descriptions
- [ ] Command generation completes in under 5 seconds for typical requests
- [ ] Zero accidental command executions (all require explicit confirmation)
- [ ] History log persists across sessions