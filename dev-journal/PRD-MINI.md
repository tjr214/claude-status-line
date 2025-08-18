# Mini-PRD: Claude Status Line

## Product Summary

A TypeScript/Deno command-line tool that enhances Claude Code IDE with a real-time status line displaying project context, AI model info, session costs, token usage, and git status.

## Core Value Proposition

Provides immediate visibility into development context through emoji-enhanced status components, enabling better cost management, resource awareness, and project navigation for Claude Code users.

## Key Features

- **📁 Project & Directory Context**: Shows project name and current directory
- **🤖 AI Model Display**: Current Claude model information
- **💰 Multi-Currency Cost Tracking**: Real-time session costs with currency conversion
- **📈 Context Usage Monitoring**: Token usage percentage to avoid limits
- **🌿 Git Integration**: Current branch display with automatic repository detection

## Technical Approach

- **Input**: JSON context from Claude Code via stdin
- **Processing**: Component-based architecture with async operations
- **Output**: Formatted status line with " | " separators
- **Dependencies**: ccusage (cost tracking), @cliffy/command (CLI), currency API
- **Error Handling**: Graceful degradation with fallback values

## Success Criteria

- All context components display correctly when available
- <500ms response time with 1-hour currency rate caching
- Zero crashes with comprehensive error handling
- Seamless Claude Code integration

## Architecture Principles

- Functional programming with pure functions
- Strict TypeScript configuration
- Modular components for independent failure handling
- External service resilience with graceful fallbacks

**IMPORTANT:** The full, comprehensive PRD is located at `dev-journal/PRD-FULL.md`.
