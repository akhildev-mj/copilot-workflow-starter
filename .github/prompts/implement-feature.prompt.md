---
name: implement-feature
description: "Use when implementing one scoped feature from a short requirement. Trigger phrases: implement feature, add feature, build this."
argument-hint: "Short feature request, for example: Add CSV export to invoices"
agent: agent
tools: [read, edit, search, execute, todo]
---

# Implement Feature

## Input

**${input:request:Short description of the feature}**

## Workflow

1. Restate the requested feature and acceptance criteria.
2. List files to inspect and why.
3. Implement only the requested behavior.
4. Add or update tests for changed behavior.
5. Run typecheck, lint, and tests.

> Halt if: requirements are ambiguous, the target file is unknown, or the work requires destructive operations.

## Output

```markdown
## Summary

[what changed]

## Files

- [path] - [why]

## Verification (if checks were run)

- [command] -> [result]
```
