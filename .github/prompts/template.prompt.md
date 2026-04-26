---
name: prompt-name
description: "Use when <trigger phrase>. Covers <topic>. Trigger phrases: <keyword>, <keyword>."
argument-hint: "Describe the input needed by this prompt"
agent: agent
tools: [read, search] # Use the minimal set the task actually needs.
---

# [Prompt Title]

## Input

**${input:request:Describe the requested task}**

## Workflow

1. Restate the request and inferred acceptance criteria.
2. Identify files to read or modify.
3. Implement the requested change.
4. Validate using the project's checks.

> Halt if: acceptance criteria are missing, the target file is unclear, or a destructive operation is required.

## Output

```markdown
## Summary

[what changed]

## Files

- [path] - [why]

## Verification (if checks were run)

- [command] -> [result]
```
