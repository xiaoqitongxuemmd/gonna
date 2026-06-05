---
name: gonna-selftest
description: Use this skill when the user asks to create, update, prepare, or verify human-executed contract selftest documents before push; inspect local unpushed changes and produce HTTP, RPC, Kafka, database, Redis, job, or webhook input/output checklists with executable curl/grpcurl/shell probes, prepared data assets, expected/unexpected checkboxes, and design feedback loops for this ai-native go-zero microservice framework project.
version: 1.0.0
license: MIT
---

# Selftest Skill

This skill creates the human contract acceptance layer for `gonna`. It inspects local unpushed changes, extracts changed externally visible contracts, generates a human-readable input/output checklist, and prepares local test data so the user can manually verify request/response behavior, messages, data side effects, and design intent before push.

It does not replace `gonna-test`, unit tests, build checks, CI, or DevOps gates. It must not produce a generic "run all tests" script or focus on whether the project builds. It focuses on human-visible contract behavior and design-intent feedback.

The output must be a human review document first, not an automation runner. Scripts are allowed only as supporting assets for data preparation, cleanup, observation, or one specific Kafka/RPC probe. Do not replace the selftest document with a shell script that calls many HTTP APIs and asserts results automatically.

## Project Role

Use this skill between `gonna-test` and push:

- `gonna-dev`: implements the Story
- `gonna-test`: verifies automated quality gates
- `gonna-selftest`: prepares human contract selftest data and documents
- `gonna-submit`: keeps selftest artifacts separate from implementation commits, allows local implementation commits without completed selftest, and blocks push until required selftests pass
- `gonna-arch`: consumes design-intent feedback from `不符合预期` cases to update design documents

## When to Use

Use this skill for:

- Creating human-executable contract selftest docs for a Story or Epic
- Creating selftest docs from local unpushed changes before push
- Listing changed HTTP APIs with endpoint, request, response, and copy-paste `curl`
- Generating copy-paste `curl` commands for REST APIs
- Generating `grpcurl` commands or small clients for RPC contracts
- Listing changed Kafka producers/consumers with topic, message fields, expected behavior, and a shell probe to send or observe messages
- Generating seed SQL, Redis seed/check scripts, cleanup SQL, or sample files
- Preparing local test data before the user runs contract checks
- Recording per-case human `符合预期` or `不符合预期` design-feedback results
- Checking whether selftest completion is sufficient for push

Do not use this skill for ordinary unit test design, coverage evaluation, build verification, or CI-style validation; use `gonna-test` for that.

## Language Policy

Produce human-facing selftest output in Simplified Chinese by default. Keep commands, paths, env vars, JSON fields, SQL, Kafka topic names, status values, Story IDs, and raw responses in their required technical form.

## Data Preparation Responsibility

The assistant prepares test data whenever possible. Do not make the user manually design data setup.

For each changed contract:

- Generate deterministic seed assets under `docs/scrum/selftest/assets/{story-id}/`.
- Generate cleanup assets when data mutation is involved.
- Execute preparation commands when the local environment is available and the user has allowed command execution.
- Mark data preparation status in the selftest document.
- If automatic preparation cannot run, provide one copy-paste command and record the blocker reason.

Data must be safe, repeatable, isolated, and clearly named. Do not use real secrets or production data.

Do not require the user to prepare data. The user validates behavior; the assistant prepares or provides one-command preparation assets.

## Local Change Detection

When preparing push-gate selftest, inspect local unpushed changes first:

- Determine the current branch and upstream or push target.
- Use Git evidence such as `git status --short`, `git diff --stat`, and relevant diffs.
- Identify changed `.api`, `.proto`, handler/logic, Kafka producer/consumer, SQL/model, Redis/cache, job, and webhook files.
- Produce selftest items only for changed externally visible contracts and their required side effects.
- If no contract-visible behavior changed, state that no required selftest cases are needed for push.

Do not include generic build, `go test`, lint, coverage, or generated-code-only checks in the selftest document.

## Compatibility Selftest Gate

Do not generate compatibility selftest cases by default.

Selftest cases must verify the current accepted contract. Do not add old-version, new-version, deprecated, alias, fallback, reserved-field, optional-future-field, migration, dual-read/write, or legacy payload cases unless the user explicitly approved that compatibility behavior.

If local changes suggest compatibility might matter but approval is missing, record an open question in the selftest document instead of generating compatibility cases or compatibility data.

Do not add compatibility fields to example HTTP requests, RPC payloads, Kafka messages, SQL seed data, Redis seed data, or expected responses unless approved.

## HTTP Contract Rules

For HTTP contracts, be strict:

- Generate at least one independent selftest case for every changed HTTP endpoint.
- Generate at least one executable `curl` command inside each HTTP case.
- Do not merge multiple HTTP endpoints into a single shell script, helper function, or "happy path" runner.
- Do not hide requests behind shell functions such as `post()` or a loop when the user needs to inspect each API.
- If one endpoint has multiple required acceptance scenarios, generate one case and one `curl` per scenario.
- A data-preparation command may call APIs only when it is explicitly labeled as setup and is not counted as the human acceptance command.
- The human acceptance command for an HTTP case must be directly copy-pasteable as a standalone `curl`.

Each HTTP case must show:

- Method and URL
- Path, query, and header parameters
- Request JSON or body
- Expected HTTP status
- Expected response JSON or response field table
- Optional DB/Redis/Kafka/log observation command when the endpoint has side effects
- Human result options: `符合预期` and `不符合预期`

## Script Boundaries

Allowed generated scripts:

- Data setup scripts such as `prepare_data.sh`, `seed.sql`, or `seed_redis.py`
- Cleanup scripts such as `cleanup.sql` or `cleanup_data.sh`
- One-contract Kafka probes such as `kafka_probe.sh`
- Observation helpers such as `check_redis.py`

Forbidden generated scripts:

- A single shell script that runs all HTTP APIs for the user
- A script that validates HTTP responses and prints a global success result instead of giving per-API human checkboxes
- A script that combines data preparation, API execution, assertions, and final pass/fail into one opaque workflow

## Selftest Artifacts

Write documents under `docs/scrum/selftest/`.

Recommended paths:

- `docs/scrum/selftest/{story-id}-selftest.md`
- `docs/scrum/selftest/{epic-id}-selftest.md`
- `docs/scrum/selftest/assets/{story-id}/seed.sql`
- `docs/scrum/selftest/assets/{story-id}/cleanup.sql`
- `docs/scrum/selftest/assets/{story-id}/seed_redis.py`
- `docs/scrum/selftest/assets/{story-id}/kafka_probe.sh`
- `docs/scrum/selftest/assets/{story-id}/check_redis.py`

Use these templates:

- `.agents/skills/gonna-selftest/templates/selftest_plan_template.md`
- `.agents/skills/gonna-selftest/templates/selftest_case_template.md`
- `.agents/skills/gonna-selftest/templates/selftest_report_template.md`
- `.agents/skills/gonna-selftest/templates/selftest_feedback_template.md`

## Case Requirements

Each required case must include:

- Contract summary: HTTP endpoint, RPC method, Kafka topic, DB/Redis side effect, scheduled job, or webhook
- Input shape: request body, RPC message, Kafka message fields, or trigger parameters
- Expected output shape: response body, consumed message result, DB/Redis visible state, log/observable result, or callback behavior
- Data preparation status
- Generated data assets
- Copy-paste execution command such as `curl`, `grpcurl`, or a per-contract shell probe
- Side-effect checks
- Human result options only:
  - `[ ] 符合预期`
  - `[ ] 不符合预期`
- Feedback area under `不符合预期`

Avoid multi-step checklist noise. Each case should be easy for the user to execute, observe, check pass/fail, and write feedback.

## Push Gate Semantics

Selftest is not required for local commit.

Selftest is required before push when a change affects:

- REST API contracts
- RPC contracts
- Event producers or consumers
- Database-visible behavior
- Redis/cache-visible behavior
- Scheduled jobs
- Webhooks or external callbacks
- User-visible business behavior

Push is allowed only when every required case is checked `符合预期` and no required case is checked `不符合预期` or left unchecked.

If any required case is marked `不符合预期`, block push. Use the feedback text to decide whether to hand back to `gonna-arch`, `gonna-dev`, or `gonna-test`.

If the feedback describes a design-intent mismatch or contract wording issue, hand back to `gonna-arch` to update design documents before planning, development, testing, and selftest are repeated.

Optional cases may remain unchecked only when they are clearly marked optional and the reason is recorded.

## Submission Separation

Selftest documents and generated assets are not implementation changes.

Rules:

- Generate or update selftest artifacts after implementation and automated test verification, but do not include them in the implementation commit.
- Leave selftest artifacts uncommitted while the user is still executing them or while any required case is marked `不符合预期`.
- When all required cases are marked `符合预期`, commit selftest documents and assets as a dedicated selftest evidence commit.
- If feedback triggers another yolo repair pass, update selftest artifacts after the repair, but keep them separate from the repair implementation commit.
- Selftest feedback files may be referenced by `gonna-plan` when creating intent-alignment fix Epics and Stories.

## Completion Check

Before reporting selftest as complete, verify:

- Required selftest document exists.
- Required cases are listed.
- Data preparation status is `Prepared` or an explicitly accepted fallback is recorded.
- Every required case has exactly one human result selected.
- Every required case is marked `符合预期`.
- No required case is marked `不符合预期`.
- Cleanup instructions exist when data mutation occurred.

## Handoff

At the end, report:

- Selftest document path
- Generated asset paths
- Data preparation status
- Required case results
- Push gate result: `Allowed | Blocked`
- Feedback that should go to `gonna-arch`, `gonna-dev`, or `gonna-test`
