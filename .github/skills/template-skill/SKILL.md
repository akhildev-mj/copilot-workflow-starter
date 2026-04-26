---
name: template-skill # Must match the folder name exactly.
description: "Use when performing <specific repeatable workflow>. Trigger phrases: <keyword>, <keyword>."
argument-hint: "Optional input for this skill"
# user-invocable: false       # Uncomment to hide from slash commands (auto-load only).
# disable-model-invocation: true  # Uncomment to make slash-command-only (no auto-load).
---

# [Skill Title]

## When To Use

- [Specific trigger or task type]
- [Another trigger]

Do NOT load for: [tasks this skill should not handle]

## Workflow

1. Confirm scope.
2. Gather context.
3. Execute the workflow.
4. Validate outcomes.
5. Report results.

> Halt if: scope is ambiguous, required inputs are missing, or the request is destructive.

## Output

```markdown
## Summary

[what changed]

## Files

- [path] - [why]

## Verification (if checks were run)

- [command] -> [result]
```
