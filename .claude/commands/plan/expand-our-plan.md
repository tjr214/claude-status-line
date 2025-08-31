---
description: "Expand the tasks in Our Plan into detailed sub-tasks with agent integration."
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

### **1. Context Gathering**

Remember what project we are working on, its tech stack, and the goals of the project.

#### **Project Overview**

- **Project Description:**

```
@dev-journal/PROJECT-DESCRIPTION.md
```

- **Tech Stack:**

```
@dev-journal/TECH-STACK.md
```

- **Product Requirements:**

```
@dev-journal/PRD-MINI.md
```

#### **Current Plan Analysis**

Read and fully analyze the attached Comprehensive Plan for success, below. Thoroughly understand it from the perspective of a senior engineer.

Here is the Comprehensive Plan (`dev-journal/OUR-PLAN.md`), in its current state (this may be a big file so read it completely and fully):

```
@dev-journal/OUR-PLAN.md
```

### **2. Task Expansion Analysis**

#### **Expansion Tasks (Use TodoWrite tool)**

- [ ] Read and understand the referenced Comprehensive Plan from the perspective of a senior engineer
- [ ] Identify tasks that are too broad, vague, or would benefit from being expanded into sub-tasks
- [ ] Analyze each identified task for complexity and decomposition opportunities
- [ ] Design detailed sub-tasks with complete implementation guidance
- [ ] Consider agent integration opportunities for specialized tasks (these are our `expert-planner` agents)
- [ ] Validate expanded tasks against project requirements and constraints
- [ ] Ensure expanded tasks maintain logical dependencies and flow
- [ ] Get user approval before updating the plan

### **3. Task Identification Criteria**

Analyze our Comprehensive Plan and find tasks that meet these criteria for expansion:

#### **3.1 Breadth Indicators**

- Tasks that span multiple components or systems
- Tasks with multiple distinct outcomes
- Tasks that could take more than 4-6 hours to complete
- Tasks that involve multiple technology domains

#### **3.2 Vagueness Indicators**

- Tasks with unclear implementation approaches
- Tasks missing specific files or components to modify
- Tasks without clear acceptance criteria
- Tasks that junior engineers couldn't execute independently

#### **3.3 Complexity Indicators**

- Tasks involving complex algorithms or business logic
- Tasks requiring integration between multiple systems
- Tasks with significant security or performance implications
- Tasks requiring extensive testing or validation

### **4. Expansion Framework**

For each task identified for expansion, create detailed sub-tasks following this framework:

#### **4.1 Sub-Task Structure**

```markdown
#### [Main Task Title]

**Overview:** [Brief description of what this accomplishes]

**Sub-Tasks:**

##### Sub-Task 1: [Specific Action]

- **Objective:** [What this sub-task accomplishes]
- **Files to Modify/Create:** [Specific file paths]
- **Implementation Details:**
  - [Step-by-step guidance]
  - [Code snippets or pseudocode if helpful]
  - [Configuration changes needed]
- **Dependencies:** [Prerequisites for this sub-task]
- **Agent Recommendation:** [Which expert agent to use, if applicable]
- **Acceptance Criteria:** [How to know it's complete]
- **Testing Requirements:** [Specific tests to write/run]

##### Sub-Task 2: [Next Specific Action]

[Continue pattern...]
```

#### **4.2 Agent Integration Opportunities**

**IMPORTANT:** Consider recommending expert agents for specialized tasks (also, if you choose experts remind them to use context7 and websearch tools to find the latest documentation and documentation code examples -- and also remind them to use their thinking mode and "think hard" about the tasks they are expanding):

@.claude/agents-list.md

#### **4.3 Implementation Guidance Requirements**

Each sub-task should include everything needed for execution:

- **Technical Specifications:** Exact requirements and constraints
- **Code Examples:** Pseudocode or code snippets where helpful
- **Configuration Details:** Environment setup, dependency changes
- **File Locations:** Exact paths for files to create/modify
- **Integration Points:** How this connects with other components
- **Error Handling:** Expected issues and mitigation strategies
- **Performance Considerations:** Optimization requirements
- **Security Requirements:** Security implications and safeguards

### **5. Validation & Quality Assurance**

#### **5.1 Expansion Validation**

Before presenting expanded tasks, ensure:

- [ ] Each sub-task is independently executable
- [ ] Dependencies between sub-tasks are clear and logical
- [ ] All sub-tasks together fully accomplish the original task
- [ ] Implementation guidance is comprehensive and clear
- [ ] Junior engineers could execute the sub-tasks without confusion
- [ ] Agent recommendations are appropriate and helpful
- [ ] Testing requirements are specific and actionable

#### **5.2 Plan Integration Check**

Review the expanded tasks in full context:

- [ ] Do the expanded tasks make sense within the overall project flow?
- [ ] Are there any new dependencies created that affect other parts of the plan?
- [ ] Do the expanded tasks enhance the understandability of the plan?
- [ ] Are the estimated efforts and timelines still realistic?
- [ ] Do the expanded tasks maintain the overall project objectives?

### **6. Expansion Output Format**

Present the expansion recommendations in this format:

#### **Tasks Identified for Expansion**

1. **[Original Task Name]** (Line X in plan)

   - **Reason for Expansion:** [Why this needs expansion]
   - **Complexity Assessment:** [High/Medium complexity reasoning]
   - **Recommended Agent:** [Which expert agent would help]

2. **[Next Task...]**

#### **Detailed Sub-Task Breakdown**

For each task to be expanded, provide the complete sub-task structure as defined in the framework above.

#### **Impact Assessment**

- **Timeline Impact:** How expansion affects overall timeline
- **Resource Impact:** Additional skills or resources needed
- **Risk Mitigation:** How expansion reduces implementation risks
- **Quality Improvement:** How expansion improves deliverable quality

### **7. Approval & Implementation**

#### **Pre-Update Checklist**

Before updating the plan:

- [ ] All expanded tasks have been thoroughly reviewed
- [ ] Dependencies and integration points are validated
- [ ] Agent recommendations are appropriate
- [ ] Implementation guidance is comprehensive
- [ ] **CRITICAL:** User approval has been obtained via the `ExitPlanMode` tool.

#### **IMPORTANT: Update Process**

Once approved via the `ExitPlanMode` tool:

1. **Create Backup:** Save current plan to `dev-journal/previous-plans/OUR-PLAN.backup.md` (overwrite the file if it already exists)
2. **Apply Expansions:** Update the plan with expanded sub-tasks
3. **Validate Structure:** Ensure plan formatting and structure remain intact
4. **Summary Report:** Provide summary of changes made

### **8. Final Validation**

**CRITICAL:** Check back in with me to get approval before updating the Plan with the new sub-tasks.

Do you have any questions for me about the Plan and our work? Anything I should clarify for you?

### **9. Next Steps**

After successful expansion:

- Recommend running `/plan/analyze-our-plan` to validate the improved plan
- Recommend running `/plan/resume-work-from-plan` after the plan is validated to begin execution, or right now if I am ready to execute immediately
- Consider if further refinements are needed based on the expansion results
