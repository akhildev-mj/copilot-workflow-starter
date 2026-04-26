---
name: generate-tests

description: "Generate or extend automated tests for a target file, function, or feature. Covers happy path, branches, boundaries, and error paths."
argument-hint: "Provide a file path, function name, or feature description to generate tests for."
agent: agent
model: Auto (copilot)
tools: [execute, read, edit, search, web, agent, todo]
---

# Generate Tests

> **Entry point** for writing tests. The detailed workflow lives in the [`testing` skill](../skills/testing/SKILL.md), which is loaded automatically — you don't invoke it separately.

Target: **${input:target:file path, function name, or feature description}**

## Procedure

Run the workflow defined in the [`testing` skill](../skills/testing/SKILL.md) against the target above. The skill owns the test design, mocking, and quality rules — do not restate them.

Additional constraints specific to this prompt:

- If no convention exists for test file location, place the test next to the source as `<name>.test.<ext>`.
- If a new test fails, the assumption in the test is wrong — refine the test. Only modify the UUT if you have concrete evidence of a real bug, and **stop to surface it to the user before changing production code**.
- Avoid snapshot tests for logic; use them only for stable, intentional UI fragments.

## Stop Conditions

- Halt if the UUT has no clear contract or its dependencies cannot be mocked at a boundary.
- Halt if no test framework is configured — ask before adding one.
- Do **not** weaken assertions to make a failing test pass.
- Do **not** rewrite production code beyond what's needed to make it testable (and flag any such change in the report).

## Output

```markdown
## Tests for <UUT>

### Cases covered

- [x] <case>
- [ ] <case skipped — reason>

### Files

- `<path>.test.<ext>` — <n> tests

### Run

`<command>` → <pass>/<total> passing

### Mutation check

- <assertion> ↔ <line broken> → caught ✅ / not caught ❌

### Notes

- Mocked: <list of boundaries>
- Production code touched for testability: <list, or "none">
- Coverage delta on changed lines: <if available>
```
