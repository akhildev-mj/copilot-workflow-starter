---
name: typescript
description: "Use when writing or modifying TypeScript source files (.ts, .tsx). Covers types, async error handling, and test expectations. Trigger phrases: TypeScript, TS file, add type, async function."
applyTo: "**/*.{ts,tsx}"
---

# TypeScript Instructions

## 1: Prefer Explicit Types

- Avoid `any` — implicit or explicit.
- Use `unknown` with a type guard when the shape is truly uncertain.
- Use TypeScript utility types (`Partial`, `Readonly`, `Record`) to express intent.

## 2: Keep Functions Focused

Each function should have one clear concern; extract helpers when logic branches grow.

## 3: Handle Async Errors Explicitly

Wrap `await` in `try/catch` and handle or rethrow — no empty catch blocks.

### Example

```ts
// before — swallows the error
async function load(id: string): Promise<any> {
  try {
    return await fetch(id);
  } catch {}
}

// after — explicit type, explicit error
async function load(id: string): Promise<Response> {
  try {
    return await fetch(id);
  } catch (err) {
    logger.error(err);
    throw err;
  }
}
```

## 4: Test Behavior Changes

Add or update tests whenever observable behavior changes.
