---
name: testing
description: "Reference workflow for writing high-quality automated tests (unit, integration, e2e). Loaded automatically whenever the agent writes or modifies tests — from the /generate-tests prompt, from the implement-from-ticket agent, or ad-hoc. Defines case enumeration, mocking strategy, mutation check, and report format."
argument-hint: "Provide the function, component, or feature to test"
disable-model-invocation: false
user-invocable: false
compatibility: All
license: MIT
metadata:
  - type: testing
---

# Testing

## When to Invoke

Load this skill when the user asks to:

- Write tests for a function, component, module, or feature
- Increase coverage on existing code
- Convert manual checks into automated tests
- Review or fix flaky / poor-quality tests

Do NOT load for: running a test suite (just run it), or debugging non-test code.

## Workflow

1. **Identify the unit under test (UUT)** and its public contract — inputs, outputs, side effects.
   - Checkpoint: You can describe the contract in one sentence.
2. **Detect the test framework** in use (Jest, Vitest, Mocha, Playwright). Match its conventions.
   - Exit condition: no framework configured → ask the user before adding one.
3. **Enumerate test cases** before writing code:
   - Happy path
   - Each branch / discriminant
   - Boundary values (0, 1, max, empty, null/undefined)
   - Error paths (rejected promises, thrown errors)
   - Async race conditions and cancellation, where applicable
4. **Write tests** following Arrange-Act-Assert. One behavior per test.
5. **Mock at boundaries only** — network, filesystem, time. Do NOT mock the UUT itself.
6. **Run the suite** and confirm all new tests pass.
   - Checkpoint: all green; coverage on changed lines reported if available.
7. **Mutation-check the assertions**: temporarily break the UUT — every test must catch a meaningful mutation. Revert.

## Examples

### Good — behavior-focused, one assertion concern

```ts
describe("parseDuration", () => {
  it('parses "1h30m" as 90 minutes', () => {
    expect(parseDuration("1h30m")).toBe(90);
  });

  it("throws on negative durations", () => {
    expect(() => parseDuration("-5m")).toThrow(RangeError);
  });
});
```

### Bad — tests implementation, not behavior

```ts
it("calls _normalizeInput then _toMinutes", () => {
  const spy1 = jest.spyOn(parser, "_normalizeInput");
  const spy2 = jest.spyOn(parser, "_toMinutes");
  parseDuration("1h");
  expect(spy1).toHaveBeenCalled(); // brittle — refactor breaks the test
  expect(spy2).toHaveBeenCalled();
});
```

### Bad — assertion that always passes

```ts
it("returns a value", () => {
  expect(parseDuration("1h")).toBeDefined(); // useless
});
```

## Common Pitfalls

- **Mocking the UUT** — you end up testing the mock, not the code.
- **Snapshot-only tests** for logic — they document output but don't enforce intent.
- **Sleeping for time** — use fake timers (`jest.useFakeTimers()`) or injected clocks.
- **One giant test** with many `expect`s — failure messages become useless.
- **No negative cases** — coverage of failure modes is where bugs hide.
- **Test order coupling** — each test must run independently. Reset state in `afterEach`.

## Output Format

```markdown
# Tests for <UUT>

## Cases Covered

- [x] <case 1>
- [x] <case 2>
- [ ] <case skipped — reason>

## Files

- `<path/to/file.test.ts>` — <n> tests

## Run

`<command>` → <pass>/<total> passing

## Notes

- Mocked: <list of boundaries>
- Coverage delta on changed lines: <if available>
```
