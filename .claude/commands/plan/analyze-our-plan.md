---
description: "Analyze Our Plan with modern engineering practices."
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

Remember what project we are working on, its tech stack, and the goals of the project. We need to analyze or current plan and, maybe, do some more planning.

**IMPORTANT:** Activate your thinking mode and think hard as you will be analyzing a plan file and acting / responding accordingly.

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

#### **Current Plan Deep Dive**

Read and fully analyze the referenced Comprehensive Plan for success, below. Thoroughly understand it from the perspective of a senior engineer.

Here is the Comprehensive Plan, in its current state (this may be a big file so read it completely and fully):

```
@dev-journal/OUR-PLAN.md
```

### **2. Senior Engineer Analysis Framework**

Perform a comprehensive senior engineer's analysis of the Plan using modern software engineering practices:

#### **Analysis Tasks (Use TodoWrite tool)**

- [ ] Read and understand the referenced Comprehensive Plan from the perspective of a senior engineer
- [ ] Perform structural analysis of the plan organization
- [ ] Conduct completeness assessment
- [ ] Analyze security implications and considerations
- [ ] Evaluate performance considerations and impact
- [ ] Perform dependency analysis and critical path evaluation
- [ ] Assess prioritization and resource allocation
- [ ] Identify risks and mitigation strategies
- [ ] Evaluate testing strategy comprehensiveness
- [ ] Review documentation and knowledge management aspects

#### **Expert Agent Integration for Analysis**

For complex technical analysis tasks, consider using specialized agents (remind them to use context7 and websearch tools to find the latest documentation and code examples):

@.claude/agents-list.md

**Agent Usage Guidelines:**

- **python-backend-expert-planner:** For analyzing FastAPI, database, and security aspects of the plan
- **nextjs-frontend-expert-planner:** For analyzing React, TypeScript, and frontend architecture aspects
- **mathematics-expert-planner:** For analyzing algorithms, performance optimization, and complexity assessments
- **bash-scripting-expert-planner:** For analyzing deployment, automation, and infrastructure aspects
- **Feel free to use any and all available agents:** All the agents are available to you for usage. Use them wisely.

### **3. Detailed Analysis Categories**

#### **3.1 Plan Structure & Organization Analysis**

- **Strengths:** What aspects of the plan structure work well?
- **Weaknesses:** Where is the structure unclear or inefficient?
- **Recommendations:** How can the organization be improved?

#### **3.2 Completeness Assessment**

- **Coverage Analysis:** Does the plan address all functional requirements?
- **Technical Completeness:** Are all technical aspects covered?
- **Missing Elements:** What critical components are absent?
- **Gap Analysis:** Where are the knowledge or implementation gaps?

#### **3.3 Security & Performance Evaluation**

- **Security Considerations:**

  - Are security implications properly identified?
  - Are security best practices integrated into the plan?
  - Are potential vulnerabilities addressed?
  - Is secure coding guidance provided?

- **Performance Considerations:**
  - Are performance implications clearly understood?
  - Are optimization opportunities identified?
  - Are performance testing strategies included?
  - Are scalability concerns addressed?

#### **3.4 Dependency & Critical Path Analysis**

- **Dependency Mapping:** Are task dependencies clearly identified and logical?
- **Critical Path:** What is the critical path for project completion?
- **Blocking Risks:** What dependencies could become blockers?
- **Parallelization Opportunities:** Where can work be done in parallel?

#### **3.5 Prioritization Assessment**

- **Priority Logic:** Do the priorities make strategic sense?
- **Resource Allocation:** Are priorities aligned with available resources?
- **Business Value:** Are high-value tasks properly prioritized?
- **Risk-Based Prioritization:** Are high-risk items addressed early?

#### **3.6 Risk Analysis & Mitigation**

- **Technical Risks:** What technical challenges could derail the plan?
- **Resource Risks:** Are there resource or skill gaps?
- **Timeline Risks:** Are estimates realistic?
- **Integration Risks:** What integration challenges exist?
- **Mitigation Strategies:** Are risk mitigation approaches adequate?

#### **3.7 Testing Strategy Evaluation**

- **Test Coverage:** Is the testing strategy comprehensive?
- **Test Types:** Are appropriate test types included (unit, integration, e2e)?
- **Quality Assurance:** Are QA processes properly defined?
- **Automation Strategy:** Is test automation appropriately planned?

#### **3.8 Documentation & Knowledge Management**

- **Documentation Strategy:** Is documentation planning adequate?
- **Knowledge Transfer:** How will knowledge be preserved and shared?
- **Onboarding Considerations:** Can new team members easily understand the plan?

### **4. Analysis Output Requirements**

Provide a comprehensive analysis report covering:

#### **Executive Summary**

- Overall plan assessment (strong/moderate/needs improvement)
- Top 3 strengths
- Top 3 areas for improvement
- Recommended immediate actions

#### **Detailed Findings**

For each analysis category above:

- Specific findings
- Evidence from the plan
- Impact assessment
- Recommendations

#### **Priority Recommendations**

Rank recommendations by:

1. **Critical (Fix Immediately):** Issues that could cause project failure
2. **High (Address Soon):** Issues that could cause significant delays
3. **Medium (Plan to Address):** Issues that could improve efficiency
4. **Low (Nice to Have):** Minor improvements

### **5. Validation & Recommendations**

#### **Consistency Check**

- Do priorities and dependencies align and not contradict each other?
- Are success criteria measurable and achievable?
- Does the plan support the overall project objectives?

#### **Modern Engineering Practices Assessment**

- **DevOps Integration:** Are CI/CD practices considered?
- **Code Quality:** Are code review and quality practices included?
- **Monitoring & Observability:** Are logging and monitoring planned?
- **Scalability:** Are future scaling needs considered?
- **Maintainability:** Is long-term maintenance addressed?

### **6. Questions & Clarifications**

Do you have any questions for me about the Plan and our work? Anything I should clarify for you?

Based on the analysis, what specific aspects of the plan would you like me to focus on or investigate further?

### **7. Next Steps Recommendations (Use `ExitPlanMode` tool to inform me of the next steps)**

Based on the analysis results, use the `ExitPlanMode` tool to recommend appropriate follow-up actions:

- If critical issues found: Immediate plan revision needed
- If expansion needed: Suggest `/plan/expand-our-plan`
- If updates needed: Suggest `/plan/update-our-plan`
- If plan is solid: Suggest `/plan/resume-work-from-plan`

**Remember:** The goal is to ensure the plan is robust, comprehensive, and executable before significant development effort begins.
