---
name: code-review
description: "Use when reviewing changed files, diffs, or pull requests. Trigger phrases: review this, code review, PR review, check my code."
argument-hint: "File path, diff range, or PR summary"
---

# Code Review

## When To Use

- Reviewing a file, diff, or pull request before merge
- Validating code quality or security before commit

Do NOT load for: refactoring requests or test generation.

## Workflow

1. Confirm review scope.
2. Read changed files and nearby context.
3. Evaluate correctness, security, tests, and maintainability.
4. Classify findings by severity.
5. Return an actionable report.

> Halt if: scope is unclear or no files or diff were provided.

## Output

```markdown
## Summary

[what changed]

## Files

- [path] - [why]

## Verification (if checks were run)

- [command] -> [result]
```
