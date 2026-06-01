---
name: gonna-yolo
description: Use this skill when the user explicitly asks to run planned Epics or Stories autonomously, execute yolo mode, iterate through docs/scrum Story files, drive gonna-dev to implement, gonna-test to verify, and gonna-submit to package commits within strict stop conditions for this ai-native go-zero microservice framework project.
version: 1.0.0
license: MIT
---

# YOLO Skill

This skill is the authorized autonomous runner for `gonna`. It reads planned Epic and Story files, selects executable Stories, and drives the approved loop of `gonna-dev -> gonna-test -> gonna-selftest -> gonna-submit` within strict stop conditions.

`gonna-yolo` means fewer confirmations inside an approved scope. It does not mean lower quality, skipped validation, unsafe Git behavior, uncontrolled scope expansion, merge approval, or deployment.

## Project Role

Use this skill as the execution orchestration layer:

- `gonna-arch`: source documents to architecture and implementation handoff
- `gonna-plan`: architecture handoff to AI-executable Epic and Story files
- `gonna-yolo`: planned Stories to autonomous dev/test/submit iterations
- `gonna-env`: local dependency setup when a Story requires it
- `gonna-dev`: Story implementation
- `gonna-test`: verification and completion recommendation
- `gonna-selftest`: human contract selftest docs, prepared data, and push gate
- `gonna-submit`: commit and merge request packaging
- future `gonna-devops`: merge gates and CI/CD readiness

## When to Use

Use this skill only when the user explicitly asks for autonomous execution, yolo mode, automatic iteration, or to run planned Stories.

Examples:

- "run gonna-yolo for the next Story"
- "yolo mode 按 plan 自动推进"
- "按照 docs/scrum 的 Story 自动 dev test submit"
- "自动执行 EPIC-1 的 TODO Stories"

Do not infer yolo mode from a normal implementation request. Use `gonna-dev` for ordinary implementation and `gonna-submit` for ordinary commit/push requests.

## Authorization Modes

Require the user's requested authorization mode before execution. If omitted, default to `yolo-dev`.

### yolo-dev

Allowed:

- Select eligible Stories
- Update Story status to `IN_PROGRESS` or `TESTING`
- Use `gonna-dev` to implement
- Use `gonna-test` to verify
- Update KANBAN and run reports

Not allowed:

- Commit
- Push
- Merge
- Deploy

### yolo-submit

Allowed:

- Everything in `yolo-dev`
- Use `gonna-submit` to create local commits
- Generate or update selftest TODO docs when contract behavior changed

Not allowed:

- Push unless the user explicitly adds push permission
- Merge
- Deploy

### yolo-push

Allowed:

- Everything in `yolo-submit`
- Push to the explicitly named remote and branch
- Check required selftest cases are marked `符合预期` before push

Not allowed:

- Merge
- Deploy
- Force push unless the user explicitly asks and confirms

## Language Policy

Produce human-facing yolo output in Simplified Chinese by default. This includes run plans, run reports, Story iteration reports, blocker reports, status summaries, and user-facing explanations.

Keep Story IDs, Epic IDs, branch names, commit SHAs, commands, paths, status values, remote names, URLs, and raw tool output in their required technical form. Skill instructions and templates may remain in English.

## Inputs

Read the minimum needed inputs:

- Epic files: `docs/scrum/prd/epic-*.md`
- Story files: `docs/scrum/story/story-*.md`
- KANBAN: `docs/scrum/KANBAN.md` when present
- Architecture references listed in Story `design_refs`
- Source documents listed in Story `source_docs`
- Existing implementation and test reports when present
- Selftest docs under `docs/selftest/` when push is requested

If no Story files exist, stop and ask the user to run `gonna-plan` first.

## Story Selection

Select Stories using this order:

1. Include only requested Epic/Story scope, if provided.
2. Include only Stories with status `TODO` or explicitly requested resumable status.
3. Exclude Stories whose `dependencies` or `blocked_by` are not completed.
4. Sort by priority: `P0`, `P1`, `P2`, `P3`.
5. Sort by `execution_order`.
6. Sort by Epic number, then Story number.

Run one Story at a time unless the user explicitly requests batch execution. Even in batch mode, stop at the first hard blocker.

## Required Story Readiness

A Story is eligible when:

- It has acceptance criteria.
- It has implementation notes or `dev_handoff`.
- It has validation plan or `test_handoff`.
- Its dependencies are complete.
- It does not require unresolved architecture decisions.
- Required environment dependencies are already available or covered by a design/environment contract.

If readiness fails, do not invent missing requirements. Produce a blocker report.

## Execution Loop

For each selected Story:

1. Create or update a yolo run plan.
2. Mark the Story `IN_PROGRESS`.
3. Use `gonna-env` only if the Story requires local dependencies or observability setup.
4. Use `gonna-dev` to implement the Story.
5. Run focused validation.
6. Mark the Story `TESTING`.
7. Use `gonna-test` to verify acceptance criteria and quality gates.
8. Use `gonna-selftest` to generate or update human contract selftest docs and prepare data when the Story changes API, RPC, event, database-visible behavior, Redis/cache-visible behavior, scheduled jobs, webhooks, or user-visible behavior.
9. If verification passes, mark the Story `IN_REVIEW`.
10. If authorization is `yolo-submit` or `yolo-push`, use `gonna-submit` to create a clean commit. Completed selftest is not required for local commit.
11. If authorization is `yolo-push`, push only when required selftest cases are marked `符合预期`, and only to the explicit target remote and branch.
12. Mark the Story `COMPLETED` only when acceptance criteria are verified and required submission/selftest work for the authorization mode is complete.
13. Update `docs/scrum/KANBAN.md`.
14. Write a Story iteration report and update the run report.

## Hard Stop Conditions

Stop immediately and produce a blocker report when any of these occur:

- Story has no acceptance criteria.
- Story dependencies are incomplete.
- Required architecture decision is missing.
- Required environment dependency is not defined by architecture or environment contract.
- `gonna-dev` cannot complete implementation.
- `gonna-test` returns `Fail`.
- Required selftest case is marked `不符合预期` or left unchecked when push is requested.
- Required selftest document is missing when push is requested.
- P0 or P1 defect exists.
- `go test ./...` or `go build ./...` fails and cannot be fixed within the Story scope.
- Worktree contains unrelated changes that would be staged or overwritten.
- Diff contains secrets, real credentials, local-only env files, or machine-specific files.
- Generated go-zero code is out of sync with `.api` or `.proto`.
- Destructive Git operation is required.
- Push target is unclear in `yolo-push`.
- Merge, release, or deploy is required.
- User interrupts or changes the requested scope.

## Status Updates

Use Story status values from `gonna-plan`:

- `TODO`
- `IN_PROGRESS`
- `IN_REVIEW`
- `TESTING`
- `BLOCKED`
- `COMPLETED`
- `CANCELLED`

Preferred flow:

```text
TODO -> IN_PROGRESS -> TESTING -> IN_REVIEW -> COMPLETED
```

Failure flow:

```text
IN_PROGRESS -> BLOCKED
TESTING -> BLOCKED
```

Do not mark `COMPLETED` without verification evidence.

## Run Artifacts

Write execution artifacts under `docs/run/`, not under `docs/scrum/`.

Use:

- `.agents/skills/gonna-yolo/templates/yolo_run_plan_template.md`
- `.agents/skills/gonna-yolo/templates/yolo_run_report_template.md`
- `.agents/skills/gonna-yolo/templates/story_iteration_report_template.md`
- `.agents/skills/gonna-yolo/templates/blocker_report_template.md`

Recommended paths:

- `docs/run/yolo-run-{YYYYMMDD}-{short-name}.md`
- `docs/run/story-iteration-{story-id}.md`
- `docs/run/blocker-{story-id}.md`

## Handoff

At the end of a yolo run, report:

- Authorization mode
- Story scope
- Stories completed
- Stories blocked
- Commits created, if any
- Push target and result, if any
- Validation evidence
- Updated files
- Next recommended action
