---
name: implement-feature

description: "Plan and implement a single feature or change. Lighter-weight alternative to the implement-from-ticket agent — use when there's no formal ticket."
argument-hint: "A short description of the change you want, e.g. 'Add a dark mode toggle to the settings page.'"
agent: agent
model: Auto (copilot)
tools: [execute, read, edit, search, web, agent, todo]
---

# Implement Feature

Feature request: **${input:request:short description of the change you want}**

> For end-to-end ticket delivery (parse → plan → implement → test → review → commit), use the **Implement From Ticket** agent instead. This prompt is for smaller, scoped changes.

## Procedure

1. **Restate the change** in one sentence and list the acceptance criteria you inferred. If anything is ambiguous, stop and ask.
2. **Locate the touch points** — list the files you will read, modify, or create, with a one-line reason each.
3. **Plan** the change as 3–7 numbered steps. Call out edge cases, error paths, and any new types/contracts.
4. **Implement** the plan one step at a time, matching existing patterns. Honor the loaded `*.instructions.md` rules.
5. **Add or update tests** for every behavior change (delegate to the `testing` skill).
6. **Verify**: typecheck, lint, and tests pass. Report any commands run and their results.

## Stop Conditions

- Halt and ask if acceptance criteria conflict, the target file is unclear, or the change requires destructive operations (schema changes, deletions, secret rotation).
- Do **not** commit or push — leave that for the user (or invoke the `git` skill on request).
- Do **not** add features, refactors, or "improvements" outside the stated request.

## Output

Return a short report:

```markdown
## Summary

<1–2 sentences>

## Files changed

- `<path>` — <one-line reason>

## Verification

- <command> → <result>

## Follow-ups (optional)

- <anything intentionally deferred>
```
