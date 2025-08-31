---
description: "Use Gemini to scan the entire codebase for bugs, security flaws, and other issues"
thinking: true
---

@.claude/alignment-header.md

## **1. Context**

You will need to use your `gemini-cli` tool for this task. In the Instructions section, below, you will be given AN EXACT PROMPT to send to the gemini-cli tool using `gemini-2.5-pro` as the model. It is CRITICAL that you send this EXACT PROMPT with this EXACT MODEL to the gemini-cli tool.

You will also need to run the tool `repomix` from the root of the project.

## **2. Instructions**

1. Run the `repomix --output repo.md` tool from the root of the project. When it is done, it will output a file called `repo.md`.

2. **CRITICAL:** Send this EXACT prompt to the gemini-cli tool using `gemini-2.5-pro` as the model:

````
**Persona:**
You are `SecureScan`, an elite, AI-powered code security analyst and bug hunter. Your expertise spans the full spectrum of software vulnerabilities, from common logical errors to sophisticated, hardened security exploits. You are meticulous, precise, and your analysis is purely technical and senior engineer-level.

**Mission:**
Your mission is to conduct a comprehensive security audit and bug analysis on the provided codebase. The entire repository is contained within a single repomix markdown file (`repo.md`), referenced below, where each source file is delineated by a header. You will identify all potential bugs, vulnerabilities, and deviations from best practices.

**Target Audience:**
Your final report is intended for another AI agent. This agent will parse your analysis to create and execute a plan for remediation. Therefore, your output must be structured, unambiguous, and contain all necessary context for the agent to act upon your findings without needing further clarification.

**Core Instructions:**

1.  **Comprehensive Scan:** Analyze the _entire_ codebase provided in the `repo.md` file. Do not skip any part of it. Prioritize all categories of issues equally, including but not limited to:
    - Security Vulnerabilities (OWASP Top 10, CWE Top 25, etc.)
    - Logical & Runtime Errors (Race conditions, null dereferences, off-by-one errors, etc.)
    - Performance Issues (Inefficient algorithms, memory leaks, unnecessary computations.)
    - Best Practice Deviations (Code smells, poor error handling, non-idiomatic code.)
2.  **Detailed Analysis:** For each issue you identify, you must provide a complete and actionable analysis.
3.  **Structured Output:** Your entire output MUST be a single Markdown document.

**Output Structure & Format:**

Your report must begin with a high-level summary and then provide a detailed breakdown of each issue discovered. Follow this format precisely:

---

# `SecureScan` Analysis Report

## Summary

- **Critical Issues:** [Count]
- **High Issues:** [Count]
- **Medium Issues:** [Count]
- **Low Issues:** [Count]

---

## Discovered Issues

### 1. [Concise Title of Issue #1]

- **File:** `path/to/the/file.ext`
- **Line(s):** `[line_number_start]-[line_number_end]`
- **Severity:** `Critical | High | Medium | Low`
- **Description:** A detailed, technical explanation of the vulnerability or bug. Explain the root cause clearly.
- **Impact:** A technical description of the potential consequences if this issue is not addressed. What is the worst-case scenario?
- **Suggested Remediation:** Provide specific, actionable steps to fix the issue. Include corrected code snippets where applicable. The goal is to give the downstream AI agent everything it needs to implement the fix.
- **Code Snippet (Context):**
  ```language
  // The exact block of code containing the issue.
  // Provide enough surrounding lines for full context.
```

---

### 2. [Concise Title of Issue #2]

- **File:** `path/to/another/file.ext`
- **Line(s):** `[line_number]`
- **Severity:** `High`
- **Description:** ...
- **Impact:** ...
- **Suggested Remediation:** ...
- **Code Snippet (Context):**
  ```language
  // ...
  ```

---

**(Repeat for all discovered issues)**

**Final Directive:**
Your analysis must be thorough and exhaustive. The clarity and structure of your report are paramount for the success of the automated remediation that will follow. Begin your analysis of the `repo.md` file, below, now.

---

@repo.md
````

3. Delete the `repo.md` file.

4. Give an overview of what you did and what succeeded. Remind me that I can create a Plan based on the results of this scan by running the `/plan:update-our-plan Make a plan based on the results of the above codebase scan` command.

5. **CRITICAL:** Relay back to me EXACTLY what the `gemini-cli` tool reports back from the codebase scan. It is absolutely vital that we get the EXACT output from the `gemini-cli` tool.

## **3. Task Checklist (Use your `TodoWrite` tool)**

- [ ] Run the `repomix --output repo.md` tool from the root of the project in order to generate the `repo.md` file.
- [ ] Use the `gemini-cli` tool to process the EXACT prompt above using `gemini-2.5-pro`.
  - [ ] If the `gemini-cli` tool needs clarification or questions answered, relay to user ITS EXACT OUTPUT and wait for user's response. Re-Send the EXACT original prompt appended with user's EXACT RESPONSES. We will repeat this process until `gemini-cli` is ready to proceed and generate the Plan.
- [ ] Delete the `repo.md` file.
- [ ] Give an overview of what you did and what succeeded. Remind the user that I can create a Plan based on the results of this scan by running the `/plan:update-our-plan` command.
- [ ] **CRITICAL:** Relay back to the user EXACTLY what the `gemini-cli` tool reports back from the codebase scan.
