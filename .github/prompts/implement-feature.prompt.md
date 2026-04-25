---
name: implement-feature
description: "Guidelines for implementing a new feature"
argument-hint: "What is the feature you want to implement?"
agent: agent
model: Auto (copilot)
tools: [execute, read, edit, search, web, agent, todo]
---

## Requirements Analysis

- Read the ticket or feature description thoroughly
- Identify acceptance criteria and edge cases
- Clarify any ambiguous requirements before implementation
- Document non-functional requirements (performance, scalability, etc.)
- List dependencies on other features or systems

## Component & Service Design

- Break feature into small, modular components/services
- Identify responsibilities for each component
- Design clear component interfaces and contracts
- Consider reusability and testability from the start
- Separate concerns: UI, business logic, data access

## Data Flow Design

- Map out how data flows through the feature
- Identify state management needs
- Design data structures and types
- Consider error states and edge cases
- Plan for async operations and side effects

## Implementation Best Practices

- Follow project coding standards and conventions
- Keep components/functions small and focused
- Prefer readability over cleverness
- Handle errors and edge cases explicitly
- Add comments for complex logic
- Use consistent naming conventions
- Implement incrementally with testable units

## TypeScript & React Guidelines

- Use strict TypeScript types (avoid `any`)
- Define interfaces for props and data structures
- Leverage TypeScript for compile-time error checking
- Use React best practices for components
- Implement proper error boundaries where needed
- Consider performance implications (memoization, lazy loading)

## Output

- Implementation files (components, services, utilities)
- Type definitions and interfaces
- Updated tests for new functionality
- Documentation updates if needed
