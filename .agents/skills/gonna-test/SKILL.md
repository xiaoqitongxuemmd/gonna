---
name: gonna-test
description: Use this skill when the user asks to design, run, review, or report tests for go-zero Stories, validate implementation reports, create test plans, verify acceptance criteria, design API/RPC/integration tests, evaluate coverage, report defects, or decide whether a Story is ready to be marked completed in this ai-native go-zero microservice framework project.
version: 1.0.0
license: MIT
---

# Test Skill

This skill validates go-zero implementation work against Story acceptance criteria, source documents, API/RPC contracts, and quality gates. It produces test plans, test reports, defect reports, and completion recommendations.

It is not responsible for architecture design, Epic/Story decomposition, code implementation, or deployment execution.

## Project Role

`gonna` is an ai-native engineering framework for go-zero based microservice development.

Use this skill as the independent verification layer:

- `gonna-arch`: source documents to go-zero architecture and implementation handoff
- `gonna-plan`: architecture handoff to Epics, Stories, acceptance criteria, and KANBAN
- `gonna-dev`: Story to implementation, focused tests, validation, and implementation report
- `gonna-test`: implementation to test plan, verification evidence, defect report, and completion recommendation
- `gonna-deploy`: local Docker Compose deployment assets

## When to Use

Use this skill for:

- Designing tests from Story acceptance criteria
- Verifying a `gonna-dev` implementation report
- Creating API contract test plans from `.api` files
- Creating RPC contract test plans from `.proto` files
- Designing integration tests for go-zero services, database, cache, or RPC dependencies
- Reviewing unit test coverage and quality gates
- Running or interpreting `go test`, `go build`, API smoke tests, or integration tests
- Creating test reports
- Creating defect reports
- Recommending whether a Story can move to `COMPLETED`
- Planning regression tests after refactoring or bug fixes

If implementation has not started, produce a test plan. If implementation exists, produce validation results and a completion recommendation.

## Inputs

Prefer one of these inputs:

- Story file under `docs/scrum/story/`
- `gonna-dev` implementation report
- Changed `.api` or `.proto` files
- Source documents or design references
- Test output, build output, CI output, or defect symptoms
- Existing test files

When a Story is referenced, read it first. Extract acceptance criteria, validation plan, design references, source documents, dependencies, and expected go-zero boundaries.

## Language Policy

Produce human-facing test output in Simplified Chinese by default. This includes test plans, test reports, defect reports, completion recommendations, risk notes, validation summaries, and user-facing explanations.

Keep test names, commands, paths, status enum values, severity values, coverage metrics, API/RPC names, and raw error output in their required technical form. Skill instructions and templates may remain in English.

## Internal References

Use these project resources as internal references. The user should not need to invoke them directly.

- `.agents/skills/zero-skills/SKILL.md` for go-zero knowledge navigation
- `.agents/skills/zero-skills/references/rest-api-patterns.md` for REST API behavior and error conventions
- `.agents/skills/zero-skills/references/rpc-patterns.md` for RPC contracts and service behavior
- `.agents/skills/zero-skills/references/database-patterns.md` for database, cache, transaction, and model verification
- `.agents/skills/zero-skills/references/resilience-patterns.md` for rate limit, circuit breaker, retry, timeout, and degradation verification
- `.agents/skills/zero-skills/troubleshooting/common-issues.md` for diagnosing go-zero failures

Reference loading rule:

- For REST API tests, load REST patterns.
- For RPC tests, load RPC patterns.
- For persistence or cache tests, load database patterns.
- For resilience behavior, load resilience patterns.
- For failed tests or runtime errors, load troubleshooting.

## Test Layers

Use layered testing. Pick the smallest layer that can prove the behavior, then add higher layers when integration risk exists.

### Unit Tests

Purpose:

- Verify logic functions, branch behavior, error handling, and business rules.

Default commands:

```bash
go test ./...
go test ./... -coverprofile=coverage.out
go tool cover -func=coverage.out
```

### API Contract Tests

Purpose:

- Verify changed REST endpoints, request validation, response shape, status codes, auth behavior, and error format.

Inputs:

- `.api` files
- Story acceptance criteria
- go-zero REST conventions

### RPC Contract Tests

Purpose:

- Verify changed `.proto` contracts, request/response behavior, error behavior, and service-to-service expectations.

Inputs:

- `.proto` files
- Story acceptance criteria
- go-zero RPC conventions

### Integration Tests

Purpose:

- Verify database, cache, RPC, middleware, service context, and configuration wiring.

Use integration tests for persistence behavior instead of forcing high-value database coverage into unit tests.

### Acceptance Tests

Purpose:

- Verify the Story acceptance criteria end to end from a user or system perspective.

Acceptance criteria coverage must be complete before recommending `COMPLETED`.

## Quality Gates

Use these default gates unless the project defines stricter rules.

Required gates:

- Story acceptance criteria coverage: 100%
- Changed public API/RPC contract coverage: 100%
- `go test ./...`: pass
- `go build ./...`: pass
- No unresolved P0 or P1 defects
- Generated code is excluded from coverage gates

Coverage targets:

- Logic layer unit test coverage: at least 85%
- Critical business rule coverage: at least 90%, target 95% when practical
- Overall unit test coverage: at least 70%
- Persistence/model unit coverage: informational unless meaningful logic exists

Coverage guidance:

- Do not require 95% overall unit coverage by default.
- Do not chase coverage on generated go-zero boilerplate.
- Prefer integration tests for database, cache, and external dependency behavior.
- Prioritize meaningful assertions over line execution.

Completion recommendation:

- `Pass`: all required gates pass and no material risk remains.
- `Conditional Pass`: non-critical gaps exist, with explicit follow-up and user acceptance.
- `Fail`: required gates fail, P0/P1 defect exists, or acceptance criteria are not fully verified.

## Test Design Rules

Tests must trace back to source intent:

- Story acceptance criteria
- `.api` or `.proto` contracts
- Architecture or design documents
- Implementation report

Design tests for:

- Happy path
- Required field validation
- Optional/default behavior
- Boundary values
- Invalid inputs
- Auth and permission behavior
- Error response format
- Timeout, retry, rate limit, or circuit breaker behavior when relevant
- Idempotency for repeated calls when relevant

Do not invent requirements. If expected behavior is unclear, record an open question.

## Compatibility Test Gate

Do not add compatibility test cases by default.

Only design or require backward-compatible, forward-compatible, legacy, deprecated, versioned, alias, fallback, migration, or old-shape/new-shape tests when the user explicitly approved the compatibility behavior in the design, Story, or current conversation.

If changed contracts could need compatibility coverage but approval is missing, report an open question instead of adding compatibility expectations. The report should name:

- affected API/RPC/event/database/cache/config contract
- compatibility behavior being considered
- risk of not testing it
- required user approval before tests or gates include it

Keep default verification focused on the current accepted contract.

## Test Idempotency

Tests should be repeatable and safe.

Use:

- Unique test data names
- Test data cleanup before and after test execution
- Transactional cleanup when multiple tables are involved
- Isolated cache keys
- Idempotent setup scripts

Avoid:

- Shared mutable test data across unrelated cases
- Tests that depend on execution order
- Manual cleanup as a requirement for passing tests

## Test File Naming Rules

Name test files and test functions by the behavior, API/RPC contract, package, component, or quality attribute being verified. Do not name test code after Story, Epic, task, iteration, sprint, or temporary execution order identifiers.

Invalid test code names include:

- `story15_metrics_test.go`
- `story_15_acceptance_test.go`
- `epic3_user_api_test.go`
- `TestStory15Metrics`
- `TestTask12Cache`

Prefer durable behavior names, for example:

- `metrics_test.go`
- `observability_metrics_test.go`
- `request_metrics_test.go`
- `TestMetricsCollectorRecordsRequestDuration`
- `TestCachePolicyExpiresStaleEntries`

Story IDs may be cited in test plans, reports, defect reports, acceptance evidence, and comments that explain traceability, but they must not be the primary naming source for test files, packages, or exported test helper types. Before recommending `Pass` or `COMPLETED`, inspect changed test code and flag or fix any Story/Epic/task/iteration-based test naming.

## Regression and Refactoring Validation

For refactoring or bug-fix validation:

1. Establish a baseline when possible.
2. Run focused tests for the changed area.
3. Run broader regression checks.
4. Compare before and after behavior.
5. Attribute failures to environment, test data, or code change.

Use the same checkout or worktree for implementation and validation.

## Reports

Use these templates:

- `.agents/skills/gonna-test/templates/test_plan_template.md`
- `.agents/skills/gonna-test/templates/test_report_template.md`
- `.agents/skills/gonna-test/templates/defect_report_template.md`

When answering without writing files, provide the same sections inline.

When invoked by `gonna-yolo`, still produce the test plan, test report, defect report, or completion recommendation as a `gonna-test` artifact. `gonna-yolo` may reference this report path or result, but must not write a combined yolo document that replaces it.

## Handoff

When testing is complete:

- Update or recommend Story status based on evidence.
- If failed, hand defects back to `gonna-dev`.
- If passed and deployment is needed, hand deployment needs to `gonna-deploy`.
