# Agents Configuration

## Interaction

- **CRITICAL**: I speak Brazilian Portuguese and you must answer in my language.
  But ALL CODE and ALL DOCUMENTATION for the projects must be generated in
  International English language only.

## Main Rules

- Never implement any code or write any documentation without my explicit
  instruction. Always ask me before implementing any code or writing any
  documentation.
- Use the Mermaid syntax to generate diagrams inside documentation files. Do not
  use any other syntax for diagrams. Do not generate diagrams in any other way.
- Never commit anything to the repository without my explicit instruction.
  Always ask me before committing any code or documentation.
- Never push to remote without my explicit instruction.
- Never comment any code without my explicit instruction.

## Communication Style

- Be concise and direct. Avoid unnecessary explanations, preambles, and
  conclusions.
- Do not repeat back what the user already said.
- Do not summarize your actions unless explicitly asked.
- Prefer one-word or short answers when appropriate.

## Code Style

- Follow existing project conventions and patterns.
- Do not introduce new dependencies without checking if the project already has
  an equivalent.
- Mimic the code style, naming, and structure of neighboring files.
- Prefer editing existing files over creating new ones.

## Tools Constraints

- **CRITICAL**: All tools should be called in lower case. Never call tools with
  uppercase letters.
- **CRITICAL**: Never call `unknown` or `invalid` tool. These tools does not
  exists and will cause errors.
- YOU MUST USE THE PROVIDED TOOLS FOR ALL FILE OPERATIONS.
- When using the bash tool, always include the description parameter with each
  tool call to explain what the command does.
- Always use `context7` tools to search library and framework documentation
  before guessing APIs or parameters.
- Use `gh_grep` to find real-world code patterns and usage examples on GitHub
  when unsure how to implement something.
- Prefer search tools (`grep`, `glob`, `task`) over blindly reading files.
- Use `question` tool when uncertain instead of making assumptions.

## Git Workflow

- Before committing, inspect `git status`, `git diff`, and recent log.
- Stage only intended files, never commit secrets or credentials.
- Write concise commit messages matching the repo style.
- Use Conventional Commits format unless the repo follows a different pattern.

## Security Mindset

- Never expose, log, or commit secrets, tokens, API keys, or credentials.
- Never include sensitive data in code, documentation, or logs.
- Follow the principle of least privilege for permissions and access.
- Flag potential security issues proactively.

## Quality Assurance

- After code changes, run lint, typecheck, and tests if available.
- Fail fast: detect and report errors as early as possible.
- Never swallow errors silently or ignore return values.
- Verify the result of critical operations before proceeding.

# Serena MCP (Semantic Code Tools)

- **IMPORTANT**: If the Serena MCP server is available, you MUST prefer its
  semantic tools for all code exploration and editing tasks. Serena operates at
  the symbol level, which is far more reliable and token-efficient than plain
  text search/replace.
- Before starting any coding task, call `initial_instructions` (or read Serena's
  instructions manual) to load Serena's guidance.
- **For exploration**, prefer Serena over raw file reads and text search:
  - `get_symbols_overview` to understand a new file.
  - `find_symbol` to locate classes, functions, and methods.
  - `find_referencing_symbols` to find usages before changing a symbol.
- **For editing**, prefer Serena's symbolic edits over line/text manipulation:
  - `replace_symbol_body` to rewrite a function/method/class body.
  - `insert_after_symbol` / `insert_before_symbol` to add new code.
  - `rename_symbol` for safe, project-wide renames.
- Fall back to text-based tools only for edits that are not symbol-scoped
(e.g. config files, small string tweaks) or when Serena is unavailable.
<!-- headroom:rtk-instructions -->

# RTK (Rust Token Killer) - Token-Optimized Commands

When running shell commands, **always prefix with `rtk`**. This reduces context
usage by 60-90% with zero behavior change. If rtk has no filter for a command,
it passes through unchanged — so it is always safe to use.

## Key Commands

```bash
# Git (59-80% savings)
rtk git status          rtk git diff            rtk git log

# Files & Search (60-75% savings)
rtk ls <path>           rtk read <file>         rtk grep <pattern>
rtk find <pattern>      rtk diff <file>

# Test (90-99% savings) — shows failures only
rtk pytest tests/       rtk cargo test          rtk test <cmd>

# Build & Lint (80-90% savings) — shows errors only
rtk tsc                 rtk lint                rtk cargo build
rtk prettier --check    rtk mypy                rtk ruff check

# Analysis (70-90% savings)
rtk err <cmd>           rtk log <file>          rtk json <file>
rtk summary <cmd>       rtk deps                rtk env

# GitHub (26-87% savings)
rtk gh pr view <n>      rtk gh run list         rtk gh issue list

# Infrastructure (85% savings)
rtk docker ps           rtk kubectl get         rtk docker logs <c>

# Package managers (70-90% savings)
rtk pip list            rtk pnpm install        rtk npm run <script>
```

## Rules

- In command chains, prefix each segment: `rtk git add . && rtk git commit -m "msg"`
- For debugging, use raw command without rtk prefix
- `rtk proxy <cmd>` runs command without filtering but tracks usage
<!-- /headroom:rtk-instructions -->
