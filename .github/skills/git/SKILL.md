---
name: git
description: "Use when staging, committing, or writing commit messages. Produces Conventional Commits, splits unrelated changes, and prepares clean history before push or PR. Trigger phrases: commit, commit message, stage, write commit, conventional commit, prepare PR."
argument-hint: "Optional: scope or summary hint for the commit"
disable-model-invocation: false
user-invocable: true
compatibility: All
license: MIT
metadata:
  - type: git
---

# Git

## When to Invoke

Load this skill when the user wants to:

- Generate a commit message for staged or unstaged changes
- Split a large working set into focused commits
- Prepare history for review (squash, reorder, reword)
- Validate that a message follows Conventional Commits

Do NOT load for: pushing, force-pushing, branch deletion, or rewriting published history without explicit user approval.

## Workflow

1. **Inspect the working tree** — `git status` and `git diff --staged` (and unstaged if relevant).
   - Checkpoint: You can list every changed file and its purpose.
2. **Group changes by intent.** If the diff mixes unrelated concerns (e.g. a bug fix + a refactor), propose splitting into multiple commits.
   - Exit condition: user declines split → proceed with one commit but flag it in the body.
3. **Pick the type** from the table below using the dominant change.
4. **Pick the scope** — a short, lowercase noun for the affected area (`auth`, `api`, `ui`). Omit if truly cross-cutting.
5. **Write the subject line** in imperative mood, ≤ 72 chars, no trailing period.
6. **Add a body** when the change isn't self-evident: what changed, _why_, and any caller impact.
7. **Add footers** for breaking changes (`BREAKING CHANGE: …`) and issue refs (`Refs: #123`, `Closes: #456`).
8. **Stop before pushing.** Only commit; never push, force-push, or rewrite remote history without explicit confirmation.

### Conventional Commit Types

| Type       | Use for                                                                |
| ---------- | ---------------------------------------------------------------------- |
| `feat`     | New user-facing capability                                             |
| `fix`      | Bug fix                                                                |
| `refactor` | Restructure without behavior change                                    |
| `perf`     | Performance improvement                                                |
| `test`     | Add/adjust tests only                                                  |
| `docs`     | Documentation only                                                     |
| `build`    | Build system, dependencies                                             |
| `ci`       | CI/CD configuration                                                    |
| `chore`    | Tooling, housekeeping                                                  |
| `style`    | Formatting only (rare — usually handled by formatter pre-commit hooks) |

## Examples

### Good

```
feat(auth): add OAuth2 PKCE flow for SPA login

Replaces the implicit grant with PKCE so the browser client never
handles a refresh token. Existing sessions remain valid; new logins
go through /authorize?response_type=code.

Refs: #482
```

```
fix(api): return 404 instead of 500 when invoice id is unknown
```

```
refactor(checkout): extract price calculation into pricing module
```

### Good — breaking change

```
feat(api)!: drop deprecated /v1/users endpoint

BREAKING CHANGE: clients must migrate to /v2/users. The v1 route
has returned 410 since 2025-09 and is now removed entirely.
```

### Bad

```
update stuff                  ← no type, no scope, no info
Fixed the bug.                ← past tense, period, no detail
feat: did some work on auth and also fixed unrelated css and bumped lodash
                              ← three commits crammed into one
```

## Common Pitfalls

- **Past-tense subjects** ("added", "fixed"). Use imperative: "add", "fix".
- **Mixing concerns** in one commit — reviewers can't bisect or revert cleanly.
- **Missing `!` or `BREAKING CHANGE` footer** on breaking changes — automated changelogs miss them.
- **Committing generated files** (lockfiles aside) or secrets — check `git diff --staged` first.
- **Auto-pushing.** This skill stops at `git commit`. Push is a separate, explicit user action.
- **`--no-verify`** to skip hooks — never bypass without the user's explicit approval.

## Output Format

Produce two parts: a fenced block containing the commit message (ready to paste), then a short rationale below it.

Use `~~~` for the outer fence so the inner ` ``` ` blocks render correctly:

````markdown
## Proposed commit

```
<type>(<scope>): <subject>

<optional body>

<optional footers>
```

**Rationale:** <1–2 sentences on type/scope choice and any splits proposed>
**Command:** `git commit` (open editor for multi-line) or `git commit -m "..." -m "..."`
````
