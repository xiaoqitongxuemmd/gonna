---
name: gonna-yolo
description: Use this skill when the user explicitly asks to run planned Epics or Stories autonomously, execute yolo mode, iterate through docs/scrum Story files, drive gonna-dev to implement, gonna-test to verify, and gonna-commit to package commits within strict stop conditions for this ai-native go-zero microservice framework project.
version: 1.1.0
license: MIT
---

# YOLO Skill

This skill is the authorized autonomous runner for `gonna`. It reads planned Epic and Story files, selects executable Stories, and drives the approved loop of `gonna-dev -> gonna-test -> gonna-commit -> gonna-selftest -> feedback fix` within strict stop conditions.

`gonna-yolo` means fewer confirmations inside an approved scope. It does not mean lower quality, skipped validation, unsafe Git behavior, uncontrolled scope expansion, merge approval, or deployment.

`gonna-yolo` is an orchestrator, not a replacement author for downstream reports. It must not produce one broad yolo document that substitutes for `gonna-dev` implementation reports, `gonna-test` test reports, `gonna-commit` commit reports, or `gonna-selftest` selftest documents.

## Project Role

Use this skill as the execution orchestration layer:

- `gonna-arch`: source documents to architecture and implementation handoff
- `gonna-plan`: architecture handoff to AI-executable Epic and Story files
- `gonna-yolo`: planned Stories to autonomous dev/test/commit iterations
- `gonna-deploy`: local Docker Compose deployment and dependency/service container setup when a Story requires it
- `gonna-dev`: Story implementation
- `gonna-test`: verification and completion recommendation
- `gonna-selftest`: human contract selftest docs, prepared data, and push gate
- `gonna-fix`: selftest-feedback fix iteration through arch, plan, yolo-commit, and selftest update
- `gonna-commit`: commit and merge request packaging

## When to Use

Use this skill only when the user explicitly asks for autonomous execution, yolo mode, automatic iteration, or to run planned Stories.

Examples:

- "run gonna-yolo for the next Story"
- "yolo mode 按 plan 自动推进"
- "按照 docs/scrum 的 Story 自动 dev test commit"
- "自动执行 EPIC-1 的 TODO Stories"

Do not infer yolo mode from a normal implementation request. Use `gonna-dev` for ordinary implementation and `gonna-commit` for ordinary commit/push requests.

## Authorization Modes

Require the user's requested authorization mode before execution. If omitted, default to `yolo-dev`.

### yolo-dev

Allowed:

- Select eligible Stories
- Update Story status to `IN_PROGRESS` or `TESTING`
- Use `gonna-dev` to implement
- Use `gonna-test` to verify
- Update KANBAN
- Write blocker reports only when execution stops abnormally

Not allowed:

- Commit
- Push
- Merge
- Deploy

### yolo-commit

Allowed:

- Everything in `yolo-dev`
- Use `gonna-commit` to create local commits
- Use `gonna-commit` for Git safety, staging, commit, and branch-policy checks
- Generate or update selftest TODO docs when contract behavior changed

Not allowed:

- Push unless the user explicitly adds push permission
- Merge
- Deploy

### yolo-push

Allowed:

- Everything in `yolo-commit`
- Push to the explicitly named remote and branch
- Use `gonna-commit` to apply the team's required branch synchronization rule before push
- Check required selftest cases are marked `符合预期` before push

Not allowed:

- Merge
- Deploy
- Force push unless the user explicitly asks and confirms

## Language Policy

Produce human-facing yolo output in Simplified Chinese by default. This includes blocker reports, status summaries, and user-facing explanations.

Keep Story IDs, Epic IDs, branch names, commit SHAs, commands, paths, status values, remote names, URLs, and raw tool output in their required technical form. Skill instructions and templates may remain in English.

## Inputs

Read the minimum needed inputs:

- Epic files: `docs/scrum/prd/epic-*.md`
- Story files: `docs/scrum/story/story-*.md`
- KANBAN: `docs/scrum/KANBAN.md` when present
- Architecture references listed in Story `design_refs`
- Source documents listed in Story `source_docs`
- Existing implementation and test reports when present
- Selftest docs under `docs/scrum/selftest/` when push is requested

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

## Compatibility Stop Rule

YOLO must not introduce compatibility design on its own.

If a selected Story, implementation path, selftest feedback, or repair appears to require backward compatibility, forward compatibility, legacy support, versioned interfaces, fallback fields, dual-read/write, migration-only fields, or adapters, stop and require explicit user approval unless that compatibility is already approved in the Story or design docs.

Do not continue autonomously by adding compatibility API/RPC fields, database columns, Kafka message fields, Redis keys, config keys, tests, or selftest cases.

## Execution Loop

For each selected Story:

1. Create or update a yolo run plan.
2. Mark the Story `IN_PROGRESS` using `gonna-plan` status rules.
3. Use `gonna-deploy` only if the Story requires local deployment, dependency containers, microservice containers, or observability setup.
4. Use `gonna-dev` to implement the Story and produce its own implementation report or inline equivalent.
5. Run focused validation.
6. Use `gonna-test` to verify acceptance criteria and quality gates and produce its own test report, defect report, or completion recommendation.
7. Move Story status according to `gonna-plan`; do not invent a separate status flow in this skill.
8. Use `gonna-selftest` to generate or update human contract selftest docs and prepare data when the Story changes API, RPC, event, database-visible behavior, Redis/cache-visible behavior, scheduled jobs, webhooks, or user-visible behavior.
9. If authorization is `yolo-commit` or `yolo-push`, use `gonna-commit` to create or amend a clean implementation commit. Completed selftest is not required for local commit.
10. Do not commit generated selftest artifacts with the implementation commit. Leave selftest files uncommitted until the user completes human selftest, unless the user explicitly asks for a dedicated selftest draft commit.
11. If the user marks any selftest case `不符合预期`, stop normal progression and hand off to `gonna-fix`. `gonna-fix` must route feedback to `gonna-arch` and `gonna-plan` as needed, create or update an intent-alignment fix Epic, add fix Stories, run yolo-commit fixes, and update selftest.
12. When rerunning yolo for a selftest-feedback fix Epic, implement and verify the new Stories, then use `gonna-commit` to amend the local unpushed Epic implementation commit when it is safe to do so. Do not amend pushed commits unless explicitly authorized.
13. After selftest is updated and the user confirms all required cases `符合预期`, use `gonna-commit` to create a dedicated selftest evidence commit.
14. If authorization is `yolo-push`, use `gonna-commit` to apply Git safety checks and push only after accepted selftest artifacts are separately committed and only to the explicit target remote and branch.
15. Mark the Story `COMPLETED` only when `gonna-plan` status rules, `gonna-test` verification, and required commit/selftest work for the authorization mode are satisfied.
16. Update `docs/scrum/KANBAN.md`.
17. If a hard stop occurs, write a blocker report under `docs/scrum/blocker/`. If no blocker occurs, do not create a yolo run report that summarizes development and testing content.

## Selftest Feedback Loop

Expected loop:

```text
yolo development -> automated test -> implementation commit -> selftest generation -> human selftest
```

If human selftest passes:

```text
accepted selftest -> dedicated selftest commit -> push gate may pass
```

If human selftest fails:

```text
不符合预期 -> gonna-fix -> arch updates design if needed -> plan updates/creates intent-alignment Epic -> yolo-commit fixes Stories -> commit amends local Epic commit -> selftest updates -> repeat
```

Rules:

- Do not mix selftest artifact changes into implementation commits.
- Do not continue to push while any required selftest case is unchecked or marked `不符合预期`.
- Keep repeated fixes for the same selftest feedback stream inside the same intent-alignment fix Epic.
- Prefer amending the local unpushed Epic implementation commit so the final commit reflects the user's accepted intent.
- Keep the dedicated selftest evidence commit last, after the user confirms acceptance.

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
- Generated selftest artifacts would be staged together with implementation or automated test changes.
- Amending would require rewriting a pushed commit without explicit user authorization.
- Required branch policy is missing or conflicts with observed Git state when commit, push, rebase, or MR preparation is requested.
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

Use the status flow and completion rules defined by `gonna-plan`. Do not duplicate or override them here.

## Blocker Artifacts

Write yolo artifacts under `docs/scrum/blocker/` only for blockers and abnormal stops. Do not write normal development summaries, test summaries, implementation reports, or all-in-one yolo run reports.

Use only when blocked:

- `.agents/skills/gonna-yolo/templates/blocker_report_template.md`

Recommended paths:

- `docs/scrum/blocker/blocker-{story-id}.md`

Forbidden yolo artifacts:

- A single yolo document that covers all implementation details and all test details.
- Story iteration reports that duplicate `gonna-dev` and `gonna-test` reports.
- Run reports that replace `gonna-commit` or `gonna-selftest` artifacts.

## Handoff

At the end of a yolo run, report:

- Authorization mode
- Story scope
- Stories completed
- Stories blocked
- Commits created, if any
- Push target and result, if any
- Paths to downstream reports produced by `gonna-dev`, `gonna-test`, `gonna-commit`, or `gonna-selftest`, if any
- Blocker report path, if blocked
- Next recommended action
