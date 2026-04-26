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

## 🧩 The Five Layers

| Layer                  | Path                                     | Trigger                                              | Role                                          |
| :--------------------- | :--------------------------------------- | :--------------------------------------------------- | :-------------------------------------------- |
| 📜 **Instructions**    | `.github/instructions/*.instructions.md` | Auto (by file glob or always-on)                     | House rules / style                           |
| 🛠️ **Skills**          | `.github/skills/<name>/SKILL.md`         | Auto-matched on description, or via prompt/agent     | Reusable expertise                            |
| ⚡ **Prompts**         | `.github/prompts/*.prompt.md`            | User types `/command`                                | One-shot tasks                                |
| 🤖 **Agents**          | `.github/agents/*.agent.md`              | Picked from agent menu (`@name`)                     | Multi-step orchestration                      |
| 🪝 **Hooks (Preview)** | `.github/hooks/*.json`                   | Lifecycle events (`PreToolUse`, `PostToolUse`, etc.) | Deterministic automation / policy enforcement |

### How they call each other

| Caller ↓ / Callee → | 🤖 Agent | ⚡ Prompt | 🛠️ Skill | 📜 Instructions |
| :------------------ | :------: | :-------: | :------: | :-------------: |
| 🤖 **Agent**        |    —     |    ✅     |    ✅    | ✅ (via skill)  |
| ⚡ **Prompt**       |    ❌    |     —     |    ✅    | ✅ (via skill)  |
| 🛠️ **Skill**        |    ❌    |    ❌     |    —     |       ✅        |
| 📜 **Instructions** |    ❌    |    ❌     |    ❌    |        —        |

Hooks are event-driven shell commands. They don't participate in the call graph above and execute independently on lifecycle events.

> Dependency flows **top → bottom only**. A skill never calls a prompt; a prompt never calls an agent. Each piece stays replaceable.

---

## 📁 Project Structure

```text
.github/
├── copilot-instructions.md             # Always-on project rules (fill in your stack)
├── hooks/
│   ├── security.json                   # PreToolUse — blocks dangerous commands
│   ├── template.hook.json              # Starter template for new hooks
│   └── scripts/
│       ├── block-dangerous.sh          # Enforces security policy
│       └── template-hook.sh            # Starter template for new hook scripts
├── instructions/
│   ├── typescript.instructions.md      # applyTo: **/*.{ts,tsx}
│   └── template.instructions.md        # Starter template for new instruction files
├── prompts/
│   ├── implement-feature.prompt.md     # /implement-feature
│   └── template.prompt.md              # Starter template for new prompts
├── skills/
│   ├── code-review/SKILL.md            # Auto-matched on review/PR phrases
│   └── template-skill/SKILL.md         # Starter template for new skills
└── agents/
    ├── implement-from-ticket.agent.md  # End-to-end delivery agent
    └── template.agent.md               # Starter template for new agents
```

---

## ⚡ Quick Start

|  #  | Step             | Action                                                                                     |
| :-: | :--------------- | :----------------------------------------------------------------------------------------- |
|  1  | **Copy**         | Drop `.github/` into your repo root                                                        |
|  2  | **Configure**    | Edit `.github/copilot-instructions.md` — fill in your project name, stack, and guardrails  |
|  3  | **Enable hooks** | Make scripts executable: `chmod +x .github/hooks/scripts/*.sh`                             |
|  4  | **Open**         | Launch in VS Code with Copilot Chat installed                                              |
|  5  | **Use**          | Instructions auto-load; skills/agents discoverable in chat; hooks fire on lifecycle events |

---

## 🎯 Invocation Cheat Sheet

| Want to…                    | Use                 | How to trigger                | Example                                                                                            |
| :-------------------------- | :------------------ | :---------------------------- | :------------------------------------------------------------------------------------------------- |
| Implement a scoped feature  | ⚡ **Prompt**       | Type `/` in Copilot Chat      | `/implement-feature Add a CSV export button to the invoices page`                                  |
| Deliver a ticket end-to-end | 🤖 **Agent**        | Pick from agent picker or `@` | `@implement-from-ticket` then paste `PROD-123 — Customers should be able to reset their password…` |
| Review a file or diff       | 🛠️ **Skill** (auto) | Phrase the request            | _"review my changes"_ → `code-review` skill loads itself automatically                             |
| Block dangerous commands    | 🪝 **Hook**         | Automatic on every tool call  | `security.json` denies destructive terminal commands before execution                              |

### Implement From Ticket — the runbook

|      1       |     2      |      3      |        4         |      5      |       6       |       7        |       8       |
| :----------: | :--------: | :---------: | :--------------: | :---------: | :-----------: | :------------: | :-----------: |
| 📥 **parse** | 🗺️ **map** | 🛠️ **plan** | 🔨 **implement** | 🧪 **test** | ✅ **verify** | 📋 **summary** | 🔒 **review** |

```text
parse → map → plan → implement → test → verify → summary → review
```

> [!IMPORTANT]
> The agent stops at `git commit` — it does **not** push.

**💡 Tip:** Skills are matched against their `description` field. You don't have to remember slash commands — just describe the task.

---

## ✅ Requirements

| Requirement                   | Version                                         |
| :---------------------------- | :---------------------------------------------- |
| VS Code                       | `1.95+`                                         |
| GitHub Copilot + Copilot Chat | signed in                                       |
| Workspace root                | must contain `.github/`                         |
| Hook scripts runtime          | `bash` + `jq` (for provided shell hook scripts) |

---

## 👋 About Me

Built and maintained by **Akhildev MJ**

[![Portfolio](https://img.shields.io/badge/Portfolio-akhildev.vercel.app-000?style=for-the-badge&logo=vercel)](https://akhildev.vercel.app)
