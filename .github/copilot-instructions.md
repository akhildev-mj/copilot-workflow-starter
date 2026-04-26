# Project Overview

This project uses an AI-assisted development workflow powered by GitHub Copilot. These instructions apply to every interaction in the workspace.

## Stack

- TypeScript (5.x, ES2022 target)
- React 19+ with functional components and hooks
- Node.js LTS
- Modular feature-oriented folder layout

## Rules

These are cross-cutting rules. Language- and framework-specific guidance lives in `.github/instructions/*.instructions.md` and loads automatically for matching files.

- Never commit secrets, lockfile-less installs, or generated build output.
- If acceptance criteria, file paths, or the target of a change are unclear, stop and ask before editing.
- Hooks live in `.github/hooks/*.json`; hook scripts live in `.github/hooks/scripts/`.
- Prefer deterministic hooks for enforceable policy and automation (`PreToolUse`, `PostToolUse`) instead of relying only on natural-language instructions.
- Keep hook commands safe and auditable: avoid hardcoded credentials, set explicit timeouts, and validate tool input in scripts.

## Workflow

Features are implemented via:
**Ticket → Plan → Code → Test → Refactor → Review → Commit**

The end-to-end runbook lives in [agents/implement-from-ticket.agent.md](agents/implement-from-ticket.agent.md).
