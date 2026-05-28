---
name: gonna-dev
description: Use this skill when the user asks to implement a Story, build or modify go-zero services, generate API/RPC/model code with goctl, write business logic, add middleware, wire ServiceContext dependencies, fix bugs, add tests, run validation, prepare commits, or produce implementation reports for this ai-native go-zero microservice framework project.
version: 1.0.0
license: MIT
---

# Development Skill

This skill turns planned Stories into go-zero implementation work. It is responsible for code generation, manual implementation, focused tests, local validation, and commit-ready change summaries.

It is not responsible for architecture design, Epic/Story decomposition, independent QA sign-off, or deployment execution.

## Project Role

`gonna` is an ai-native engineering framework for go-zero based microservice development.

Use this skill as the implementation layer:

- `gonna-arch`: source documents to go-zero architecture and implementation handoff
- `gonna-plan`: architecture handoff to Epics, Stories, acceptance criteria, and KANBAN
- `gonna-dev`: Story to go-zero code, tests, validation, and implementation report
- `gonna-test`: verification plans and independent test evidence
- future `deploy`: release and deployment execution

## When to Use

Use this skill for:

- Implementing a Story from `docs/scrum/story/`
- Creating or updating `.api` files
- Creating or updating `.proto` files
- Running `goctl` code generation
- Implementing go-zero `internal/logic`
- Wiring dependencies in `internal/svc/service_context.go`
- Adding config under `etc/*.yaml`
- Generating or using database models
- Adding middleware, auth, rate limits, circuit breakers, or resilience behavior
- Fixing bugs in go-zero services
- Adding focused unit tests or integration-ready validation
- Running `go fmt`, `go test`, `go build`, and related checks
- Preparing commit messages, PR descriptions, or implementation reports

If the work is not tied to a Story, proceed only when the user explicitly asks for direct implementation, urgent bug fixing, scaffolding, or exploratory investigation.

## Inputs

Prefer one of these inputs:

- A Story file under `docs/scrum/story/`
- A Story ID, such as `STORY-1-01`
- A `gonna-plan` breakdown
- A `gonna-arch` go-zero implementation handoff
- A direct user implementation request
- Existing code and failing validation output

When a Story is referenced, read it before editing code. Extract acceptance criteria, dependencies, design references, source documents, implementation notes, and validation plan.

## Language Policy

Produce human-facing development output in Simplified Chinese by default. This includes implementation reports, PR descriptions, validation summaries, code change summaries, known gaps, follow-up notes, and user-facing explanations.

Keep code identifiers, paths, commands, commit message subjects, package names, API/RPC names, config keys, and generated code comments in their required technical form. Skill instructions and templates may remain in English.

## Internal References

Use these project resources as internal references. The user should not need to invoke them directly.

Always read the workflow reference before generating or modifying go-zero code:

- `.agents/ai-context/00-instructions.md`

Read these references when the task needs specific detail:

- `.agents/ai-context/workflows.md` for task sequencing
- `.agents/ai-context/tools.md` for goctl command usage
- `.agents/ai-context/patterns.md` for concise go-zero coding patterns
- `.agents/skills/zero-skills/SKILL.md` for go-zero knowledge navigation
- `.agents/skills/zero-skills/references/goctl-commands.md` for exact generation commands
- `.agents/skills/zero-skills/references/rest-api-patterns.md` for REST handlers, logic, middleware, errors, and API workflows
- `.agents/skills/zero-skills/references/rpc-patterns.md` for RPC services, clients, service discovery, and proto workflows
- `.agents/skills/zero-skills/references/database-patterns.md` for SQL, MongoDB, Redis, models, transactions, and caching
- `.agents/skills/zero-skills/references/resilience-patterns.md` for timeout, retry, rate limiting, circuit breaker, and degradation patterns
- `.agents/skills/zero-skills/troubleshooting/common-issues.md` for debugging go-zero issues

Reference loading rule:

- For API implementation, load REST patterns and goctl commands.
- For RPC implementation, load RPC patterns and goctl commands.
- For persistence, load database patterns.
- For resilience or production hardening, load resilience patterns.
- For errors, build failures, generation issues, or runtime issues, load troubleshooting.

## Story Readiness

Before implementing a Story, check:

- Story ID and file path are clear
- Acceptance criteria exist
- Source documents or design references are listed when available
- Dependencies are not blocking the work
- go-zero generated boundaries are clear
- Manual implementation boundaries are clear
- Validation steps are clear

If readiness is weak but the user explicitly asks to proceed, state assumptions and continue with the smallest safe implementation.

## go-zero Implementation Workflow

Use this workflow for feature work:

1. Read the Story and referenced design material.
2. Load the needed go-zero internal references.
3. Inspect the existing repository structure and patterns.
4. Decide generated boundaries before manual implementation.
5. Create or update `.api` or `.proto` specs first.
6. Run the appropriate `goctl` command when generation is needed.
7. Implement business logic under generated `internal/logic`.
8. Wire dependencies through `internal/svc/service_context.go`.
9. Add or update config under `etc/*.yaml`.
10. Add models or persistence code using go-zero model patterns.
11. Add focused tests for changed logic.
12. Run formatting, tests, and build checks.
13. Produce an implementation report.

Prefer existing project patterns over new abstractions. Do not hand-write generated boilerplate when `goctl` should own it.

## Code Generation Rules

Use `goctl` for generated go-zero boilerplate.

Common generation flow:

```bash
goctl api go -api api/{service}.api -dir services/{service}-api --style go_zero
goctl rpc protoc rpc/{service}/{service}.proto --go_out=. --go-grpc_out=. --zrpc_out=services/{service}-rpc
go mod tidy
go build ./...
```

Adjust paths to the repository layout and Story requirements.

After generation:

- Do not edit generated routing or server bootstrap unless the framework requires it.
- Put business behavior in `internal/logic`.
- Put dependency wiring in `internal/svc`.
- Keep request and response contracts in `.api` or `.proto`.
- Re-run generation when specs change.

## Manual Implementation Rules

Follow go-zero layering:

- Handler: parse request and call logic
- Logic: business rules and orchestration
- Model: persistence operations
- ServiceContext: dependency injection
- Config: runtime settings

Do not put business logic directly in handlers.

Use `context.Context` through service and persistence calls.

Use go-zero helpers for HTTP responses and errors when applicable.

Keep implementation scoped to the Story unless a shared change is required for correctness.

## Testing and Validation

Prefer project-defined commands when present, such as Makefile targets.

Default Go validation:

```bash
go fmt ./...
go test ./...
go build ./...
```

Use focused package tests while iterating, then run broader validation before finishing.

When validation cannot run, explain why and list the residual risk.

## Git and Commit Rules

Do not push unless the user explicitly asks.

Do not rewrite or revert unrelated user changes.

Use Story-aware commit messages when committing:

```text
feat(story-1-01): implement user API scaffold
```

Use the template:

- `.agents/skills/gonna-dev/templates/commit_message_template.md`

## Implementation Report

At the end of implementation, report:

- Story or request handled
- Files changed
- Generated code
- Manual implementation
- Tests and validation run
- Known gaps or follow-up work

Use the template:

- `.agents/skills/gonna-dev/templates/implementation_report_template.md`

## PR Description

When the user asks for a PR or review-ready summary, use:

- `.agents/skills/gonna-dev/templates/pr_description_template.md`

Keep the PR description grounded in actual changes and validation output.

## Handoff to Test and Deploy

When implementation is complete:

- Hand off validation needs to `.agents/skills/gonna-test/SKILL.md`.
- Hand off release needs to future `deploy` skill.
- Until those skills exist, include validation and deployment notes in the implementation report.
