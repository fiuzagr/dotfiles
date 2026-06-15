# Agents Configuration

## Interaction

- Load the skill `caveman` to enable caveman mode before interacting with the
  user.
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

- Load the skill `caveman-commit` to enable caveman commit mode before committing
  code.
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
