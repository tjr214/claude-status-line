---
description: "Make a Plan to implement a new feature, fix a bug, update documentation, etc."
argument-hint: "[What is it we need to do, boss?]"
thinking: true
---

@.claude/alignment-header.md

## **WORK SESSION BOOTUP: PHASE 1**

If you see something like the following in your system message then say "Planning Mode Active: CONFIRMED!":

```
<system-reminder>
Plan mode is active. ...
</system-reminder>
```

If you do NOT see something like the above in your system message then say "Planning Mode is not active. Activate it and then re-run this command." and immediately STOP.

## **WORK SESSION BOOTUP: PHASE 2 (PLAN MODE ONLY)**

### **Plan Creation Request**

**CRITICAL:** Use all of the planning tools available to you to create a comprehensive plan. Also, this task will require your thinking mode.

**Think hard: Lets's make a plan. What we need to plan:** $ARGUMENTS

### **Context Gathering**

First, let's gather the essential project context to create an informed plan:

#### **Project Overview**

- Read and understand the project description:

```
@dev-journal/PROJECT-DESCRIPTION.md
```

- Understand our technology stack:

```
@dev-journal/TECH-STACK.md
```

- Review the Product Requirements Document:

```
@dev-journal/PRD-MINI.md
```

#### **Current State Analysis**

- Check if there's an existing plan:

```
@dev-journal/OUR-PLAN.md
```

### **Plan Creation Process**

#### **Step 1: Requirements Analysis**

Analyze the request from multiple perspectives:

- **Functional Requirements:** What exactly needs to be built/fixed/improved?
- **Technical Requirements:** What technologies, patterns, or approaches are needed?
- **Security Considerations:** What security implications should be considered?
- **Performance Considerations:** Any performance impacts or optimizations needed?
- **Testing Requirements:** What testing strategies are appropriate?
- **Documentation Needs:** What documentation should be created or updated?

#### **Step 2: Task Decomposition**

Break down the work into logical, manageable tasks:

- Identify major phases or milestones
- Break each phase into specific, actionable tasks
- Consider dependencies between tasks
- Estimate complexity and effort for each task

#### **Step 3: Dependency & Risk Analysis**

- Map dependencies between tasks
- Identify potential blockers or risks
- Plan mitigation strategies
- Determine critical path

#### **Step 4: Plan Structure Creation**

Create a comprehensive plan with:

- Clear objectives and success criteria
- Prioritized task list with dependencies
- Implementation details and pseudocode where helpful
- Security and performance considerations
- Testing strategy
- Documentation requirements

#### **Step 5: Plan Validation**

- Review the plan for completeness
- Ensure all requirements are addressed
- Verify task dependencies make sense
- Check for any missing considerations

### **Plan Output Format**

The plan should be structured as follows:

```markdown
# Comprehensive Plan: $PROJECT_NAME

## Objective

[Clear statement of what we're trying to achieve]

## Success Criteria

- [ ] [Specific measurable outcomes]

## Context & Requirements

### Functional Requirements

[What needs to be built/fixed/improved]

### Technical Requirements

[Technologies, patterns, approaches needed]

### Security Considerations

[Security implications and requirements]

### Performance Considerations

[Performance impacts and optimizations]

## Implementation Plan

### Phase 1: [Phase Name]

**Objective:** [What this phase accomplishes]

**Tasks:**

- [ ] [Specific actionable task]
  - **Details:** [Implementation details, files to modify, etc.]
  - **Dependencies:** [Any dependencies]
  - **Notes:** [Additional context or pseudocode]

### Phase 2: [Phase Name]

[Continue pattern...]

## Testing Strategy

- [ ] [Unit tests for...]
- [ ] [Integration tests for...]
- [ ] [Manual testing steps...]

## Documentation Requirements

- [ ] [Update documentation for...]
- [ ] [Create new documentation for...]

## Risk Mitigation

- **Risk:** [Potential issue]
  - **Mitigation:** [How to address it]

## Dependencies & Critical Path

[Dependency analysis and critical path identification]
```

### **Final Steps**

1. **Create the Plan:** Write the comprehensive plan following the structure above
2. **Save the Plan:** Update or create `dev-journal/OUR-PLAN.md` with the new plan
3. **Summary:** Provide a brief summary of the plan and next steps
4. **Exit:** When planning is complete call the `ExitPlanMode` tool to let me know the plan is complete and available for review at `dev-journal/OUR-PLAN.md`. Use the tool to inform me there is nothing left for you to do and that when I am ready to begin the next step, I just need to run the `/plan:expand-our-plan` command. Or, if I am ready to execute now, I just need to run the `/plan:resume-work-from-plan` command.

### **Instructions for Execution**

After creating the plan:

- Present the plan to the user for review and approval
- Ask if any adjustments are needed
- Once approved, exit the planning mode and update the user
- Suggest using `/plan/expand-our-plan` to begin execution (once manual review of the plan is complete) -- OR: suggest using `/plan/resume-work-from-plan` to begin execution immediately (once again, after manual review of the plan is complete)

### **Quality Checklist**

Before finalizing the plan, ensure:

- [ ] All requirements from the request are addressed
- [ ] Tasks are specific and actionable
- [ ] Dependencies are clearly identified
- [ ] Security and performance are considered
- [ ] Testing strategy is included
- [ ] Documentation needs are identified
- [ ] Plan is structured and easy to follow
- [ ] Success criteria are measurable
