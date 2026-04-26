---
name: refactor
description: "Use when restructuring existing code without changing observable behavior. Covers extracting functions, renaming, removing duplication, simplifying conditionals, and untangling modules. Trigger phrases: refactor, clean up, simplify, extract, rename, dedupe, restructure."
argument-hint: "Provide the file or function to refactor and the goal"
disable-model-invocation: false
user-invocable: true
compatibility: All
license: MIT
metadata:
  - type: refactor
---

# Refactor

## When to Invoke

Load this skill when the user wants to **change the shape** of code while keeping behavior identical:

- Extract a function, component, or module
- Rename for clarity
- Remove duplication or dead code
- Replace conditionals with polymorphism / lookup tables
- Split an oversized file or class

Do NOT load for: behavior changes, bug fixes, new features, or performance changes that alter outputs (use `implement-feature` instead).

## Workflow

1. **Confirm tests exist** for the code being refactored.
   - Exit condition: if no tests cover the target, **stop and ask the user** whether to (a) write characterization tests first or (b) abort. Do not silently proceed.
2. **Capture baseline** — run the existing tests and note the result. All must pass before changing anything.
3. **Pick one refactor** from Fowler's catalog (Extract Function, Inline Variable, Replace Conditional with Polymorphism, etc.). One at a time.
4. **Apply the change** in the smallest possible step.
5. **Re-run tests** after every step.
   - Checkpoint: tests still green. If red → revert immediately.
6. **Repeat** steps 3–5 until the goal is reached.
7. **Verify no behavior change**: same public API surface, same outputs for the same inputs, same side effects.
8. **Emit the summary** using the Output Format.

## Examples

### Good — Extract Function

```ts
// before
function renderInvoice(o: Order) {
  const subtotal = o.items.reduce((s, i) => s + i.price * i.qty, 0);
  const tax = subtotal * 0.2;
  return `Total: ${subtotal + tax}`;
}

// after
function calcSubtotal(items: Item[]) {
  return items.reduce((s, i) => s + i.price * i.qty, 0);
}
function renderInvoice(o: Order) {
  const subtotal = calcSubtotal(o.items);
  return `Total: ${subtotal + subtotal * 0.2}`;
}
```

Same output, clearer intent, `calcSubtotal` is now testable in isolation.

### Bad — "refactor" that changes behavior

```ts
// before
if (user.role === 'admin' || user.role === 'owner') { ... }

// after — silently drops 'owner', this is a BUG, not a refactor
if (user.role === 'admin') { ... }
```

## Common Pitfalls

- **No tests, no refactor.** Without a safety net you are rewriting, not refactoring.
- **Mixing refactor with feature work.** Land them as separate commits/PRs.
- **"Optimize performance".** That changes behavior in measurable ways — handle as a separate task with benchmarks.
- **Big-bang rewrites.** Always take small, reversible steps.
- **Renaming public APIs without deprecation.** Coordinate with callers or add aliases.
- **Touching formatting and structure in one diff.** Reviewer can't see the real change.

## Output Format

```markdown
# Refactor: <target>

**Goal:** <one sentence>
**Behavior change:** none (verified by <test command>)

## Steps Applied

1. <Catalog name> — <file:line> — <one-line rationale>
2. ...

## Verification

- Tests run: `<command>` → <pass count>/<total> passing
- Public API surface: unchanged | <list deltas>

## Follow-ups (optional)

- <smells noted but out of scope>
```
