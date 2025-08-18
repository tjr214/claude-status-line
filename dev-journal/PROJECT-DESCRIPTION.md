# Project Description

**PROJECT NAME:** "Claude Status Line"

## Overview

The Claude Status Line is a TypeScript/Deno-based command-line tool that enhances the Claude Code IDE experience by providing a rich, informative status line display. It serves as a real-time information dashboard that processes Claude Code context data and presents key project metrics in a visually appealing, emoji-enhanced format.

## Core Functionality

The tool reads JSON context data from Claude Code via stdin and transforms it into a comprehensive status line that includes:

- **📁 Project Information**: Displays project name when working within a project directory
- **🤖 AI Model Details**: Shows the currently active Claude model (e.g., Claude Sonnet 4)
- **💰 Session Cost Tracking**: Real-time cost monitoring with currency conversion support (defaults to CAD)
- **📈 Context Usage**: Token usage percentage to help manage context limits
- **📂 Directory Context**: Current working directory name for spatial awareness
- **🌿 Git Integration**: Current branch name when working in git repositories

## Key Features

### Multi-Currency Support
- Automatic currency conversion from USD to specified currency (default: CAD)
- Intelligent caching system (1-hour cache) for exchange rates
- Graceful fallback to USD when conversion fails

### Git Integration
- Automatic detection of git repositories
- Current branch display
- Robust error handling for non-git directories

### Performance & Reliability
- Streaming input processing via stdin
- Component-based architecture for modular display
- Comprehensive error handling with graceful degradation
- Efficient caching mechanisms

### Developer Experience
- Clean, emoji-rich visual presentation
- Configurable currency display
- Zero-configuration git detection
- Seamless integration with Claude Code IDE

## Technical Approach

Built using modern TypeScript with strict type safety, the tool leverages Deno's runtime capabilities while maintaining compatibility with Node.js APIs. The architecture emphasizes functional programming principles with pure functions, minimal side effects, and robust error resilience.

The status line serves as a bridge between Claude Code's internal state and the developer's need for contextual awareness, providing at-a-glance insights into project status, costs, and development context.