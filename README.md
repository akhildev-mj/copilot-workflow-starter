# 🚀 Copilot Workflow Starter

A **production-ready GitHub Copilot setup** designed to enable **ticket-driven, end-to-end AI-assisted development workflows**.

This repository provides a structured system using:

- **Instructions** → project rules & standards
- **Prompts** → reusable task templates
- **Skills** → intelligent capabilities (review, refactor, testing, git)
- **Agents** → full workflow automation

---

## 🧠 Why This Exists

Modern Copilot usage goes beyond autocomplete.

This setup turns Copilot into a:

- 👨‍💻 Developer
- 🧪 Tester
- 🔍 Reviewer
- 🔧 Refactorer
- 🧾 Git assistant

All driven by a **single command + ticket input**.

---

## 📁 Project Structure

```
.github/
  copilot-instructions.md

  instructions/
    react.instructions.md
    typescript.instructions.md

  prompts/
    implement-feature.prompt.md
    generate-tests.prompt.md

  skills/
    code-review/
    refactor/
    git/
    testing/

  agents/
    implement-from-ticket.agent.md
```

---

## 🔷 Core Concepts

### 1. Instructions (Global + Tech Rules)

- `.github/copilot-instructions.md`
- `.github/instructions/*.instructions.md`

Define:

- Project architecture
- Coding standards
- Tech-specific best practices

👉 Always applied automatically

---

### 2. Prompts (Reusable Tasks)

- `.github/prompts/*.prompt.md`

Examples:

- Feature implementation
- Test generation

👉 Triggered manually in Copilot Chat

---

### 3. Skills (Capabilities)

- `.github/skills/*/SKILL.md`

Examples:

- Code review
- Refactoring
- Testing
- Git commits

👉 Automatically used when relevant

---

### 4. Agents (Automation)

- `.github/agents/*.agent.md`

Example:

- `implement-from-ticket.agent.md`

👉 Executes full development lifecycle:

- Plan → Code → Refactor → Test → Review → Commit

---

## ⚡ Workflow Example

```bash
/implement-from-ticket PROD-123
```

### What happens internally:

1. Load instructions (project + tech rules)
2. Parse ticket (via MCP or manual input)
3. Generate feature using prompts
4. Apply skills:
   - Refactor
   - Testing
   - Code review
   - Git

5. Agent orchestrates entire process

---
