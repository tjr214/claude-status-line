# CHANGELOG

## ENTRY 2: Status Line Gets Smarter - User-Controlled Model Display Revolution

Enhanced the claude-status-line with a game-changing new feature: configurable model display! Users can now choose whether they want to see the AI model name in their status line using the new `--display-model` (or `-m`) command-line flag. This provides much-needed customization control over the displayed information, allowing developers to tailor their status line to their preferences.

### Key Improvements Made:
- **New CLI Option**: Added `--display-model` flag for optional model name display
- **Function Enhancement**: Extended `buildStatusLine` with `displayModel` boolean parameter
- **Conditional Rendering**: Implemented smart logic to show/hide model component based on user preference
- **Python Display Cleanup**: Simplified Python environment display to show only the environment name for cleaner output
- **Code Quality**: Applied consistent formatting throughout with improved indentation and structure

This update transforms the status line from a fixed display into a customizable tool that adapts to individual developer workflows. Whether you're working with multiple models and need that visibility, or prefer a cleaner interface without model information, the choice is now yours.
