---
description: "Use Gemini to create a Plan to implement a New Feature / Bug Fix"
argument-hint: "[Brief description of the work to be done]"
thinking: true
---

## **1. Context**

You will need to use your `gemini-cli` tool for this task. In the Instructions section, below, you will be given AN EXACT PROMPT to send to the gemini-cli tool using `gemini-2.5-pro` as the model. It is CRITICAL that you send this EXACT PROMPT with this EXACT MODEL to the gemini-cli tool.

You will also need to run the tool `repomix` from the root of the project.

## **2. Instructions**

1. Run the `repomix --output repo.md` tool from the root of the project. When it is done, it will output a file called `repo.md`.

2. **CRITICAL:** Send this EXACT prompt to the gemini-cli tool using `gemini-2.5-pro` as the model:

```
Read and fully analyze the referenced Codebase encoded as a repomix markdown file, below. Thoroughly understand it from the perspective of a senior engineer.

$ARGUMENTS

Right now, our Goal is to formulate and create a Comprehensive Plan for an AI coding assistant (such as yourself and maybe even you) to carry out the work and implement the new code in the Codebase. Make sure the plan includes Error Handling and Testing.

Once all Tests pass, have the plan specifically "perform our git process". You do not need to detail the whole process, just have the Plan include something along the lines of "Once all implementations are complete and all tests pass, you will perform an agentic git commit with the `git-commit-philosopher` agent" and it will be understood.

Do you have any questions for me before we begin? Anything I should clarify for you? If I need to then STOP and ask first.

---

@repo.md
```

3. **CRITICAL:** If the `gemini-cli` tool needs clarification or questions answered, relay to me ITS EXACT OUTPUT and wait for my response. Re-Send the EXACT original prompt appended with my EXACT RESPONSES. We will repeat this process until `gemini-cli` is ready to proceed and generate the Plan.

4. Save gemini-cli's output to `dev-journal/plan_from_gemini.md`. Create the file if it does not exist. Overwrite the file if it already exists.

5. Delete the `repo.md` file.

6. Give an overview of what you did and what succeeded. Remind me to review and edit the `dev-journal/plan_from_gemini.md` file. Finally, let me know that when I am ready to proceed and implement the new feature or bug fix, I just need to run the `/gemini:gemini-plan-execute` command.

## **3. Task Checklist (Use your `TodoWrite` tool)**

- [ ] Run the `repomix --output repo.md` tool from the root of the project in order to generate the `repo.md` file.
- [ ] Use the `gemini-cli` tool to process the EXACT prompt above using `gemini-2.5-pro`.
  - [ ] If the `gemini-cli` tool needs clarification or questions answered, relay to user ITS EXACT OUTPUT and wait for user's response. Re-Send the EXACT original prompt appended with user's EXACT RESPONSES. We will repeat this process until `gemini-cli` is ready to proceed and generate the Plan.
- [ ] Save the response to `dev-journal/plan_from_gemini.md`, creating the file if it does not already exist. Overwrite the file if it already exists.
- [ ] Delete the `repo.md` file.
- [ ] Give an overview of what you did and what succeeded. Remind the user to review and edit the `dev-journal/plan_from_gemini.md` file. End by let the user know that when they are ready to proceed and implement the new feature or bug fix, they just need to run the `/gemini:gemini-plan-execute` command.
