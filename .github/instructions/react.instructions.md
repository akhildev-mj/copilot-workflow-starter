---
name: react

description: "Use when writing or modifying React component files (.tsx). Covers React 19+ component patterns, hooks, state, data fetching, performance, accessibility, and component-level testing. Loads on top of the TypeScript instructions."
applyTo: "**/*.tsx"
---

# React (19+) Instructions

> These rules cover **React-specific** concerns only.

## Project Context

- React 19+ with functional components and hooks.
- Vite (or another modern bundler). Do **not** suggest Create React App — it is deprecated.
- Composition over inheritance.

## Component Design

- Components are functions. ❌ `React.FC` (implicit `children`, awkward generics). ✅
  ```tsx
  type Props = { title: string; children?: React.ReactNode };
  export function Card({ title, children }: Props) {
    /* ... */
  }
  ```
- One responsibility per component. Split when a component does rendering AND data fetching AND mutation.
- Use `React.ComponentProps<'button'>` (and friends) when wrapping native elements.
- File names use PascalCase to match the component (`Card.tsx`, `UserMenu.tsx`).

## Hooks & Effects

- Follow the rules of hooks: top-level only, never inside conditionals or loops.
- Every `useEffect` needs a complete dependency array. If you suppress the lint rule, leave a comment explaining why.
- Return a cleanup function from any effect that subscribes, opens a connection, or sets a timer.
- Reach for `useMemo` / `useCallback` only when profiling shows a real cost — they are not free.
- Extract reusable stateful logic into custom hooks named `useXxx`.

## State Management

- Local UI state: `useState`. Multi-field or transition-heavy state: `useReducer`.
- Cross-tree state: `useContext` for low-frequency values; a store (Zustand, Redux Toolkit) for high-frequency or large state.
- Server state: TanStack Query or SWR — do not roll your own cache in `useEffect`.
- Normalize server data; avoid storing derivable values in state.

## Data Fetching

- Always render explicit `loading`, `error`, and `empty` states — never just `data && <X />`.
- Cancel or ignore stale responses (AbortController, query keys).
- Prefer optimistic updates only when rollback is implemented.

## Forms

- Controlled inputs by default.
- Non-trivial forms: **React Hook Form** or **TanStack Form**. Formik is in maintenance — do not introduce it.
- Pair with a schema validator (Zod or Valibot) for shared client/server validation.
- Every input needs a `<label>` (or `aria-label`) and an associated error message.

## Routing

- React Router for client-side routing.
- Lazy-load route components with `React.lazy` + `<Suspense>`.
- Protect routes with a wrapper component, not by checking auth inside each page.

## Performance (React-specific)

- Use `React.memo` for components that re-render often with stable props.
- Code-split at route boundaries with `React.lazy`.
- Virtualize lists over ~100 items (TanStack Virtual, react-window).
- Profile with React DevTools before optimizing — do not guess.

## Accessibility

- Use semantic HTML first; reach for ARIA only when no semantic element fits.
- Every interactive element must be keyboard-reachable and have a visible focus state.
- Images: meaningful `alt`, or `alt=""` for decorative.
- Maintain WCAG AA color contrast (4.5:1 for body text).

## Error Handling

- Wrap route or feature roots in an Error Boundary that renders a fallback UI.
- Effects and event handlers must catch their own async errors — boundaries do not catch them.

## Testing (React-specific)

- React Testing Library, not Enzyme.
- Query by role / label / text — avoid `data-testid` unless nothing else works.
- Use `userEvent` over `fireEvent` for realistic interactions.
- Test behavior the user can observe, not internal hook state.

## Styling

- Use CSS Modules, vanilla-extract, or a CSS-in-JS library that supports zero-runtime extraction.
- Mobile-first responsive design.
- Drive theming through CSS custom properties.
