# Technology Stack

## Runtime & Platform

- **Deno**: TypeScript/JavaScript runtime with built-in TypeScript support
- **Node.js APIs**: Uses Node.js compatibility layer for file system, process, and buffer operations

## Programming Language

- **TypeScript**: Strict TypeScript configuration with advanced type safety features
  - `exactOptionalPropertyTypes: true`
  - Comprehensive strict mode settings

## Core Dependencies

- **ccusage** (npm:ccusage@^15.9.5): Claude session usage tracking and cost calculation
- **@cliffy/command** (jsr:@cliffy/command@^1.0.0-rc.7): Command-line argument parsing and CLI framework

## Built-in APIs Used

- **Node.js child_process**: For executing git commands
- **Node.js fs/promises**: For file system operations (caching)
- **Node.js path**: For directory and file path manipulation
- **Node.js os**: For temporary directory access
- **Fetch API**: For currency conversion API calls

## Development Tools

- **Deno native tooling**:
  - `deno check`: Type checking
  - `deno fmt`: Code formatting (2-space indentation, semicolons, double quotes)
  - `deno lint`: Linting with recommended rules
  - `deno publish`: Package publishing
- **Git hooks**: Pre-commit and pre-push automation

## External Services

- **Currency API**: `cdn.jsdelivr.net/@fawazahmed0/currency-api` for real-time currency conversion
- **Git**: Version control integration for branch information

## Architecture Pattern

- **Functional Programming**: Pure functions with minimal side effects
- **Streaming Input**: JSON context processing via stdin
- **Component-based Output**: Modular status line components with emoji icons
- **Error Resilience**: Graceful fallbacks for all external dependencies

## Code Quality Standards

- Strict TypeScript configuration
- 80-character line width
- Comprehensive error handling with try-catch blocks
- No implicit any types
- Exact optional property types
