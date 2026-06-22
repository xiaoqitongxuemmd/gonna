---
name: gonna-fix
description: Use this skill when the user has completed human selftest, recorded `不符合预期` feedback in docs/scrum/selftest, and wants to iterate fixes; read selftest feedback, coordinate gonna-arch for design intent updates, coordinate gonna-plan to create or update an intent-alignment fix Epic and Stories, run gonna-yolo in commit mode for fix implementation and automated verification, then run gonna-selftest to update human selftest documents without pushing.
version: 1.1.0
license: MIT
---

# Fix Skill

This skill orchestrates selftest-driven fix iteration for `gonna`. It is used after the user runs human selftest and records issues in `docs/scrum/selftest/**`.

It does not replace `gonna-arch`, `gonna-plan`, `gonna-yolo`, `gonna-commit`, or `gonna-selftest`. It coordinates them into one repeatable loop:

```text
selftest feedback -> arch intent update -> plan fix Epic/Stories -> yolo-commit fix -> selftest update
```

It must not push. It must not mark selftest as accepted for the user. The user remains the authority for `符合预期`.

## Project Role

Use this skill as the selftest feedback iteration layer:

- `gonna-selftest`: source of human feedback and updated selftest documents
- `gonna-arch`: updates design intent, contracts, or architecture documents when feedback reveals intent mismatch
- `gonna-plan`: creates or updates intent-alignment fix Epics and Stories
- `gonna-yolo`: executes the planned fix Stories in `yolo-commit` mode
- `gonna-commit`: creates or amends local unpushed implementation commits and keeps selftest artifacts separate

## When to Use

Use this skill when:

- The user says they finished selftest and recorded problems.
- A `docs/scrum/selftest/**` document contains required cases marked `不符合预期`.
- The user asks to iterate from selftest feedback.
- The user wants a fix Epic or Story created from selftest feedback.
- The user wants to run yolo fixes after selftest feedback.
- The user wants selftest documents updated after a fix pass.

Do not use this skill for first-time feature development without selftest feedback. Use `gonna-yolo` or `gonna-dev` instead.

Do not use this skill to push. Push remains under `gonna-commit` with accepted selftest evidence.

## Language Policy

Produce human-facing fix plans, run reports, Epic/Story files, and summaries in Simplified Chinese by default.

Keep skill names, branch names, commit SHAs, commands, paths, status values, API/RPC fields, Kafka topics, and raw output in their required technical form.

## Inputs

Read only what is needed:

- Selftest documents and feedback under `docs/scrum/selftest/`
- Generated selftest assets under `docs/scrum/selftest/assets/` when needed to understand the failing case
- Related Epic and Story files under `docs/scrum/prd/` and `docs/scrum/story/`
- Related design documents under `docs/design/`
- Current git state, local commits, and uncommitted changes
- Existing fix iteration reports under `docs/scrum/fix-reports/` when continuing an iteration

If the user does not identify a selftest document, inspect `docs/scrum/selftest/` for documents with `不符合预期` or unchecked required cases. If none exist, report that no fix iteration is needed.

## Fix Workflow

Use this workflow:

1. Inspect git status and current branch.
2. Read the relevant selftest document and extract every case marked `不符合预期`.
3. For each failing case, capture:
   - Case ID
   - Contract type and contract name
   - Expected behavior
   - Actual behavior
   - User feedback
   - Evidence commands or raw output
   - Affected design docs, Story, Epic, and code areas when identifiable
4. Classify each failure:
   - Design intent mismatch
   - Contract or API wording mismatch
   - Implementation bug
   - Missing automated test coverage
   - Selftest document or data issue
   - Environment issue
5. Use `gonna-arch` when the failure changes design intent, contract wording, service boundary, data model, event contract, or acceptance meaning.
6. Use `gonna-plan` to create or update one intent-alignment fix Epic for the affected feature or original Epic.
7. Add a new Story under the same fix Epic for each coherent fix unit. If the same fix Epic already exists, append Stories to it.
8. Use `gonna-yolo` in `yolo-commit` mode to implement, test, and locally commit the fix Stories.
9. Use `gonna-commit` rules:
   - Prefer amending the local unpushed Epic implementation commit when safe.
   - Do not amend pushed commits without explicit user authorization.
   - Do not commit `docs/scrum/selftest/**` with implementation or planning changes.
10. Use `gonna-selftest` to update the selftest document and data assets after the fix.
11. Stop and ask the user to run human selftest again. Do not push.
12. Write or update a fix iteration report under `docs/scrum/fix-reports/`.

## Compatibility Fix Gate

Do not turn selftest feedback into compatibility design by default.

If a fix could be solved either by changing the current contract or by adding compatibility behavior, prefer clarifying the current accepted intent first. Only create compatibility fix Stories after the user explicitly approves the compatibility design.

Do not add fallback fields, old and new payload support, versioned endpoints, adapters, dual-read/write, migration-only columns, or legacy selftest cases while repairing unless approved.

If compatibility is proposed by `gonna-arch`, record the user's approval reference in the fix report and in the planned Story.

## Fix Epic Rules

Intent-alignment fix Epics are long-lived for one feedback stream.

Rules:

- Create a fix Epic only if no existing suitable fix Epic covers the affected feature or original Epic.
- Reuse the existing fix Epic for repeated selftest failures in the same feature area.
- Add each fix pass as one or more new Stories under that fix Epic.
- Reference the original Epic/Story and selftest case IDs.
- Use tags such as `selftest-feedback`, `intent-alignment`, and the original Epic ID.
- Keep the fix Epic focused on aligning implementation with the user's confirmed intent.

Recommended names:

```text
EPIC-{number}: {feature} 意图对齐修复
STORY-{number}-XX: 修复 {contract/behavior} 的自测偏差
```

## Commit and Staging Rules

This skill may cause local commits through `gonna-yolo` and `gonna-commit`, but must respect these boundaries:

- Fix implementation/design/planning changes are one commit unit.
- Selftest document and asset updates are a separate commit unit.
- Before the user confirms selftest is `符合预期`, leave updated `docs/scrum/selftest/**` uncommitted unless the user explicitly asks for a draft selftest commit.
- After the user confirms selftest is `符合预期`, use `gonna-commit` to create a dedicated selftest evidence commit.
- Never push from this skill.

## Stop Conditions

Stop and report a blocker when:

- No failing selftest case can be found.
- Selftest feedback is too vague to classify and no evidence is available.
- The required design decision is ambiguous after reading the related docs.
- A fix Epic cannot be created because planning files have conflicting numbering or invalid metadata.
- `gonna-yolo` cannot complete the fix in `yolo-commit` mode.
- Automated tests fail and cannot be fixed inside the fix Story scope.
- The worktree contains unrelated changes that would be staged or overwritten.
- A pushed commit would need to be amended.
- Push, deployment, production access, or destructive git operations would be required.

## Artifacts

Write fix iteration artifacts under `docs/scrum/fix-reports/`, not under `docs/scrum/blocker/` or `docs/scrum/selftest/`.

Use:

- `.agents/skills/gonna-fix/templates/fix_iteration_report_template.md`

Recommended paths:

- `docs/scrum/fix-reports/fix-iteration-{YYYYMMDD}-{short-name}.md`

## Handoff

At the end, report:

- Selftest documents read
- Failing cases found
- Failure classification
- Design updates requested or produced by `gonna-arch`
- Fix Epic and Stories created or updated by `gonna-plan`
- `gonna-yolo` mode used: always `yolo-commit`
- Local commits created or amended, if any
- Selftest documents updated
- Remaining user action: run human selftest and mark cases `符合预期` or `不符合预期`
- Push status: always `Not pushed`
