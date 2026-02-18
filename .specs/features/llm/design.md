# LLM Command Generator Design

**Spec**: `.specs/features/llm/spec.md`
**Status**: Approved

---

## Architecture Overview

Single-file POSIX shell script that orchestrates: input capture, API call, response parsing, user interaction, and optional execution/copy. No external dependencies beyond curl and standard Unix tools.

```mermaid
flowchart TD
    subgraph Input
        A[User runs: llm "description"]
        B[Validate OPENROUTER_API_KEY]
    end
    
    subgraph API Layer
        C[Build JSON payload]
        D[Call OpenRouter API via curl]
        E[Parse JSON response]
    end
    
    subgraph Processing
        F[Clean LLM output]
        G[Validate command exists]
    end
    
    subgraph Interaction
        H[Display command with colors]
        I{User choice}
        J[Execute via eval]
        K[Copy to clipboard]
        L[Cancel]
    end
    
    subgraph Persistence
        M[Log to history file]
    end
    
    A --> B
    B -->|Missing key| N[Error & Exit]
    B -->|OK| C
    C --> D
    D -->|Failure| O[Error message]
    D -->|Success| E
    E --> F
    F --> G
    G -->|Empty| P[Error: no command]
    G -->|Valid| H
    H --> I
    I -->|y/Enter| J --> M
    I -->|c| K --> M
    I -->|n/q| L --> M
```

---

## Code Reuse Analysis

### Existing Components to Leverage

| Component | Location | How to Use |
|-----------|----------|------------|
| `copy_to_clipboard()` | `helpers.sh` | Import/use for clipboard functionality |
| `is_macos()` | `helpers.sh` | Detect platform for conditional logic |
| POSIX patterns | Existing `local/bin/*` scripts | Follow same shebang, error handling, structure |
| shml colors | `shml/` submodule | Use for colored output (fgc, hr, etc.) |

### Integration Points

| System | Integration Method |
|--------|-------------------|
| OpenRouter API | HTTP POST via curl, OpenAI-compatible format |
| System clipboard | pbcopy (macOS) or xclip (Linux) via `copy_to_clipboard()` |
| History storage | Append-only log file at `~/.local/share/llm/history.log` |

---

## Components

### Main Script: `local/bin/llm`

- **Purpose**: Single entry point that handles full workflow from input to execution
- **Location**: `local/bin/llm`
- **Interfaces**:
  - Command line: `llm "natural language description"`
  - Environment: `OPENROUTER_API_KEY`, `OPENROUTER_MODEL`
- **Dependencies**: `curl`, POSIX shell, optional: `xclip` (Linux)
- **Reuses**: `helpers.sh` functions (if sourced), existing script patterns

### Internal Functions

#### `call_openrouter()`
- **Purpose**: Make HTTP request to OpenRouter API
- **Input**: User prompt string
- **Output**: Raw JSON response
- **Method**: curl POST with Authorization header

#### `extract_command()`
- **Purpose**: Parse JSON and extract command text
- **Input**: Raw JSON response
- **Output**: Clean command string
- **Method**: grep/sed parsing (no jq dependency)

#### `clean_command()`
- **Purpose**: Remove markdown formatting, whitespace
- **Input**: Raw LLM output
- **Output**: Clean executable command
- **Method**: sed replacements for code blocks, leading/trailing whitespace

#### `log_history()`
- **Purpose**: Append entry to history file
- **Input**: timestamp, request, command, action
- **Output**: None (writes to file)

---

## Data Models

### History Log Entry

```
# Format: ISO8601|request|command|action
2025-01-28T10:30:00|find files modified 24h|find . -mtime -1 -type f|executed
2025-01-28T10:35:00|list processes by memory|ps aux --sort=-%mem \| head -10|copied
```

### API Request Payload

```json
{
  "model": "anthropic/claude-3.5-sonnet",
  "messages": [
    {
      "role": "system",
      "content": "You are a POSIX shell command generator..."
    },
    {
      "role": "user", 
      "content": "<user input>"
    }
  ]
}
```

### API Response Structure

```json
{
  "choices": [
    {
      "message": {
        "content": "find . -mtime -1 -type f"
      }
    }
  ]
}
```

---

## Error Handling Strategy

| Error Scenario | Handling | User Impact |
|----------------|----------|-------------|
| `OPENROUTER_API_KEY` not set | Exit with setup instructions | Clear guidance on how to fix |
| curl fails (network) | Exit with error message | Know it's a connectivity issue |
| API returns 401 | Exit with auth error | Check API key validity |
| API returns 429 | Exit with rate limit message | Wait and retry |
| Empty response from LLM | Exit with "no command generated" | Retry with different wording |
| Clipboard copy fails | Print command to stdout as fallback | Still get the command |
| History write fails | Silently continue | Non-critical, don't block user |

---

## Tech Decisions

| Decision | Choice | Rationale |
|----------|--------|-----------|
| No `jq` dependency | Use grep/sed for JSON parsing | Maximize portability, jq not always installed |
| Single file script | All logic in `local/bin/llm` | Simpler deployment, follows project patterns |
| Default model: claude-3.5-sonnet | Best balance of speed/quality for commands | Good at understanding intent, fast response |
| Always confirm | No auto-execute flag | Safety first, user can always press Enter |
| `eval` for execution | Required for pipes/redirections to work | Shell built-in, handles all command types |

---

## System Prompt

```
You are a POSIX shell command generator. Convert the user's natural language request into a single, executable shell command.

Rules:
- Output ONLY the command, no explanations or markdown
- Use POSIX-compliant syntax (works in sh, bash, zsh)
- Prefer standard Unix tools (find, grep, sed, awk)
- For macOS, use BSD-compatible syntax
- If multiple commands needed, use && or ; to chain
- Quote variables and paths with spaces
- Be safe: avoid destructive operations without clear intent

Examples:
Request: "find large files over 100MB"
Output: find . -type f -size +100M -exec ls -lh {} \;

Request: "kill process on port 3000"
Output: lsof -ti:3000 | xargs kill -9

Request: "count lines in all python files"
Output: find . -name "*.py" -exec wc -l {} + | awk '{sum+=$1} END {print sum}'
```

---

## File Locations

| File | Purpose |
|------|---------|
| `local/bin/llm` | Main executable script |
| `~/.local/share/llm/history.log` | Command history (created on first run) |
| `llm/setup.sh` | Optional module setup (for env export) |
| `llm/env` | Optional: `export OPENROUTER_API_KEY=...` |