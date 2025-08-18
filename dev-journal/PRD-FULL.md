# Product Requirements Document (PRD)
## Claude Status Line v0.1.0

### Executive Summary

The Claude Status Line is a command-line utility that enhances the Claude Code IDE experience by providing real-time contextual information in a visually appealing status bar format. It bridges the gap between Claude Code's internal state and developer awareness, presenting critical project metrics, cost tracking, and contextual information at a glance.

---

## 1. Product Vision & Goals

### 1.1 Vision Statement
Create an indispensable status line tool that provides Claude Code developers with immediate visibility into their development context, session costs, and project status through an elegant, emoji-enhanced interface.

### 1.2 Primary Goals
- **Contextual Awareness**: Provide instant visibility into current project, directory, and git status
- **Cost Transparency**: Enable real-time session cost monitoring with multi-currency support
- **Resource Management**: Display context token usage to help manage Claude's limitations
- **Seamless Integration**: Work transparently with Claude Code's existing workflow
- **Developer Productivity**: Reduce cognitive overhead through clear visual indicators

---

## 2. Target Users & Use Cases

### 2.1 Primary Users
- **Active Claude Code Developers**: Developers using Claude Code for daily coding tasks
- **Project Managers**: Those monitoring Claude usage costs across projects
- **Multi-Project Developers**: Developers working across multiple repositories and contexts

### 2.2 Core Use Cases

#### UC1: Real-time Cost Monitoring
- **Actor**: Cost-conscious developer
- **Goal**: Monitor Claude session costs in real-time
- **Flow**: Developer sees live cost updates in preferred currency while working
- **Value**: Prevents unexpected billing, enables budget management

#### UC2: Project Context Awareness  
- **Actor**: Multi-project developer
- **Goal**: Quickly identify current project and git branch context
- **Flow**: Status line displays project name, directory, and git branch
- **Value**: Reduces context switching confusion, prevents accidental commits

#### UC3: Resource Usage Monitoring
- **Actor**: Long-session developer
- **Goal**: Track context token usage to avoid hitting limits
- **Flow**: Status line shows percentage of context tokens used
- **Value**: Prevents session interruptions, optimizes conversation management

---

## 3. Functional Requirements

### 3.1 Core Display Components

#### 3.1.1 Project Information Display
- **FR1.1**: Display project name with 📁 icon when current directory differs from project directory
- **FR1.2**: Show current directory basename with 📂 icon
- **FR1.3**: Hide project name when project directory matches current directory

#### 3.1.2 AI Model Information
- **FR2.1**: Display current Claude model name with 🤖 icon
- **FR2.2**: Show model display name exactly as provided by Claude Code context

#### 3.1.3 Cost Tracking
- **FR3.1**: Display session cost in real-time with 💰 icon
- **FR3.2**: Support configurable currency conversion (default: CAD)
- **FR3.3**: Cache exchange rates for 1 hour to minimize API calls
- **FR3.4**: Gracefully fallback to USD when conversion fails
- **FR3.5**: Integrate with ccusage library for cost calculation

#### 3.1.4 Context Usage Display  
- **FR4.1**: Show context token usage percentage with 📈 icon
- **FR4.2**: Calculate percentage from transcript path analysis
- **FR4.3**: Display "0%" when context calculation fails

#### 3.1.5 Git Integration
- **FR5.1**: Display current git branch with 🌿 icon when in git repository
- **FR5.2**: Automatically detect git repository status
- **FR5.3**: Hide git information when not in a git repository
- **FR5.4**: Handle git command failures gracefully

### 3.2 Input/Output Requirements

#### 3.2.1 Input Processing
- **FR6.1**: Read JSON context from stdin
- **FR6.2**: Parse ClaudeContext interface with session_id, transcript_path, model, and workspace
- **FR6.3**: Handle malformed JSON gracefully

#### 3.2.2 Output Format
- **FR7.1**: Join all components with " | " separator
- **FR7.2**: Output single line to stdout
- **FR7.3**: Use consistent emoji icons for visual identification

### 3.3 Command Line Interface
- **FR8.1**: Accept `-c, --currency` flag for currency selection
- **FR8.2**: Default to CAD currency when no flag provided
- **FR8.3**: Display version with `--version` flag
- **FR8.4**: Show help text with standard CLI patterns

---

## 4. Non-Functional Requirements

### 4.1 Performance
- **NFR1.1**: Process stdin and generate output in <500ms under normal conditions
- **NFR1.2**: Cache currency rates to avoid repeated API calls
- **NFR1.3**: Minimize memory footprint for long-running sessions

### 4.2 Reliability
- **NFR2.1**: Gracefully handle all external service failures
- **NFR2.2**: Never crash due to missing git repository or network issues
- **NFR2.3**: Provide fallback values for all optional components

### 4.3 Usability
- **NFR3.1**: Require zero configuration for basic functionality
- **NFR3.2**: Present information in scannable, visual format
- **NFR3.3**: Maintain consistent visual language across sessions

### 4.4 Maintainability
- **NFR4.1**: Follow strict TypeScript configuration
- **NFR4.2**: Maintain >90% code coverage through functional tests
- **NFR4.3**: Use modular architecture for easy component updates

### 4.5 Security
- **NFR5.1**: Never log or expose sensitive session data
- **NFR5.2**: Validate all external inputs before processing
- **NFR5.3**: Use secure HTTPS endpoints for currency data

---

## 5. Technical Architecture

### 5.1 System Architecture
- **Component-Based Design**: Modular status components for independent failure handling
- **Functional Programming**: Pure functions with explicit side effect management
- **Streaming Processing**: Efficient stdin handling for real-time data processing

### 5.2 Data Flow
1. **Input**: JSON context received via stdin
2. **Processing**: Parallel component generation with async operations
3. **Assembly**: Components joined with consistent formatting
4. **Output**: Single status line sent to stdout

### 5.3 Error Handling Strategy
- **Graceful Degradation**: Missing components don't break entire status line
- **Fallback Values**: Default values provided for all optional information
- **Silent Failures**: External service failures don't interrupt core functionality

---

## 6. Dependencies & External Services

### 6.1 Runtime Dependencies
- **ccusage**: Session cost calculation and usage tracking
- **@cliffy/command**: CLI argument parsing and help generation
- **Deno Runtime**: TypeScript execution environment

### 6.2 External Services  
- **Currency API**: `cdn.jsdelivr.net/@fawazahmed0/currency-api` for exchange rates
- **Git**: Local git commands for repository information

---

## 7. Testing Strategy

### 7.1 Unit Testing
- Test each component function in isolation
- Mock external dependencies (git, currency API)
- Verify graceful error handling paths

### 7.2 Integration Testing
- Test complete stdin-to-stdout flow
- Verify component interaction and formatting
- Test with various Claude context scenarios

### 7.3 Error Scenario Testing
- Network failures during currency conversion
- Malformed JSON input handling
- Missing git repositories
- Invalid currency codes

---

## 8. Success Metrics

### 8.1 Functional Success
- **Accuracy**: 100% of supported context information displayed correctly
- **Reliability**: <0.1% failure rate under normal operating conditions
- **Performance**: <500ms response time for 95% of requests

### 8.2 User Experience Success
- **Adoption**: Integration into standard Claude Code workflow
- **Usability**: Zero support requests for basic functionality
- **Value**: Positive feedback on development context awareness

---

## 9. Future Roadmap (Out of Scope for v0.1.0)

### 9.1 Enhanced Metrics
- Code complexity indicators
- Test coverage status  
- Build/deployment status integration

### 9.2 Customization Features
- User-configurable component selection
- Custom emoji preferences
- Color coding for different statuses

### 9.3 Advanced Integration
- IDE plugin development
- Real-time collaborative session indicators
- Advanced git status information (ahead/behind, uncommitted changes)

---

## 10. Acceptance Criteria

### 10.1 Core Functionality
- [ ] Status line displays all available components correctly
- [ ] Currency conversion works with 1-hour caching
- [ ] Git integration detects repositories and shows current branch
- [ ] Context token percentage calculation functions properly
- [ ] All external failures handled gracefully

### 10.2 Quality Standards
- [ ] TypeScript strict mode compliance
- [ ] Comprehensive error handling coverage
- [ ] Performance requirements met (<500ms)
- [ ] Zero crashes under normal operating conditions

### 10.3 Integration Requirements
- [ ] Seamless integration with Claude Code context system
- [ ] Compatible with standard Unix pipe operations
- [ ] No interference with existing Claude Code workflows