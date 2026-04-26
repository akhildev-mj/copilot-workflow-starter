# 🚀 Copilot Workflow Starter

**A drop-in `.github/` configuration that turns GitHub Copilot into a structured, ticket-driven dev assistant for TypeScript / React.**

![VS Code](https://img.shields.io/badge/VS%20Code-1.95%2B-007ACC?logo=visualstudiocode&logoColor=white)
![Copilot](https://img.shields.io/badge/GitHub%20Copilot-required-24292e?logo=github)
![TypeScript](https://img.shields.io/badge/TypeScript-5.x-3178C6?logo=typescript&logoColor=white)
![React](https://img.shields.io/badge/React-19%2B-61DAFB?logo=react&logoColor=black)
![Config Only](https://img.shields.io/badge/ships-config%20only-brightgreen)

> [!NOTE]
> This repo ships **only Copilot customization files** — no application source. Drop the `.github/` folder into your project to adopt the workflow.

---

## 🧩 The Four Layers

| Layer | Path | Trigger | Role |
| :--- | :--- | :--- | :--- |
| 📜 **Instructions** | `.github/instructions/*.instructions.md` | Auto (by file glob or always-on) | House rules / style |
| 🛠️ **Skills** | `.github/skills/<name>/SKILL.md` | Auto-matched on description, or via prompt/agent | Reusable expertise |
| ⚡ **Prompts** | `.github/prompts/*.prompt.md` | User types `/command` | One-shot tasks |
| 🤖 **Agents** | `.github/agents/*.agent.md` | Picked from agent menu (`@name`) | Multi-step orchestration |

### How they call each other

| Caller ↓ / Callee → | 🤖 Agent | ⚡ Prompt | 🛠️ Skill | 📜 Instructions |
| :--- | :-: | :-: | :-: | :-: |
| 🤖 **Agent** | — | ✅ | ✅ | ✅ (via skill) |
| ⚡ **Prompt** | ❌ | — | ✅ | ✅ (via skill) |
| 🛠️ **Skill** | ❌ | ❌ | — | ✅ |
| 📜 **Instructions** | ❌ | ❌ | ❌ | — |

> Dependency flows **top → bottom only**. A skill never calls a prompt; a prompt never calls an agent. Each piece stays replaceable.

---

## 📁 Project Structure

```text
.github/
├── copilot-instructions.md             # Always-on project rules
├── instructions/
│   ├── typescript.instructions.md      # applyTo: **/*.ts
│   └── react.instructions.md           # applyTo: **/*.tsx
├── prompts/
│   ├── implement-feature.prompt.md     # /implement-feature
│   └── generate-tests.prompt.md        # /generate-tests
├── skills/
│   ├── code-review/SKILL.md
│   ├── refactor/SKILL.md
│   ├── testing/SKILL.md
│   └── git/SKILL.md
└── agents/
    └── implement-from-ticket.agent.md  # End-to-end delivery agent
```

---

## ⚡ Quick Start

| # | Step | Action |
| :-: | :--- | :--- |
| 1 | **Copy** | Drop `.github/` into your repo root |
| 2 | **Configure** | Edit `.github/copilot-instructions.md` for your stack |
| 3 | **Open** | Launch in VS Code with Copilot Chat installed |
| 4 | **Use** | Instructions auto-load; skills/agents discoverable in chat |

---

## 🎯 Invocation Cheat Sheet

| Want to… | Use | How to trigger | Example |
| :--- | :--- | :--- | :--- |
| Run a one-shot task | ⚡ **Prompt** | Type `/` in Copilot Chat | `/implement-feature Add a CSV export button to the invoices page` |
| Generate tests for a file | ⚡ **Prompt** | Type `/` | `/generate-tests src/utils/parse-duration.ts` |
| Deliver a ticket end-to-end | 🤖 **Agent** | Pick from agent picker or `@` | `@Implement From Ticket` then paste `PROD-123 — Customers should be able to reset their password…` |
| Review / refactor / commit | 🛠️ **Skill** (auto) | Phrase the request | *"review my changes"* → `code-review` loads itself. Or call `/code-review`, `/refactor` directly |

### Implement From Ticket — the runbook

| 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 |
| :-: | :-: | :-: | :-: | :-: | :-: | :-: | :-: |
| 📥 **parse** | 🗺️ **plan** | 🔨 **implement** | 🧪 **test** | ♻️ **refactor** | 🔍 **self-review** | ✅ **verify** | 📝 **commit** |

```text
parse → plan → implement → test → refactor → self-review → verify → commit
```

> [!IMPORTANT]
> The agent stops at `git commit` — it does **not** push.

**💡 Tip:** Skills are matched against their `description` field. You don't have to remember slash commands — just describe the task.

---

## ✅ Requirements

| Requirement | Version |
| :--- | :--- |
| VS Code | `1.95+` |
| GitHub Copilot + Copilot Chat | signed in |
| Workspace root | must contain `.github/` |

---

## 👋 About Me

Built and maintained by **Akhildev MJ**

[![Portfolio](https://img.shields.io/badge/Portfolio-akhildev.vercel.app-000?style=for-the-badge&logo=vercel)](https://akhildev.vercel.app)
