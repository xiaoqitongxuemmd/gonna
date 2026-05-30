---
name: gonna-selftest
description: Use this skill when the user asks to create, update, prepare, or verify human-executed contract selftest documents before push; generate curl, grpcurl, Kafka producer scripts, seed SQL, Redis data, cleanup assets, per-case pass checklists, and design feedback loops for this ai-native go-zero microservice framework project.
version: 1.0.0
license: MIT
---

# Selftest Skill

This skill creates the human contract acceptance layer for `gonna`. It generates selftest documents and prepares local test data so the user can manually verify request/response behavior, messages, data side effects, and design intent before push.

It does not replace `gonna-test`, unit tests, CI, or DevOps gates. It focuses on human-visible contract behavior and design-intent feedback.

## Project Role

Use this skill between `gonna-test` and push:

- `gonna-dev`: implements the Story
- `gonna-test`: verifies automated quality gates
- `gonna-selftest`: prepares human contract selftest data and documents
- `gonna-submit`: allows local commit without selftest, but blocks push until required selftests pass
- `gonna-arch`: consumes `Needs Design Update` feedback to update design documents

## When to Use

Use this skill for:

- Creating human-executable contract selftest docs for a Story or Epic
- Generating copy-paste `curl` commands for REST APIs
- Generating `grpcurl` commands or small clients for RPC contracts
- Generating Kafka producer scripts or payloads for event flows
- Generating seed SQL, Redis seed/check scripts, cleanup SQL, or sample files
- Preparing local test data before the user runs contract checks
- Recording per-case human pass/fail/design-feedback results
- Checking whether selftest completion is sufficient for push

Do not use this skill for ordinary unit test design or coverage evaluation; use `gonna-test` for that.

## Language Policy

Produce human-facing selftest output in Simplified Chinese by default. Keep commands, paths, env vars, JSON fields, SQL, Kafka topic names, status values, Story IDs, and raw responses in their required technical form.

## Data Preparation Responsibility

The assistant prepares test data whenever possible. Do not make the user manually design data setup.

For each selftest case:

- Generate deterministic seed assets under `docs/selftest/assets/{story-id}/`.
- Generate cleanup assets when data mutation is involved.
- Execute preparation commands when the local environment is available and the user has allowed command execution.
- Mark data preparation status in the selftest document.
- If automatic preparation cannot run, provide one copy-paste command and record the blocker reason.

Data must be safe, repeatable, isolated, and clearly named. Do not use real secrets or production data.

## Selftest Artifacts

Write documents under `docs/selftest/`.

Recommended paths:

- `docs/selftest/{story-id}-selftest.md`
- `docs/selftest/{epic-id}-selftest.md`
- `docs/selftest/assets/{story-id}/seed.sql`
- `docs/selftest/assets/{story-id}/cleanup.sql`
- `docs/selftest/assets/{story-id}/seed_redis.py`
- `docs/selftest/assets/{story-id}/produce_kafka_event.py`
- `docs/selftest/assets/{story-id}/check_redis.py`

Use these templates:

- `.agents/skills/gonna-selftest/templates/selftest_plan_template.md`
- `.agents/skills/gonna-selftest/templates/selftest_case_template.md`
- `.agents/skills/gonna-selftest/templates/selftest_report_template.md`
- `.agents/skills/gonna-selftest/templates/selftest_feedback_template.md`

## Case Requirements

Each required case must include:

- Purpose and design intent
- Contract under test: API, RPC, event, DB side effect, Redis side effect, scheduled job, or webhook
- Data preparation status
- Generated data assets
- Copy-paste execution command
- Expected request or event payload
- Expected response or observable result
- Side-effect checks
- Human acceptance checklist
- Result field: `Pass | Fail | Needs Design Update | Not Run`
- Feedback fields for actual response, actual side effects, design deviation, and suggested adjustment

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

Push is allowed only when all required cases are marked `Pass`.

If any required case is `Fail`, block push and hand back to `gonna-dev` or `gonna-test`.

If any required case is `Needs Design Update`, block push and hand back to `gonna-arch` to update design documents before planning, development, testing, and selftest are repeated.

Optional cases may be `Not Run` only when the reason is recorded.

## Completion Check

Before reporting selftest as complete, verify:

- Required selftest document exists.
- Required cases are listed.
- Data preparation status is `Prepared` or an explicitly accepted fallback is recorded.
- Every required case has human acceptance checkboxes completed.
- Every required case result is `Pass`.
- Feedback sections are empty or non-blocking.
- Cleanup instructions exist when data mutation occurred.

## Handoff

At the end, report:

- Selftest document path
- Generated asset paths
- Data preparation status
- Required case results
- Push gate result: `Allowed | Blocked`
- Feedback that should go to `gonna-arch`, `gonna-dev`, or `gonna-test`
