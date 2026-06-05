---
name: gonna-submit
description: Use this skill when the user asks to prepare, review, stage, commit, push, or package verified changes for merge request submission in this ai-native go-zero microservice framework project; create commit plans, commit messages, merge request descriptions, submission reports, or review handoff evidence.
version: 1.0.0
license: MIT
---

# Submit Skill

This skill packages verified local changes into reviewable submission units. `gonna-test` provides verification evidence, and `gonna-submit` creates clean commits, push evidence, merge request material, and submission reports.

It is not responsible for writing feature code, designing tests, defining CI/CD gates, approving merges, online deployment, or release operations. Those rules must be specialized per project and team when needed.

## Project Role

`gonna` is an ai-native engineering framework for go-zero based microservice development.

Use this skill as the submission layer:

- `gonna-dev`: Story to implementation, focused tests, validation, and implementation report
- `gonna-test`: implementation to test plan, verification evidence, defect report, and completion recommendation
- `gonna-selftest`: human contract acceptance and push-gate evidence
- `gonna-repair`: selftest feedback to intent-alignment fix Epics, yolo-submit repairs, and updated selftest documents
- `gonna-submit`: verified local changes to commit plan, commit, push, merge request description, and submission report

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
- Producing submission reports for project-specific review, CI/CD, or release gates when the team defines them
- Packaging `gonna-dev` implementation evidence and `gonna-test` verification evidence into reviewable form
- Checking `gonna-selftest` human acceptance before push
- Keeping generated selftest artifacts out of development/test commits until the user has completed human selftest acceptance
- Amending local unpushed Epic commits when selftest feedback creates additional alignment-fix Stories for the same Epic

Do not use this skill to decide whether a merge request is allowed to merge. Merge approval, CI/CD readiness, release gates, and production operations belong to project-specific team workflows outside the generic `gonna` framework.

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

## Branch Policy Handling

Do not define a fixed branch model inside this skill. Branch management belongs to the team's documented workflow and the repository's actual Git configuration.

Before commit, push, rebase, or MR/PR preparation:

- Inspect the current branch, upstream, remotes, and worktree status.
- Use `git branch -vv` and `git remote -v` as repository facts.
- Follow the team's documented branch policy when it exists.
- Follow the user's explicit current-turn branch instruction when it intentionally overrides the default policy.
- If policy and observed Git state conflict, stop and ask for clarification before changing upstreams, rebasing, pushing, or rewriting history.

For multi-remote repositories, treat each local branch and its upstream independently. Do not infer that a branch name is a remote name, or that a remote name is a branch name.

## Submission Workflow

Use this workflow:

1. Inspect current branch, remotes, and worktree status.
2. Confirm the intended submission target from the team's branch policy, observed upstream mapping, or explicit user instruction.
3. Review `git diff --stat` and relevant diffs before staging.
4. Identify the submission scope: Story, direct request, bug fix, scaffold change, documentation change, or framework change.
5. Separate unrelated changes. Do not stage unrelated files unless the user explicitly includes them.
6. Check that generated go-zero files are consistent with `.api` or `.proto` changes when applicable.
7. Check that validation evidence exists from `gonna-dev` or `gonna-test`, or record the gap.
8. Create a commit plan before committing when the scope is non-trivial.
9. Stage only files in scope.
10. Commit only when the user asks to commit.
11. Before push or MR preparation, apply the team's required branch synchronization rule, such as rebase, only when the policy or user explicitly requires it.
12. For push, check required `gonna-selftest` cases are completed and marked `符合预期`.
13. Push only when the user explicitly asks to push and selftest push gate passes.
14. Produce a submission report and MR/PR description when requested.

## Selftest Artifact Submission Rules

Selftest artifacts are human acceptance materials. Treat them as a separate submission unit from implementation and automated test changes.

Rules:

- Do not include `docs/scrum/selftest/**` changes in the same commit as development, generated go-zero code, automated tests, or planning fixes unless the user explicitly asks.
- When yolo or submit generates selftest documents before the user has executed them, leave those files uncommitted or commit them only in a dedicated selftest draft commit when explicitly requested.
- After the user marks all required selftest cases `符合预期`, commit selftest documents and assets as a dedicated selftest evidence commit.
- If the user marks any case `不符合预期`, do not commit the selftest result as final evidence. Preserve the feedback, route it back to `gonna-arch`/`gonna-plan`/`gonna-dev` as needed, and keep subsequent implementation commits separate from selftest artifacts.
- When the user asks to iterate from `不符合预期` selftest feedback, use `gonna-repair` as the coordinating skill instead of handling arch, plan, yolo, and selftest updates ad hoc.
- If selftest feedback causes code/design changes, stage implementation/design/planning files separately from selftest files.
- Push is blocked until accepted selftest artifacts have been committed separately or the user explicitly states that no selftest artifact commit is required for the push.

Recommended commit split:

```text
feat(epic-N): implement {epic goal}
fix(epic-N): align {behavior} with selftest feedback
docs(selftest): record accepted {epic/story} contract selftest
```

## Alignment Fix Amend Rules

When selftest exposes an intent mismatch after a local Epic commit has already been created:

- Ask `gonna-plan` to create or update an intent-alignment fix Epic when the issue changes design intent, contract wording, or acceptance criteria.
- Add repeated fix attempts as new Stories under the same alignment fix Epic instead of creating scattered unrelated work items.
- For local unpushed commits that belong to the same Epic scope, prefer `git commit --amend` or an explicit fixup/squash plan so the final local Epic commit represents the accepted implementation state.
- Do not amend commits that have already been pushed unless the user explicitly asks for history rewrite and confirms the target branch.
- Do not amend selftest evidence into an implementation commit. Accepted selftest artifacts remain a separate commit.
- When amending, restage only the files that belong to the Epic implementation/design/planning fix. Leave `docs/scrum/selftest/**` unstaged unless creating the dedicated selftest evidence commit.

## Git Safety Rules

- Do not rewrite shared history unless the user explicitly requests it.
- If the team's policy or user requires rebase and the branch was already pushed, push the rebased branch only with explicit user authorization and prefer `--force-with-lease` over unconditional force push.
- Do not run destructive commands such as `git reset --hard` or `git checkout --` to discard changes.
- Do not commit secrets, real credentials, local-only env files, or machine-specific files.
- Do not stage unrelated changes.
- Do not hide validation failures.
- Do not push unless the user explicitly asks and required selftest cases are marked `符合预期`.
- Do not merge branches or approve merge requests.
- Do not change branch upstreams, add remotes, or push to an untracked target unless the user explicitly asks or the repository policy clearly requires it.
- If the worktree contains user changes outside the requested scope, leave them untouched and report them.

## Submission Readiness

A submission is ready to commit when:

- The branch is known.
- The intended submission target is clear from policy, upstream mapping, or user instruction.
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
- Required branch synchronization has been completed when required by team policy or explicit user instruction.
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

Use after commit or push, or when handing off to a project-specific review or release workflow.

Use:

- `.agents/skills/gonna-submit/templates/submission_report_template.md`

## Handoff to Project-Specific Review

When submission is complete, provide:

- Branch and commit SHA
- Remote and pushed branch when applicable
- Submission scope
- Validation evidence
- Known risks or missing evidence
- Selftest push-gate status
- MR/PR description path or inline description
- Any requested gate exceptions
