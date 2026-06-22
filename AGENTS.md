# Project AI Instructions

This project is an ai-native engineering framework for go-zero based microservice development.

It integrates project-level skills for architecture, planning, local Docker Compose deployment, development, testing, selftest, fix iteration, and commit packaging.

## Context Sources

- Primary architecture skill: `gonna-arch` at `.agents/skills/gonna-arch/SKILL.md`
- Planning skill: `gonna-plan` at `.agents/skills/gonna-plan/SKILL.md`
- Deploy skill: `gonna-deploy` at `.agents/skills/gonna-deploy/SKILL.md`
- Development skill: `gonna-dev` at `.agents/skills/gonna-dev/SKILL.md`
- Test skill: `gonna-test` at `.agents/skills/gonna-test/SKILL.md`
- Selftest skill: `gonna-selftest` at `.agents/skills/gonna-selftest/SKILL.md`
- Fix iteration skill: `gonna-fix` at `.agents/skills/gonna-fix/SKILL.md`
- Commit skill: `gonna-commit` at `.agents/skills/gonna-commit/SKILL.md`
- YOLO runner skill: `gonna-yolo` at `.agents/skills/gonna-yolo/SKILL.md`
- go-zero workflow reference for arch: `.agents/ai-context/00-instructions.md`
- go-zero task workflow reference for arch: `.agents/ai-context/workflows.md`
- goctl command reference for arch: `.agents/ai-context/tools.md`
- go-zero pattern reference for arch: `.agents/ai-context/patterns.md`
- go-zero detailed knowledge reference for arch: `.agents/skills/zero-skills/SKILL.md`

## Default Rules

- Use `gonna-arch` as the main entry for source document analysis, architecture design, technical stack decisions, service decomposition, API/RPC/event/data contracts, scaffold planning, environment contracts, observability architecture, resilience/security design, migration planning, and implementation handoff.
- Use `gonna-plan` when the user asks to split architecture output, implementation handoff, PRDs, specifications, or design documents into Epics, Stories, acceptance criteria, dependency order, execution scope, or AI-readable backlog.
- Use `gonna-deploy` when the user asks to create, update, run, or verify local deployment assets, Docker Compose topology, dependency containers, development microservice containers, environment variables, go-zero config mapping, health checks, local observability with OpenTelemetry, Prometheus, Grafana, tracing, or logs, local database state SQL under `deploy/local/sql/`, or versioned online migration SQL under `deploy/sql/`. For a release request, it compares the two repository views and prepares only the missing online migration; it must not execute against staging or production.
- Use `gonna-dev` when the user asks to implement Stories, generate go-zero code, modify API/RPC/model/logic/config, fix bugs, add tests, run validation, or prepare implementation reports. For any approved database schema change, `gonna-dev` must hand off to `gonna-deploy` to update the matching `deploy/local/sql/` state before relying on the changed schema.
- Use `gonna-test` when the user asks to design tests, verify Story acceptance criteria, validate implementations, evaluate coverage, run or interpret test/build output, produce test reports, report defects, or decide whether a Story can be completed.
- Use `gonna-selftest` when the user asks to generate or verify human contract selftest docs from local unpushed changes, prepare local test data, create HTTP/RPC/Kafka/DB/Redis input-output probes, or check push readiness from human acceptance results.
- Use `gonna-fix` when the user has completed human selftest, recorded `不符合预期` feedback, and wants to iterate fixes through arch intent updates, plan fix Epic/Stories, yolo-commit execution, and selftest document updates.
- Use `gonna-commit` when the user asks to prepare, review, stage, commit, push, or package verified changes for review; create commit plans, commit messages, merge request descriptions, or commit reports.
- Use `gonna-yolo` only when the user explicitly asks for yolo mode, autonomous iteration, or to automatically run planned Epics/Stories through dev, test, and commit loops.
- Treat `.agents/ai-context/` and `.agents/skills/zero-skills/` as references that support the architecture skill.
- Do not ask the user to invoke `ai-context` or `zero-skills` directly for normal project work.
- Load the specific go-zero reference files only when the architecture task needs that level of detail.
- Treat maintained, versioned `docs/design/*_vX.Y.Z.md` documents as the project-wide architecture source of truth. Architecture document templates live under `.agents/skills/gonna-arch/templates/`.
- Do not treat temporary notes, unversioned files, exploratory drafts, screenshots, chat exports, or copied references as accepted architecture facts just because they are placed under `docs/design/`.
- If a temporary/reference document contains a design detail that should become project truth, update or create the relevant maintained versioned design document before handing work to `gonna-plan`, `gonna-deploy`, `gonna-dev`, `gonna-test`, `gonna-selftest`, or `gonna-yolo`.

## Language Policy

- Human-facing artifacts produced inside this repository must be written in Simplified Chinese by default.
- This includes README files, design documents, architecture handoffs, environment runbooks, Epic and Story files, KANBAN views, implementation reports, PR descriptions, test plans, test reports, defect reports, and user-facing summaries.
- Keep code, commands, paths, identifiers, API/RPC field names, status enum values, commit messages, and configuration keys in their original language or required technical form.
- Project skills, agent instructions, templates, and embedded reference/framework documentation may be written in English because they are AI/runtime guidance rather than final user-facing deliverables.
- If an upstream source document is in English, preserve exact technical terms when needed, but explain decisions and generated project documents in Simplified Chinese.

## go-zero Conventions

- Create or update `.api` or `.proto` specs before generating code.
- Use `goctl` for generated boilerplate instead of hand-writing generated files.
- Keep Handler -> Logic -> Model responsibilities separate.
- Put business logic in `internal/logic`.
- Inject dependencies through `ServiceContext`.
- Pass `context.Context` through service layers.
- Run post-generation checks: `go mod tidy`, import verification, and `go build ./...`.
- Generate or update README/API/RPC docs when adding services or endpoints.

## Skill Governance

- Resolve instruction conflicts in this order: explicit user instruction in the current turn, repository facts observed with tools, this `AGENTS.md`, the active project skill, referenced supporting skills, and templates.
- Repository facts include `git status`, `git branch -vv`, `git remote -v`, existing files, generated contracts, and current unpushed changes. Do not override these facts with a generic skill template.
- Skills must not invent branch management policy. Branch naming, upstream mapping, rebase target, push target, and MR/PR target must come from the team's documented workflow, the user's explicit instruction, or observed Git tracking configuration.
- When team policy is missing or conflicts with observed Git state, stop before commit, push, merge, rebase, or history rewrite and ask for clarification.
- Keep a single owner for each rule area: `gonna-plan` owns Story status values and flow; `gonna-selftest` owns human contract selftest gates; `gonna-commit` owns staging, commit, push, and Git safety checks; `gonna-yolo` orchestrates these skills and must not duplicate their detailed rules.
- When a coordinating skill such as `gonna-yolo` calls another skill, the called skill's owned gate is authoritative for that gate.
- `gonna-yolo` must not replace downstream artifacts. Implementation reports belong to `gonna-dev`; test plans, test reports, and defect reports belong to `gonna-test`; commit reports belong to `gonna-commit`; selftest documents belong to `gonna-selftest`.
- `docs/scrum/blocker/` is for yolo orchestration blockers and abnormal stop reports. Do not use one yolo document to summarize or replace all development and testing work.
- Architecture changes discovered during planning, development, testing, selftest, or fix iteration must be synchronized back into the relevant maintained `docs/design/*_vX.Y.Z.md` document. Do not leave accepted design intent only in temporary notes, implementation reports, test reports, blocker reports, or fix reports.

## Compatibility Approval Gate

- Do not add compatibility design by default.
- Do not add backward-compatible, forward-compatible, legacy-compatible, future-proof, reserved, optional-for-future, migration-only, shadow, alias, fallback, deprecated, versioned, or adapter fields/interfaces/tables/configs unless the user explicitly approves that compatibility design.
- This applies to API routes, request/response fields, RPC methods/messages, Kafka/event schemas, database tables/columns/indexes, Redis keys, config keys, migrations, selftest cases, and generated docs.
- If compatibility may be needed, first present the compatibility need, affected contracts, alternatives, risk of not doing it, and concrete fields/interfaces to be added. Wait for explicit user approval before including them in architecture, planning, implementation, tests, or selftest artifacts.
- Prefer the minimal current-intent contract over speculative extensibility.

## Architecture Workflow

- For architecture design, PRD analysis, design document analysis, spec document analysis, technical stack selection, service decomposition, API/RPC/event design, data model design, scaffold planning, local environment requirements, observability architecture, resilience/security design, migration planning, or implementation planning, read `gonna-arch` from `.agents/skills/gonna-arch/SKILL.md`.
- Let the architecture skill decide which go-zero workflow and knowledge references to load.
- The expected user-facing workflow is `gonna-arch` only for architecture work; `ai-context` and `zero-skills` are internal references for `gonna-arch`.
- `gonna-arch` must classify design-related inputs before use: maintained versioned design documents are authoritative; temporary/reference files are inputs only. Accepted decisions from temporary/reference files must be promoted into maintained design documents before downstream execution.

## Planning Workflow

- For Epic planning, Story decomposition, acceptance criteria, implementation phases, execution ordering, or progress tracking, read `gonna-plan` from `.agents/skills/gonna-plan/SKILL.md`.
- Prefer using `gonna-arch` output as the input to `gonna-plan`.
- Keep Epic and Story source files under `docs/scrum/prd/` and `docs/scrum/story/`.
- By default, `gonna-plan` should materialize planning output into Epic, Story, and KANBAN files unless the user explicitly asks for conversation-only planning.
- Do not assume human team scheduling fields such as Sprint length, calendar dates, assignees, or capacity unless the user explicitly asks for them.

## Deploy Workflow

- For local Docker Compose deployment, dependency containers, development microservice containers, database/cache/queue/service discovery setup, go-zero config mapping, observability stack, deployment health checks, local database state SQL preparation, or release migration SQL preparation, read `gonna-deploy` from `.agents/skills/gonna-deploy/SKILL.md`.
- Prefer using `gonna-arch` deployment/environment contract and observability architecture as the input to `gonna-deploy`.
- Let `gonna-deploy` materialize deployment files and reports without making architecture technology choices on its own.
- `gonna-deploy` provides local Docker Compose deployment, maintains `deploy/local/sql/` as the local database state, and may compare it with `deploy/sql/` to prepare versioned online migration SQL as reviewed artifacts. Online deployment execution, release orchestration, CI/CD, merge gates, and production operations are intentionally outside the generic framework and must be specialized per project/team.

## Development Workflow

- For Story implementation, go-zero scaffold generation, API/RPC/model changes, logic implementation, bug fixes, focused tests, validation, commits, or implementation reports, read `gonna-dev` from `.agents/skills/gonna-dev/SKILL.md`.
- Prefer using `gonna-plan` Story files as the input to `gonna-dev`.
- Use `gonna-deploy` when local deployment, dependencies, service containers, or observability are required to run or debug the implementation.
- Let `gonna-dev` decide which go-zero workflow and `zero-skills` implementation references to load.

## Test Workflow

- For test planning, API/RPC contract tests, integration tests, acceptance verification, coverage evaluation, defect reports, or completion recommendations, read `gonna-test` from `.agents/skills/gonna-test/SKILL.md`.
- Prefer using `gonna-plan` Story files and `gonna-dev` implementation reports as the input to `gonna-test`.
- Use `gonna-deploy` when integration or observability verification requires local deployment or dependencies.
- Let `gonna-test` decide which go-zero and `zero-skills` verification references to load.

## Selftest Workflow

- For human-executed contract selftest documents from local unpushed changes, generated selftest data, copy-paste probes, or push-gate selftest checks, read `gonna-selftest` from `.agents/skills/gonna-selftest/SKILL.md`.
- `gonna-selftest` owns documents under `docs/scrum/selftest/` and generated assets under `docs/scrum/selftest/assets/`.
- For HTTP changes, generate one independent selftest case and one standalone copy-paste `curl` for every changed endpoint or required endpoint scenario; do not replace per-API review with one shell script that calls many APIs.
- The assistant should prepare selftest data whenever possible; the user should validate HTTP/RPC/Kafka and other contract behavior, check `符合预期` or `不符合预期` for each required case, and write feedback when behavior differs from intent.
- Local commit does not require completed selftest.
- Do not commit generated `docs/scrum/selftest/**` artifacts together with implementation, generated go-zero code, automated tests, or planning fixes. Commit accepted selftest artifacts separately after the user finishes human selftest.
- Push requires all required selftest cases to be marked `符合预期`; any `不符合预期` feedback blocks push and is routed to `gonna-fix` for coordinated arch, plan, yolo-commit, and selftest updates.

## Fix Workflow

- For selftest-feedback fix iteration, read `gonna-fix` from `.agents/skills/gonna-fix/SKILL.md`.
- `gonna-fix` starts only after the user has run human selftest and recorded one or more `不符合预期` cases.
- `gonna-fix` must coordinate `gonna-arch` for design-intent updates when needed, `gonna-plan` for intent-alignment fix Epic/Stories, `gonna-yolo` in `yolo-commit` mode for fix implementation and automated verification, and `gonna-selftest` for updated selftest documents.
- `gonna-fix` must not push. It stops after updating selftest and asks the user to run human selftest again.
- Repeated selftest fix attempts for the same feature should reuse the same intent-alignment fix Epic and append new Stories.
- Write fix iteration artifacts under `docs/scrum/fix-reports/`, not under `docs/scrum/blocker/` or `docs/scrum/selftest/`.

## Commit Workflow

- For commit planning, staging review, commit creation, branch push, merge request descriptions, or commit reports, read `gonna-commit` from `.agents/skills/gonna-commit/SKILL.md`.
- Prefer using `gonna-dev` implementation reports, `gonna-test` test reports, and `gonna-selftest` push-gate status as input to `gonna-commit`.
- Keep `gonna-commit` focused on packaging verified changes. Merge gate policy, CI/CD readiness, release workflows, and production operations are not provided by the generic framework and must be specialized per project/team when needed.
- Commit and push work must follow the team's documented branch management policy and the observed Git upstream mapping. If those are missing or inconsistent, stop before push, rebase, or MR preparation and ask for clarification.
- Keep implementation commits and selftest evidence commits separate. If selftest feedback causes repeated fix work before push, plan the work under an intent-alignment fix Epic and amend the local unpushed Epic implementation commit when safe.
- Do not push unless the user explicitly asks and required human contract selftests are marked `符合预期`.

## YOLO Workflow

- For authorized autonomous execution of planned Stories, read `gonna-yolo` from `.agents/skills/gonna-yolo/SKILL.md`.
- `gonna-yolo` must use existing `docs/scrum/prd/` and `docs/scrum/story/` planning artifacts as the execution source of truth.
- `gonna-yolo` may drive `gonna-deploy`, `gonna-dev`, `gonna-test`, `gonna-selftest`, and `gonna-commit` within the requested authorization mode.
- Default authorization mode is `yolo-dev`; committing requires `yolo-commit`, and pushing requires `yolo-push` plus an explicit target remote and branch.
- `yolo-commit` may create local commits without completed selftest; `yolo-push` must stop until required human selftests are marked `符合预期`.
- If human selftest reports `不符合预期`, `gonna-yolo` should stop normal progression and hand off to `gonna-fix`.
- `gonna-yolo` must stop on missing acceptance criteria, incomplete dependencies, unresolved architecture/environment decisions, test failure, P0/P1 defects, unrelated worktree changes, secret risk, destructive Git needs, merge needs, or deploy needs.
- Write only yolo blocker and abnormal-stop artifacts under `docs/scrum/blocker/`, not development or test reports.

## Skill Authoring Rules

- Project skills and agent instructions should be written in English.
- User-facing project documents produced by those skills should be written in Simplified Chinese.
- Avoid decorative status icons in project skills and agent instructions.
