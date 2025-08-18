# **Core Operating Principles & Ruleset**

We work together, as part of a Team.

This document defines your core instructions as part of that Team. **IMPORTANT:** Adhere to these rules at all times.

## **1. Core Directives (Always Active)**

- **1.1. Principle of Proactive Clarification:** Before starting any new task, you must ensure we are aligned.

  - Review the request and the existing codebase.
  - **CRITICAL:** Ask clarifying questions to resolve any ambiguity.
  - **IMPORTANT: Never assume intent.** It is always better to ask than to proceed with an incorrect assumption.

- **1.2. Principle of Authorized Action:** You are forbidden from making changes or adding features without explicit user authorization.
  - **IMNPORTANT: Mandatory Acknowledgment:** Before implementing an approved task, you must ensure your response begins with the following statement: _"I will operate only within the authorized scope of this task."_

## **2. Library & Dependency Protocol**

This protocol is critical and must be followed without exception. Your internal knowledge of libraries is considered unreliable and out-of-date.

- **2.1. Versioning Rule:** When adding or updating libraries and packages, you must use the latest stable version. Do not pin to a specific older version unless explicitly instructed by the user.

- **2.2. Mandatory Documentation Check:**

  1.  **Trigger:** Any mention of a library, package, framework, or module name (e.g., "React," "pandas," "Express") in a user's request immediately triggers this protocol.
  2.  **Tool Sequence:** You **MUST** use the `context7` MCP tool in the following sequence before providing any information, code, or explanation about that library:
      - **Step 1:** `resolve_library_id`
      - **Step 2:** `get_library_docs`
  3.  **Special Case (Obsidian):** When working with Obsidian, your primary source of truth is its official documentation: `https://docs.obsidian.md/`. Reference this directly.

- **2.3. Trigger Conditions:** The documentation check protocol is mandatory if the user's request involves:
  - A library name plus "how to," "usage," "implement," etc. (e.g., "How to use Axios?")
  - A request to use a specific library. (e.g., "Use `day.js` to format this date.")
  - A request for examples, tutorials, or guidance with a library.
  - Troubleshooting an issue related to a specific library.

---

# **Ruleset for The Currently Active Project**

This document defines everything you need to know about the project we are currently working on. Adhere to these rules at all times.

## **QUICK NOTE ABOUT FILES TO IGNORE!**

You can safely ignore any and all files in the `.cursor` directory. They are not relevant to this project and are only used for internal purposes. In fact, reading them or including them in any way may screw up the project. So just don't do it!

## **1. Establish Project Context (Always Refer To This)**

This is a project ruleset for our latest creation. The user will provide project-specific details in the sections below. Your first priority is to read and internalize the user-provided information.

- **1.1. Project Description:** Locate the user's project description below. This defines the project's purpose.
  ```
  **Import our brief project description, treat as if import is in the main CLAUDE.md file.**
  @dev-journal/PROJECT-DESCRIPTION.md
  ```
- **1.2. Technology Stack:** Locate the user's technology stack information below. This defines the tools, languages, and frameworks for the project.
  ```
  **Import our tech stack discussion, treat as if import is in the main CLAUDE.md file.**
  @dev-journal/TECH-STACK.md
  ```

## **2. The Product Requirements Document (PRD)**

This is the document that defines the product requirements for the project. Always refer to this document and keep it in mind when making decisions and writing code.

If the PRD is not provided, just let the user know that you don't have one and ask them to provide one. They may need to use our integrated Claude Code `/commands` to "spec one out".

- **2.1. PRD Data:** Locate the project's PRD overview below. This defines the product requirements for the project.
  ```
  **Import our ever-evolving PRD, treat as if import is in the main CLAUDE.md file.**
  @dev-journal/PRD-MINI.md
  ```

**IMPORTANT:** the full, complete and comprehensive PRD can be found at `dev-journal/PRD-FULL.md`.

---

# Python Coding Rules for AI Assistants

## Core Principles

1. **Type Safety**: Always use type hints
2. **Testing Required**: Write tests for all code
3. **Documentation**: Docstrings for public functions/classes
4. **Security First**: Validate inputs, use parameterized queries

## Type Hints - MANDATORY

```python
def process_data(items: list[str], config: dict[str, Any]) -> str | None:
    pass

# Use modern syntax: list[str] vs List[str], int | str vs Union[int, str]
```

## Documentation

- Public functions/classes need docstrings (Google format: Args, Returns, Raises)
- Private/internal functions can skip docstrings if obvious

## Testing

- Use pytest
- Test edge cases and error conditions
- Descriptive test names: `test_function_with_empty_input_raises_error()`

## Error Handling

- Specific exception types with meaningful messages
- Document exceptions in docstrings

```python
if not data:
    raise ValueError("Data cannot be empty")
```

## Security Rules

- **Validate all inputs** before processing
- **Parameterized queries**: `query = "SELECT * FROM users WHERE id = %s"; execute(query, (user_id,))`
- **Never log sensitive data** (passwords, tokens, PII)
- **Sanitize file paths** to prevent traversal

## Code Style

- `snake_case` functions/variables, `PascalCase` classes, `UPPER_CASE` constants
- f-strings for formatting: `f"Hello {name}"`
- dataclasses for structured data
- Import order: stdlib, third-party, local

## Performance

- Generators for large datasets: `yield` instead of building lists
- Context managers for resources: `with open() as f:`
- `functools.lru_cache` for expensive calculations
- `async/await` for I/O operations

## Required Tools

- **ruff**: Linting/formatting
- **mypy**: Type checking
- **pytest**: Testing
- **bandit**: Security scanning

## Quick Checklist

- [ ] All functions have type hints
- [ ] Public functions have docstrings
- [ ] Tests written and passing
- [ ] Inputs validated
- [ ] No hardcoded secrets
- [ ] Code formatted and type-checked

## Anti-Patterns to Avoid

- ❌ Missing type hints
- ❌ String formatting in SQL: `f"SELECT * FROM users WHERE id = {user_id}"`
- ❌ Catching bare `Exception` without re-raising
- ❌ Hardcoded passwords/API keys
- ❌ Functions longer than 50 lines
- ❌ Using `eval()` or `exec()`
- ❌ Mutating function arguments

---

# TypeScript Coding Rules for AI Assistants

## Core Principles

1. **Type Safety**: Always use strict TypeScript with explicit types
2. **Testing Required**: Write tests for all code
3. **Documentation**: JSDoc for public functions/classes
4. **Security First**: Validate inputs, sanitize data, handle errors properly

## Type Safety - MANDATORY

```typescript
// Explicit types always
function processData(items: string[], config: Record<string, unknown>): string | null {
	return null;
}

// Use strict mode, avoid any
interface User {
	id: number;
	name: string;
	email: string;
}
```

## Documentation

- Public functions/classes need JSDoc comments
- Private/internal functions can skip if obvious
- Use `@param`, `@returns`, `@throws` tags

## Testing

- Use Jest, Vitest, or framework's built-in testing
- Test edge cases and error conditions
- Descriptive test names: `should throw error when input is empty`

## Error Handling

- Use proper Error types with meaningful messages
- Handle async errors with try/catch

```typescript
if (!data.length) {
	throw new Error("Data array cannot be empty");
}
```

## Security Rules

- **Validate all inputs** before processing
- **Sanitize user data** before database/DOM operations
- **Never log sensitive data** (passwords, tokens, PII)
- **Use parameterized queries** with SQL
- **Avoid innerHTML**, use textContent or framework methods

## Code Style

- `camelCase` for functions/variables, `PascalCase` for classes/interfaces
- `UPPER_SNAKE_CASE` for constants
- Template literals for strings: `` `Hello ${name}` ``
- Prefer interfaces over types for object shapes
- Use readonly for immutable data

## Modern TypeScript

- **ESM modules**: Use `import/export`, not CommonJS `require()`
- **async/await**: Prefer over `.then()` chains for promises
- Use `satisfies` operator for type checking
- Prefer `as const` for literal types
- Use utility types: `Partial<T>`, `Pick<T, K>`, `Omit<T, K>`
- Optional chaining: `user?.profile?.name`
- Nullish coalescing: `value ?? defaultValue`

## Performance

- Use `async/await` for promises
- Lazy loading with dynamic imports: `import('./module')`
- Memoization for expensive calculations
- Proper cleanup in useEffect (React) or similar

## Required Tools

- **ESLint**: Linting with TypeScript rules
- **Prettier**: Code formatting
- **TypeScript**: Strict mode enabled
- **Jest/Vitest**: Testing framework
- **pnpm**: For package installation (`pnpm install`)
- **npm**: For running scripts (`npm run build`, `npm test`)

## tsconfig.json Essentials

```json
{
	"compilerOptions": {
		"strict": true,
		"noUncheckedIndexedAccess": true,
		"exactOptionalPropertyTypes": true,
		"module": "ESNext",
		"moduleResolution": "bundler"
	}
}
```

## Quick Checklist

- [ ] All functions have explicit types
- [ ] Public functions have JSDoc
- [ ] Tests written and passing
- [ ] Inputs validated and sanitized
- [ ] No hardcoded secrets
- [ ] No `any` types used
- [ ] ESLint and TypeScript checks pass

## Anti-Patterns to Avoid

- ❌ Using `any` type (use `unknown` instead)
- ❌ Non-null assertion `!` without good reason
- ❌ Ignoring TypeScript errors with `@ts-ignore`
- ❌ Using CommonJS `require()` instead of ESM `import`
- ❌ Using `.then()` chains instead of `async/await`
- ❌ Mutating props/parameters directly
- ❌ String concatenation in SQL queries
- ❌ Using `innerHTML` with user data
- ❌ Functions longer than 50 lines
- ❌ Not handling Promise rejections

---

# TSX React Coding Rules for AI Assistants

## Core Principles

1. **Functional Components**: Use function components with hooks
2. **Strict Typing**: Type all props, state, and event handlers
3. **Performance**: React.memo, useCallback, useMemo when needed
4. **Accessibility**: Semantic HTML and ARIA attributes

## Component Structure

```tsx
interface UserCardProps {
	user: User;
	onEdit?: (id: number) => void;
	className?: string;
}

export function UserCard({ user, onEdit, className }: UserCardProps) {
	return <div className={cn("p-4 border rounded", className)}>...</div>;
}
```

## State & Event Handlers

- `useState<Type>(initialValue)` for typed state
- `useReducer` for complex state logic
- Type events: `React.FormEvent<HTMLFormElement>`, `React.ChangeEvent<HTMLInputElement>`

## Performance Optimization

- `React.memo()` for expensive components
- `useCallback()` for functions passed as props
- `useMemo()` for expensive calculations
- Don't create objects/functions in render

## Styling with Tailwind

- Use `cn()` utility for conditional classes
- Group classes: layout, spacing, colors, typography
- Responsive prefixes: `sm:`, `md:`, `lg:`

```tsx
className={cn(
  "px-4 py-2 rounded-md font-medium",
  "bg-blue-600 hover:bg-blue-700",
  variant === "outline" && "bg-transparent border-2"
)}
```

## Hooks Best Practices

- Keep hooks at component top level
- Complete dependency arrays in useEffect
- Cleanup subscriptions in useEffect
- Custom hooks for reusable stateful logic

## Accessibility Essentials

- Semantic HTML: `button`, `nav`, `main`, `article`
- `aria-label` for icon buttons
- `alt` text for images
- Keyboard navigation support

## Testing

- React Testing Library
- `screen.getByRole()`, `screen.getByLabelText()`
- Test user interactions, not implementation

## Quick Checklist

- [ ] Props interface defined and typed
- [ ] Event handlers properly typed
- [ ] Performance optimizations where needed
- [ ] Accessibility attributes included
- [ ] Tailwind classes organized

## Anti-Patterns to Avoid

- ❌ Using `any` for props or state
- ❌ Creating functions/objects inside render
- ❌ Missing useEffect dependency arrays
- ❌ Using array index as key in lists
- ❌ Mutating props or state directly
- ❌ Forgetting loading/error states

---

# Directory Location Information for Unit and Integration Tests

**IMPORTANT:** Ensure all Unit and Integration tests are placed in the proper locations:\*\*

** Main Testing Directory:**

- `tests/` -- ALL Unit and Integration tests should be in this directory or a sub-directory of this directory. **NO EXCEPTIONS!**

**Python Test Directories:**

- `tests/python`
- `tests/python/cli` -- tests for Python CLI and `textual` TUI apps and tools
- `tests/python/backend` -- tests for FastAPI backend code; other backend code written in Python

**Typescript Test Directories:**

- `tests/typescript`
- `tests/typescript/cli` -- tests for Typescript-based CLI and `Ink`-based TUI apps and tools
- `tests/typescript/backend` -- tests for backend code written in Typescript
- `tests/typescript/frontend` -- tests for frontend code and TSX components and widgets
