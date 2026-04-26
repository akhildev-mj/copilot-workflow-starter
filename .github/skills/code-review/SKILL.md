---
name: code-review
description: "Use when reviewing code, pull requests, diffs, or recently changed files. Performs systematic review covering correctness, readability, security, performance, tests, and adherence to project standards. Trigger phrases: review this, code review, PR review, check my code, look over."
argument-hint: "Provide the file path, diff, or PR description to review"
disable-model-invocation: false
user-invocable: true
compatibility: All
license: MIT
metadata:
  - type: code-review
---

# Code Review

## When to Invoke

Load this skill when the user asks to:

- Review a file, diff, branch, or pull request
- "Look over", "check", "audit", or "sanity-check" recently written code
- Validate code before commit, merge, or deployment
- Get feedback on a proposed implementation

Do NOT load for: pure refactoring requests (use the `refactor` skill), test generation (use the `testing` skill), or general questions.

## Workflow

1. **Scope the review** — Identify exactly what to review (file paths, commit range, or PR). If unclear, ask.
   - Checkpoint: You can list every file you will inspect.
2. **Gather context** — Read the changed files plus their direct callers/callees. Read related tests.
   - Checkpoint: You understand the change's intent before judging it.
3. **Run the review checklist** (in order; stop only when each pass is complete):
   1. **Project standards** — the loaded `copilot-instructions.md` and any matching `*.instructions.md` rules. Treat each violation as a finding; do not re-derive the rules here.
   2. **Correctness** — does it do what it claims? Off-by-one, null handling, race conditions.
   3. **Edge cases** — empty, null, boundary, concurrent, oversized inputs.
   4. **Error handling** — failures surfaced, resources released, no silent catches.
   5. **Security** — anything in OWASP Top 10 that the instruction files don't already cover (authn/authz logic flaws, business-logic bypass, unsafe deserialization).
   6. **Tests** — new branches covered? assertions meaningful? no flaky timing?
   7. **Performance** — N+1 queries, unnecessary re-renders, large allocations in hot paths.
   8. **Diff impact** — callers/callees still correct? public API surface intact?
4. **Classify each finding** as `blocker`, `major`, `minor`, or `nit`.
   - Checkpoint: Every finding has a severity and a concrete suggested fix.
5. **Emit the report** using the Output Format below.

## Examples

### Good — actionable finding

**major — `src/auth/login.ts:42`** Password compared with `==` allowing type coercion. Use `bcrypt.compare(plain, hash)` to avoid timing attacks and coercion bugs.

```ts
// before
if (user.password == input) { ... }
// after
if (await bcrypt.compare(input, user.passwordHash)) { ... }
```

### Bad — vague, useless finding

> "This code could be better." — no location, no severity, no fix.

## Common Pitfalls

- **Reviewing style only.** Don't stop at formatting — the linter handles that. Focus on correctness, security, and design.
- **Praising without verifying.** Never say "looks good" without actually reading the file.
- **Missing the diff context.** A change can be locally correct but break callers — always check usages.
- **Bikeshedding.** Mark subjective preferences as `nit` and keep them out of `blocker`/`major`.
- **Ignoring tests.** Untested new logic is itself a finding.

## Output Format

```markdown
# Code Review: <scope>

**Verdict:** approve | approve-with-comments | request-changes

## Summary

<1–3 sentences on what changed and overall quality.>

## Findings

### Blockers

- **[file:line]** <issue> — <suggested fix>

### Major

- **[file:line]** <issue> — <suggested fix>

### Minor / Nits

- **[file:line]** <issue>

## Suggested Improvements

- <optional follow-ups outside this change's scope>
```

If there are no findings in a section, omit the section.
