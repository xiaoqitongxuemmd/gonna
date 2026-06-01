---
name: gonna-submit
description: Use this skill when the user asks to prepare, review, stage, commit, push, or package verified changes for merge request submission in this ai-native go-zero microservice framework project; create commit plans, commit messages, merge request descriptions, submission reports, or handoff evidence between gonna-test and gonna-devops.
version: 1.0.0
license: MIT
---

# Submit Skill

This skill packages verified local changes into reviewable submission units. It sits between `gonna-test` and future `gonna-devops`: `gonna-test` provides verification evidence, `gonna-submit` creates clean commits and merge request material, and `gonna-devops` evaluates merge gates and CI/CD readiness.

It is not responsible for writing feature code, designing tests, defining CI/CD gates, approving merges, or deploying releases.

## Project Role

`gonna` is an ai-native engineering framework for go-zero based microservice development.

Use this skill as the submission layer:

- `gonna-dev`: Story to implementation, focused tests, validation, and implementation report
- `gonna-test`: implementation to test plan, verification evidence, defect report, and completion recommendation
- `gonna-selftest`: human contract acceptance and push-gate evidence
- `gonna-submit`: verified local changes to commit plan, commit, push, merge request description, and submission report
- future `gonna-devops`: submitted merge request to gate evaluation, CI/CD readiness, release gate, and deployment readiness

## When to Use

Use this skill for:

- Preparing a commit after implementation and testing
- Reviewing `git status`, `git diff`, and staged changes before commit
- Detecting unrelated or risky changes before staging
- Creating a commit plan
- Generating Story-aware commit messages
- Staging files intentionally
- Running `git commit` when the user asks to commit
- Pushing a branch when the user explicitly asks to push
- Creating merge request or pull request descriptions
- Producing submission reports for future `gonna-devops` gate checks
- Packaging `gonna-dev` implementation evidence and `gonna-test` verification evidence into reviewable form
- Checking `gonna-selftest` human acceptance before push

Do not use this skill to decide whether a merge request is allowed to merge. That belongs to future `gonna-devops`.

## Language Policy

Produce human-facing submission output in Simplified Chinese by default. This includes commit plans, merge request descriptions, submission reports, risk notes, review summaries, and user-facing explanations.

Keep branch names, commit message subjects, commands, paths, Story IDs, Epic IDs, status values, remote names, URLs, and raw Git output in their required technical form. Skill instructions and templates may remain in English.

## Inputs

Prefer one or more of these inputs:

- Story file under `docs/scrum/story/`
- `gonna-dev` implementation report
- `gonna-test` test report or defect report
- `gonna-selftest` selftest report or selftest document
- User request to commit, push, or prepare an MR/PR
- Current `git status`, `git diff --stat`, and relevant `git diff`
- Existing branch and remote information

When reports are missing but the user explicitly asks to submit, proceed with the available Git evidence and clearly record missing evidence as risk.

## Submission Workflow

Use this workflow:

1. Inspect current branch, remotes, and worktree status.
2. Review `git diff --stat` and relevant diffs before staging.
3. Identify the submission scope: Story, direct request, bug fix, scaffold change, documentation change, or framework change.
4. Separate unrelated changes. Do not stage unrelated files unless the user explicitly includes them.
5. Check that generated go-zero files are consistent with `.api` or `.proto` changes when applicable.
6. Check that validation evidence exists from `gonna-dev` or `gonna-test`, or record the gap.
7. Create a commit plan before committing when the scope is non-trivial.
8. Stage only files in scope.
9. Commit only when the user asks to commit.
10. For push, check required `gonna-selftest` cases are completed and marked `符合预期`.
11. Push only when the user explicitly asks to push and selftest push gate passes.
12. Produce a submission report and MR/PR description when requested.

## Git Safety Rules

- Do not rewrite history unless the user explicitly requests it.
- Do not run destructive commands such as `git reset --hard` or `git checkout --` to discard changes.
- Do not commit secrets, real credentials, local-only env files, or machine-specific files.
- Do not stage unrelated changes.
- Do not hide validation failures.
- Do not push unless the user explicitly asks and required selftest cases are marked `符合预期`.
- Do not merge branches or approve merge requests.
- If the worktree contains user changes outside the requested scope, leave them untouched and report them.

## Submission Readiness

A submission is ready to commit when:

- The branch is known.
- The intended scope is clear.
- Changed files match the intended scope.
- No obvious secret or local-only file is included.
- Generated code is synchronized when contracts changed.
- Validation commands and results are known, or gaps are explicitly recorded.
- Commit message is specific and traceable.

Selftest is not required for local commit.

A submission is ready to push when:

- Commit exists locally.
- Target remote and branch are clear.
- User explicitly asked to push.
- Push target does not conflict with the intended workflow.
- Required human contract selftest documents exist when local unpushed changes affect API, RPC, Kafka/event, database-visible behavior, Redis/cache-visible behavior, scheduled jobs, webhooks, or user-visible business behavior.
- Every required selftest case is marked `符合预期`.
- No required selftest case is marked `不符合预期` or left unchecked.

If selftest is missing or incomplete, do not push. Use `gonna-selftest` to generate or check selftest documents and data assets.

## Commit Message Rules

Prefer Conventional Commit style:

```text
<type>(<scope>): <summary>
```

Common types:

- `feat`: user-facing or system capability
- `fix`: bug fix
- `docs`: documentation or skill documentation
- `test`: tests or verification assets
- `chore`: maintenance, scaffolding, references, or tooling
- `ci`: CI/CD or gate configuration
- `refactor`: behavior-preserving code restructuring

Use Story-aware scope when available:

```text
feat(story-1-01): implement user API scaffold
```

For framework changes without a Story, use a clear project scope:

```text
docs(submit): add submission workflow skill
```

## Output Modes

Choose the smallest useful mode.

### 1. Commit Plan

Use before staging or committing non-trivial changes.

Use:

- `.agents/skills/gonna-submit/templates/commit_plan_template.md`

### 2. Commit Message

Use when the user asks for a commit message or when committing.

Use:

- `.agents/skills/gonna-submit/templates/commit_message_template.md`

### 3. Merge Request Description

Use when the user asks to prepare an MR/PR.

Use:

- `.agents/skills/gonna-submit/templates/merge_request_description_template.md`

### 4. Submission Report

Use after commit or push, or when handing off to future `gonna-devops`.

Use:

- `.agents/skills/gonna-submit/templates/submission_report_template.md`

## Handoff to DevOps

When submission is complete, provide:

- Branch and commit SHA
- Remote and pushed branch when applicable
- Submission scope
- Validation evidence
- Known risks or missing evidence
- Selftest push-gate status
- MR/PR description path or inline description
- Any requested gate exceptions
