---
description: "Start new Session and resume work from Our Plan."
thinking: true
---

@.claude/alignment-header.md

## **WORK SESSION BOOTUP**

### **1. Context Gathering & Initialization**

**IMPORTANT:** Activate your thinking mode as it will be required for this process.

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

Here is the Comprehensive Plan, in its current state (this may be a big file so read it completely and fully):

```
@dev-journal/OUR-PLAN.md
```

The Plan contains a checklist of tasks that need to be completed and, thus, also serves as a record of what has already been accomplished.

The Plan may also contain code, pseudocode, and other information we will need to successfully complete our tasks.

### **2. Work Resumption Protocol**

#### **Phase 2.1: Plan Understanding & Status Assessment**

Using your TodoWrite tool, track the following initialization tasks:

- [ ] Read and understand the referenced Comprehensive Plan from the perspective of a senior engineer
- [ ] Identify the current phase and section we should be working on
- [ ] Determine which tasks are completed (checked) vs pending (unchecked)
- [ ] Understand the files, classes, and components referenced in our current section
- [ ] Assess any dependencies or prerequisites for the current work
- [ ] Identify appropriate expert agents for the current phase

#### **Phase 2.2: TodoWrite Synchronization**

**CRITICAL:** ALWAYS sync your internal TODO system (`TodoWrite`) with the Plan. This makes sure the whole team stays on the same page:

1. **Current Section Identification:**

   - Identify which section/phase of the plan we're currently working on
   - Focus on unchecked items in the active section

2. **TodoWrite Sync Process:**

   - Read the current Comprehensive Plan checklist items for the active section
   - Create corresponding TODOs for unchecked items in our current work area
   - Mark completed TODOs for items that are already checked in the plan
   - Ensure TodoWrite reflects the actual plan status

3. **Codebase Verification:**
   - **Always** verify and understand the files, classes, etc. from our codebase that are referenced in the Plan section we're working on
   - Read relevant files to understand current implementation state
   - Validate that our understanding matches the plan expectations

### **3. Expert Sub-Agent Coordination**

**IMPORTANT:** **You are acting as the Main Agent in a multi-agent system.** You communicate and consult with the expert sub-agents in order to accomplish the tasks at hand. The expert sub-agents are the best at what they do and they work for you, the Main Agent. Use them to your advantage. Get their advice, guidance, expertise, suggestions, analysis, debugging assistance, and even code or pseudocode to help you accomplish our goals as a team. Anything you need, the expert sub-agents are here to help you with.

#### **3.1 Expert Sub-Agent Selection Strategy**

**CRITICAL:** For each task in our current section, consider which expert agent would be most effective in providing guidance and instructions for said task during our Execution Workflow:

@.claude/agents-list.md

#### **3.2 Expert Sub-Agent Consultation Instructions**

**IMPORTANT:** When consulting expert planning agents (those ending in `-expert-planner`) during our Execution Workflow:

1. **Provide Context:** Always tell the planner to read the `dev-journal/OUR-PLAN.md` file from the specific section we are working on
2. **Line Number Guidance:** Provide line numbers or ranges for the planner to focus on the relevant section
3. **Specific Instructions:** Give the planner clear, specific instructions about what needs planning guidance
4. **Plan Integration:** Ensure the planner understands how their guidance fits into the overall plan
5. **Implementation Focus:** Ask for specific implementation guidance and best practices to follow

### **4. Execution Workflow**

#### **4.1 Work Execution Process**

Think hard: Let's continue our work from where we left off. Ensure you update the checklists in the Plan as we go.

**Systematic Approach:**

1. **Task Selection:**

   - Choose the next logical unchecked task from our current section
   - Verify all dependencies for this task are satisfied
   - Understand the full context and requirements

2. **Expert Consultation & Implementation:**

   - **IMPORTANT:** For every task, first consult the relevant expert sub-agent (ending in `-expert-planner`) for guidance and best practices
   - **Provide Context:** Give the planner the current plan section, requirements, and any relevant codebase context
   - **Get Expert Guidance:** Receive implementation strategy, code patterns, security considerations, and best practices
   - **Execute Implementation:** Implement the work yourself based on the expert planner's guidance
   - **Quality Focus:** Follow the planner's recommendations for testing, security, and code quality

3. **Progress Tracking:**

   - Mark TodoWrite items as completed when finished
   - **CRITICAL:** Update the `dev-journal/OUR-PLAN.md` file directly when tasks are completed (check boxes, add notes)
   - Add implementation notes or discoveries to the plan if helpful

4. **Quality Assurance:**
   - Verify task completion meets acceptance criteria
   - Test functionality if applicable
   - Ensure integration with existing work

#### **4.2 Section Completion Protocol**

When we complete a whole section of the Plan:

1. **Section Review:**

   - Verify all tasks in the section are completed
   - Ensure quality standards are met
   - Validate integration points work correctly

2. **Agentic Commit:**

   - Perform an agentic git commit using the `git-commit-philosopher` agent
   - Provide the agent with context about the completed section
   - Include meaningful commit message with section summary

3. **Progress Documentation:**
   - Update plan with any lessons learned or important notes
   - Document any changes or deviations from original plan
   - Prepare for next section transition

### **5. Continuous Monitoring & Adaptation**

#### **5.1 Progress Tracking**

Throughout the work session:

- **Regular Status Updates:** Keep internal awareness of progress
- **Blocker Identification:** Identify issues early and address them
- **Plan Alignment:** Ensure work stays aligned with plan objectives
- **Quality Maintenance:** Maintain code quality and testing standards

#### **5.2 Issue Resolution**

When encountering blockers:

- **Document the Issue:** Clearly describe the problem
- **Assess Impact:** Determine how this affects the plan
- **Seek Solutions:** Try multiple approaches or expert agent assistance
- **Escalate if Needed:** Bring issues to user attention when necessary

### **6. Session Completion Reporting**

When you are done, report back to confirm you have followed the Plan. Provide a brief status update, including:

#### **6.1 Completion Summary**

- [ ] Tasks completed this session (with specific details)
- [ ] Sections of the plan that were finished
- [ ] Key accomplishments and deliverables

#### **6.2 Current Status**

- [ ] Current blockers or questions (if any)
- [ ] Quality assurance results (tests, linting, etc.)
- [ ] Integration status and any issues

#### **6.3 Technical Results**

- [ ] Results of the git-commit-philosopher agent, if applicable
- [ ] Code quality metrics or test results
- [ ] Performance or security considerations addressed

#### **6.4 Next Steps**

- [ ] Tell me the next upcoming items on the Plan
- [ ] Identify any prerequisites for the next work session
- [ ] Highlight any decisions or clarifications needed

### **CRITICAL: 7. Pre-Work Confirmation**

**IMPORTANT:** Do you have any questions for me before we begin our work? Anything I should clarify for you?

### **8. Quality Standards**

Throughout the work session, maintain these standards:

- **Code Quality:** Follow project coding standards and best practices
- **Testing:** Write and run appropriate tests for new functionality
- **Documentation:** Update relevant documentation as needed
- **Security:** Consider security implications of all changes
- **Performance:** Monitor performance impacts of implementations
- **Integration:** Ensure all changes integrate properly with existing code

### **9. Success Criteria**

A successful work session should result in:

- Clear progress on plan objectives
- High-quality, tested implementations
- Updated plan with accurate completion status
- Clear understanding of next steps
- Professional commit history with meaningful messages
- No regressions or broken functionality
