---
name: implement-from-ticket
description: "Guidelines for implementing a feature from a ticket"
argument-hint: "What is the ticket or feature description you want to implement?"
agents: [agent]
model: Auto (copilot)
tools: [execute, read, edit, search, web, agent, todo]
disable-model-invocation: false
user-invocable: true
target: vscode
---

# Agent: Implement From Ticket

Goal:
Execute full feature lifecycle from a ticket

Input:

- Ticket (MCP or manual)

Steps:

1. Parse ticket
2. Plan feature
3. Generate code
4. Refactor
5. Test
6. Fix issues
7. Review
8. Improve
9. Generate tests
10. Final verification
11. Commit changes
