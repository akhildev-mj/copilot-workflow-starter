# [Project Name]

[One sentence describing what this project does.]

## Tech Stack

| Layer     | Technology        | Version    |
| --------- | ----------------- | ---------- |
| Language  | [e.g. TypeScript] | [e.g. 5.x] |
| Framework | [e.g. React]      | [e.g. 19+] |
| Runtime   | [e.g. Node.js]    | [e.g. LTS] |

## Copilot Setup

All Copilot customizations live under `.github/`:

```text
.github/
├── copilot-instructions.md             # Always-on project rules
├── instructions/*.instructions.md      # Rules per file type
├── prompts/*.prompt.md                 # One-shot tasks via /name
├── skills/<name>/SKILL.md              # Reusable workflows
├── agents/*.agent.md                   # End-to-end task agents
└── hooks/*.json + scripts/             # Shell commands at lifecycle events
```

## Project Setup

```text
src/
├── index.ts
└── utils.ts
```

## Build and Test

```bash
[install]   # e.g. npm install
[build]     # e.g. npm run build
[test]      # e.g. npm test
[lint]      # e.g. npm run lint
```

## Guardrails

- Do not commit secrets or credentials.
- Do not run destructive commands unless explicitly requested.
- Ask when acceptance criteria or target files are unclear.
- Keep every change inside the requested scope.
