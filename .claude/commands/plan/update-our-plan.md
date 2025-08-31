---
description: "Update Our Plan by creating and integrating new plan elements with enhanced safety and validation."
argument-hint: "[What new features, fixes, or changes do we need to plan for?]"
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

### **Plan Update Request**

**IMPORTANT:** Activate your thinking mode as "thinking hard" will be required for this task.

**Think hard: Let's make a plan. Or, rather, lets update the plan we have. What we need to plan and integrate:** $ARGUMENTS

### **Context Gathering**

First, let's gather the essential project context to create an informed update plan:

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

#### **Current Plan Analysis**

Read and fully analyze the existing Comprehensive Plan to understand what we're building upon:

```
@dev-journal/OUR-PLAN.md
```

### **Plan Update Process**

#### **Step 1: Requirements Analysis for Update**

Analyze the update request from multiple perspectives:

- **Functional Requirements:** What exactly needs to be built/fixed/improved?
- **Technical Requirements:** What technologies, patterns, or approaches are needed?
- **Security Considerations:** What security implications should be considered?
- **Performance Considerations:** Any performance impacts or optimizations needed?
- **Testing Requirements:** What testing strategies are appropriate?
- **Documentation Needs:** What documentation should be created or updated?
- **Integration Points:** How does this connect with existing plan elements?

#### **Step 2: Update Task Decomposition**

Break down the new work into logical, manageable tasks:

- Identify major phases or milestones for the new work
- Break each phase into specific, actionable tasks
- Consider dependencies between new tasks and existing plan elements
- Estimate complexity and effort for each new task

#### **Step 3: Integration & Dependency Analysis**

- Map dependencies between new tasks and existing plan
- Identify potential conflicts or integration challenges
- Plan how new work fits into existing phases or creates new phases
- Determine impact on existing task priorities and timelines

#### **Step 4: Create Update Plan Structure**

Create a comprehensive update plan section with:

- Clear objectives and success criteria for new work
- Prioritized task list with dependencies (both new and existing)
- Implementation details and pseudocode where helpful
- Security and performance considerations
- Testing strategy for new functionality
- Documentation requirements

#### **Expert Agent Integration for Updates**

For complex technical planning tasks, consider using specialized agents (remind them to use context7 and websearch tools to find the latest documentation and code examples):

@.claude/agents-list.md

**Agent Usage for Plan Updates:**

- **python-backend-expert-planner:** For planning FastAPI, database, authentication, and backend security updates
- **nextjs-frontend-expert-planner:** For planning React components, TypeScript features, and frontend integration updates
- **python-cli-tui-expert-planner:** For planning CLI tool enhancements and TUI application updates
- **typescript-cli-tui-expert-planner:** For planning TypeScript-based CLI/TUI tool updates
- **bash-scripting-expert-planner:** For planning system automation and deployment script updates
- **mathematics-expert-planner:** For planning algorithm optimizations and mathematical modeling updates

#### **Step 5: Safe Integration Workflow**

Before making any changes to the main plan:

1. **Create Backup:**

   - Create backup: `dev-journal/OUR-PLAN.backup.md`
   - Verify backup was created successfully

2. **Plan Integration Strategy:**

   - Determine where new tasks fit in existing structure
   - Identify if new phases are needed
   - Plan how to update existing task dependencies
   - Consider priority adjustments needed

3. **Validate Integration:**
   - Ensure new work aligns with project objectives
   - Verify no conflicts with existing requirements
   - Check resource and timeline impacts
   - Confirm all dependencies make sense

#### **Step 6: Execute Integration**

Apply the update plan to the main plan systematically:

1. **Phase Integration:** Add new phases or integrate tasks into existing phases
2. **Dependency Updates:** Update task dependencies as needed
3. **Priority Adjustments:** Adjust task priorities if necessary
4. **Structure Preservation:** Maintain proper formatting and organization
5. **Reference Integrity:** Ensure all cross-references remain valid

### **Update Plan Output Format**

The update plan should be structured as follows before integration:

```markdown
# Update Plan: [UPDATE_DESCRIPTION]

## Update Objective

[Clear statement of what new work we're adding]

## Success Criteria

- [ ] [Specific measurable outcomes for new work]

## Integration Points

### Existing Plan Dependencies

[How this connects to current plan]

### New Dependencies Created

[What new dependencies this introduces]

## New Implementation Elements

### Phase [X]: [New Phase Name] (if creating new phase)

**Objective:** [What this phase accomplishes]

**Tasks:**

- [ ] [Specific actionable task]
  - **Details:** [Implementation details, files to modify, etc.]
  - **Dependencies:** [Dependencies on existing and new tasks]
  - **Notes:** [Additional context or pseudocode]

### Updates to Existing Phases

#### Phase [Y]: [Existing Phase Name]

**New Tasks to Add:**

- [ ] [Task to integrate into existing phase]
  - **Details:** [Implementation details]
  - **Dependencies:** [Updated dependencies]
  - **Integration Notes:** [How this fits with existing tasks]

## Testing Strategy Updates

- [ ] [New unit tests for...]
- [ ] [New integration tests for...]
- [ ] [Updated manual testing steps...]

## Documentation Updates Required

- [ ] [Update documentation for...]
- [ ] [Create new documentation for...]

## Risk Assessment for Integration

- **Risk:** [Potential integration issues]
  - **Mitigation:** [How to address it]
```

### **Integration Execution Steps**

1. **Create the Update Plan:** Write the comprehensive update plan following the structure above
2. **Validate Integration Strategy:** Ensure the plan integrates safely with existing work
3. **Create Backup:** Back up the current plan before modifications
4. **Execute Integration:** Carefully merge the update plan into the main plan
5. **Validate Result:** Ensure the integrated plan maintains integrity and completeness
6. **Initialize TodoWrite:** Sync any new immediate tasks with the TodoWrite system

### **Quality Assurance for Integration**

Before finalizing the updated plan, ensure:

- [ ] All new requirements from the request are addressed
- [ ] New tasks are specific and actionable
- [ ] Dependencies between new and existing work are clearly identified
- [ ] No conflicts exist between new and existing requirements
- [ ] Security and performance considerations are included
- [ ] Testing strategy covers new functionality
- [ ] Documentation needs for new work are identified
- [ ] Plan maintains structure and is easy to follow
- [ ] Success criteria are measurable
- [ ] Integration preserves existing plan integrity

### **Error Handling & Recovery**

#### **If Integration Fails:**

- Stop immediately and preserve current state
- Analyze the failure point and reason
- Restore from backup if necessary
- Report issues and request clarification
- Suggest alternative integration approaches

#### **If Conflicts Arise:**

- Document the conflict clearly
- Present options for resolution
- Recommend the safest approach
- Seek user guidance before proceeding

### **Final Steps**

1. **Create the Update:** Write the comprehensive update plan following the structure above
2. **Present Integrated Plan:** Show the updated plan for review and approval
3. **Highlight Changes:** Clearly indicate what was added or modified
4. **Ask for Adjustments:** Determine if any changes are needed
5. **Create Backup:** Save current plan to `dev-journal/previous-plans/OUR-PLAN.backup.md` (overwrite the file if it already exists)
6. **Save the Updated and Integrated Plan:** Update `dev-journal/OUR-PLAN.md` with the new plan
7. **Summary:** Provide a brief summary of the newly updated plan and next steps
8. **Exit:** When updating and integrating is complete call the `ExitPlanMode` tool to let me know the plan is complete and available for review at `dev-journal/OUR-PLAN.md`. Use the tool to inform me there is nothing left for you to do and that when I am ready to begin the next step, I just need to run the `/plan:expand-our-plan` command. Or, if I am ready to execute now, I just need to run the `/plan:resume-work-from-plan` command.

### **Post-Update Recommendations**

After successful integration:

- Present the updated plan to the user for review and approval
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
