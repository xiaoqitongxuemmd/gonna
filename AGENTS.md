# Project AI Instructions

This project is an ai-native engineering framework for go-zero based microservice development.

It is intended to integrate project-level skills for architecture, planning, development, testing, and deployment.

## Context Sources

- Primary architecture skill: `gonna-arch` at `.agents/skills/gonna-arch/SKILL.md`
- Planning skill: `gonna-plan` at `.agents/skills/gonna-plan/SKILL.md`
- Environment skill: `gonna-env` at `.agents/skills/gonna-env/SKILL.md`
- Development skill: `gonna-dev` at `.agents/skills/gonna-dev/SKILL.md`
- Test skill: `gonna-test` at `.agents/skills/gonna-test/SKILL.md`
- Submission skill: `gonna-submit` at `.agents/skills/gonna-submit/SKILL.md`
- go-zero workflow reference for arch: `.agents/ai-context/00-instructions.md`
- go-zero task workflow reference for arch: `.agents/ai-context/workflows.md`
- goctl command reference for arch: `.agents/ai-context/tools.md`
- go-zero pattern reference for arch: `.agents/ai-context/patterns.md`
- go-zero detailed knowledge reference for arch: `.agents/skills/zero-skills/SKILL.md`

## Default Rules

- Use `gonna-arch` as the main entry for source document analysis, architecture design, technical stack decisions, service decomposition, API/RPC/event/data contracts, scaffold planning, environment contracts, observability architecture, resilience/security design, migration planning, and implementation handoff.
- Use `gonna-plan` when the user asks to split architecture output, implementation handoff, PRDs, specifications, or design documents into Epics, Stories, acceptance criteria, dependency order, execution scope, or AI-readable backlog.
- Use `gonna-env` when the user asks to create, update, run, or verify local development/debug environments, dependency containers, Docker Compose profiles, environment variables, go-zero config mapping, health checks, or local observability with OpenTelemetry, Prometheus, Grafana, tracing, or logs.
- Use `gonna-dev` when the user asks to implement Stories, generate go-zero code, modify API/RPC/model/logic/config, fix bugs, add tests, run validation, or prepare implementation reports.
- Use `gonna-test` when the user asks to design tests, verify Story acceptance criteria, validate implementations, evaluate coverage, run or interpret test/build output, produce test reports, report defects, or decide whether a Story can be completed.
- Use `gonna-submit` when the user asks to prepare, review, stage, commit, push, or package verified changes for merge request submission; create commit plans, commit messages, merge request descriptions, or submission reports.
- Treat `.agents/ai-context/` and `.agents/skills/zero-skills/` as references that support the architecture skill.
- Do not ask the user to invoke `ai-context` or `zero-skills` directly for normal project work.
- Load the specific go-zero reference files only when the architecture task needs that level of detail.
- Treat `docs/design/` as accepted project architecture facts only; architecture document templates live under `.agents/skills/gonna-arch/templates/`.

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

## Architecture Workflow

- For architecture design, PRD analysis, design document analysis, spec document analysis, technical stack selection, service decomposition, API/RPC/event design, data model design, scaffold planning, local environment requirements, observability architecture, resilience/security design, migration planning, or implementation planning, read `gonna-arch` from `.agents/skills/gonna-arch/SKILL.md`.
- Let the architecture skill decide which go-zero workflow and knowledge references to load.
- The expected user-facing workflow is `gonna-arch` only for architecture work; `ai-context` and `zero-skills` are internal references for `gonna-arch`.

## Planning Workflow

- For Epic planning, Story decomposition, acceptance criteria, implementation phases, execution ordering, or progress tracking, read `gonna-plan` from `.agents/skills/gonna-plan/SKILL.md`.
- Prefer using `gonna-arch` output as the input to `gonna-plan`.
- Keep Epic and Story source files under `docs/scrum/prd/` and `docs/scrum/story/`.
- By default, `gonna-plan` should materialize planning output into Epic, Story, and KANBAN files unless the user explicitly asks for conversation-only planning.
- Do not assume human team scheduling fields such as Sprint length, calendar dates, assignees, or capacity unless the user explicitly asks for them.

## Environment Workflow

- For local dependencies, Docker Compose, database/cache/queue/service discovery setup, go-zero config mapping, observability stack, or environment health checks, read `gonna-env` from `.agents/skills/gonna-env/SKILL.md`.
- Prefer using `gonna-arch` environment contract and observability architecture as the input to `gonna-env`.
- Let `gonna-env` materialize local environment files and reports without making architecture technology choices on its own.

## Development Workflow

- For Story implementation, go-zero scaffold generation, API/RPC/model changes, logic implementation, bug fixes, focused tests, validation, commits, or implementation reports, read `gonna-dev` from `.agents/skills/gonna-dev/SKILL.md`.
- Prefer using `gonna-plan` Story files as the input to `gonna-dev`.
- Use `gonna-env` when local dependencies or observability are required to run or debug the implementation.
- Let `gonna-dev` decide which go-zero workflow and `zero-skills` implementation references to load.

## Test Workflow

- For test planning, API/RPC contract tests, integration tests, acceptance verification, coverage evaluation, defect reports, or completion recommendations, read `gonna-test` from `.agents/skills/gonna-test/SKILL.md`.
- Prefer using `gonna-plan` Story files and `gonna-dev` implementation reports as the input to `gonna-test`.
- Use `gonna-env` when integration or observability verification requires local dependencies.
- Let `gonna-test` decide which go-zero and `zero-skills` verification references to load.

## Submission Workflow

- For commit planning, staging review, commit creation, branch push, merge request descriptions, or submission reports, read `gonna-submit` from `.agents/skills/gonna-submit/SKILL.md`.
- Prefer using `gonna-dev` implementation reports and `gonna-test` test reports as input to `gonna-submit`.
- Keep `gonna-submit` focused on packaging verified changes; merge gate policy and CI/CD readiness belong to future `gonna-devops`.
- Do not push unless the user explicitly asks.

## Skill Authoring Rules

- Project skills and agent instructions should be written in English.
- User-facing project documents produced by those skills should be written in Simplified Chinese.
- Avoid decorative status icons in project skills and agent instructions.
