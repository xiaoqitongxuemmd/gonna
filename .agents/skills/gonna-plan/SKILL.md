---
name: gonna-plan
description: Use this skill when the user asks to split architecture output, PRDs, specifications, design documents, or go-zero implementation handoffs into AI-executable Epics, Stories, acceptance criteria, dependency order, KANBAN, or progress tracking artifacts for this ai-native go-zero microservice framework project.
version: 1.0.0
license: MIT
---

# Planning Skill

This skill turns architecture and design intent into AI-executable work items. It is responsible for Epic and Story decomposition, acceptance criteria, dependency order, handoff notes, readiness for `gonna-dev` and `gonna-test`, and progress tracking. It is not responsible for architecture design, code implementation, testing execution, submission, DevOps gates, or deployment execution.

## Project Role

`gonna` is an ai-native engineering framework for go-zero based microservice development. It is expected to integrate skills for architecture, planning, environment setup, development, testing, submission, DevOps gates, and deployment.

Use this skill as the planning layer:

- `gonna-arch`: source documents and design intent to go-zero architecture and implementation handoff
- `gonna-plan`: architecture handoff to Epics, Stories, acceptance criteria, dependency order, and AI-readable execution backlog
- `gonna-env`: environment requirements to local dependency setup
- `gonna-dev`: Stories to implementation tasks and code changes
- `gonna-test`: Stories to verification plans and test evidence
- `gonna-submit`: verified changes to commit and merge request packaging
- future `gonna-devops`: submitted changes to merge gates and CI/CD readiness

## When to Use

Use this skill for:

- Splitting a go-zero implementation handoff into Epics and Stories
- Creating or updating `docs/scrum/prd/epic-*.md`
- Creating or updating `docs/scrum/story/story-*.md`
- Writing acceptance criteria for implementation Stories
- Planning implementation phases and dependency order
- Producing a progress KANBAN from Epic and Story status
- Reviewing Story readiness before development
- Tracking Story state from TODO to COMPLETED
- Producing a backlog from PRD, specification, technical design, or `specx`-authored documents
- Creating or updating an intent-alignment fix Epic when human selftest feedback shows the implementation or design does not match the user's intent
- Adding repeated selftest-feedback fix attempts as additional Stories under the same intent-alignment Epic

If the source document has not yet been mapped to go-zero architecture, use `.agents/skills/gonna-arch/SKILL.md` first. If the user explicitly asks to split the source document directly, perform a lightweight architecture extraction before writing planning items.

This skill is not a traditional human team scheduling tool. Do not assume Sprint length, calendar dates, assignees, team capacity, or human delivery commitments unless the user explicitly asks for them. Prefer dependency order, execution sequence, acceptance criteria, and handoff evidence that `gonna-dev`, `gonna-test`, `gonna-submit`, and future `gonna-devops` can consume.

## Selftest Feedback Planning

When `gonna-selftest` feedback contains any required case marked `不符合预期`, treat it as an intent-alignment planning input, not as ordinary QA noise.

Use this workflow:

1. Classify the feedback:
   - Design intent mismatch: architecture or contract needs clarification.
   - Implementation mismatch: code differs from accepted design.
   - Test gap: automated tests did not cover the intended behavior.
   - Selftest document issue: the selftest case itself is unclear or wrong.
2. If design intent, contract wording, or acceptance criteria must change, route to `gonna-arch` first and use its updated design as planning input.
3. Create one intent-alignment fix Epic for the affected feature or original Epic when no suitable fix Epic exists.
4. If a suitable intent-alignment fix Epic already exists, add new Stories under that Epic instead of creating another fix Epic.
5. Each repeated selftest failure or correction pass should become a new Story under the same fix Epic, with references to the selftest feedback and affected contracts.
6. Keep the fix Epic focused on reaching the user's confirmed intent. Do not mix unrelated feature expansion into it.

Recommended naming:

```text
EPIC-{number}: {feature} 意图对齐修复
STORY-{number}-01: 修复 {contract/behavior} 与自测反馈的偏差
```

Recommended metadata:

- Add tags such as `selftest-feedback`, `intent-alignment`, and the affected original Epic ID.
- Add `source_docs` references to the selftest document and feedback file.
- Add `design_refs` references to updated design documents when `gonna-arch` changed them.
- Set dependencies on the original Epic or Story that introduced the behavior.

## Inputs

Prefer one of these inputs:

- `gonna-arch` Architecture Analysis
- `gonna-arch` go-zero Scaffold Plan
- `gonna-arch` go-zero Implementation Handoff
- PRD or product requirements
- Technical design or architecture document
- API or data model draft
- Existing Epic or Story files

When input is incomplete, state assumptions and open questions rather than inventing hidden requirements.

## Language Policy

Produce human-facing planning output in Simplified Chinese by default. This includes planning breakdowns, Epic files, Story files, execution plans, KANBAN views, progress summaries, acceptance criteria, risks, and open questions.

Keep Story IDs, Epic IDs, status enum values, priority values, tags, file paths, code identifiers, commands, and YAML metadata keys in their required technical form. Skill instructions and templates may remain in English.

## Internal go-zero References

When splitting go-zero implementation work, use these references as needed so Stories align with real engineering boundaries:

- `.agents/skills/zero-skills/SKILL.md` for go-zero knowledge navigation
- `.agents/skills/zero-skills/references/goctl-commands.md` for generation boundaries
- `.agents/skills/zero-skills/references/rest-api-patterns.md` for REST API Stories
- `.agents/skills/zero-skills/references/rpc-patterns.md` for RPC Stories
- `.agents/skills/zero-skills/references/database-patterns.md` for model, cache, and persistence Stories
- `.agents/skills/zero-skills/references/resilience-patterns.md` for rate limit, circuit breaker, timeout, retry, and degradation Stories

The user should not need to invoke `zero-skills` directly.

## Output Modes

Choose the smallest useful mode.

### 1. Planning Breakdown

Use for quick conversation, early shaping, or when the user explicitly asks not to write files.

Produce:

- Epic list
- Story list under each Epic
- Acceptance criteria per Story
- Dependencies and sequencing
- Suggested priority
- Complexity size
- Risks and open questions
- Proposed file paths when files are not written

### 2. Versioned Work Items

Use by default when the user asks to decompose, split, plan, or generate work from architecture/source documents and does not explicitly say "only discuss", "do not write files", or equivalent.

Create or update:

- `docs/scrum/prd/epic-{epic_number}-{short-name}.md`
- `docs/scrum/story/story-{epic_number}-{story_number}-{short-name}.md`

Use the templates in:

- `.agents/skills/gonna-plan/templates/epic_template.md`
- `.agents/skills/gonna-plan/templates/story_template.md`

Also create or update `docs/scrum/KANBAN.md` from the resulting Story files unless the user asks not to.

### 3. Execution Plan

Use when the user asks for implementation order, phased delivery, or "what should dev/test do next".

Produce or update planning sections/files with:

- Execution goal
- Selected Stories
- Excluded Stories
- Dependencies and blockers
- Execution order
- Ready-for-dev conditions
- Ready-for-test conditions
- Definition of done
- Validation plan

### 4. Progress KANBAN

Use when the user asks for project progress, work status, or a KANBAN board.

Produce or update:

- `docs/scrum/KANBAN.md`

Use the template in:

- `.agents/skills/gonna-plan/templates/kanban_template.md`

The KANBAN must be derived from Epic and Story source files. Do not invent status data. If source files do not exist yet, produce a proposed KANBAN from the current breakdown and mark it as proposed.

## Single Source of Truth

For planning and progress tracking, source files are authoritative:

- Epic source files: `docs/scrum/prd/epic-*.md`
- Story source files: `docs/scrum/story/story-*.md`

Derived views such as `docs/scrum/KANBAN.md`, `docs/scrum/DASHBOARD.md`, or `docs/scrum/metadata.json` are optional. Do not treat derived views as authoritative when they conflict with Epic or Story files.

If derived views exist, update source files first, then regenerate or update views.

## KANBAN Rules

KANBAN columns use the same Story status values:

- `TODO`
- `IN_PROGRESS`
- `IN_REVIEW`
- `TESTING`
- `BLOCKED`
- `COMPLETED`
- `CANCELLED`

When generating a KANBAN:

1. Read Story files from `docs/scrum/story/`.
2. Group Stories by `status`.
3. Sort by priority, then Epic number, then Story number.
4. Include Story ID, title, priority, complexity size, layer, and blockers when present.
5. Include a short summary with total Stories, completed Stories, blocked Stories, and completion rate.
6. If Epic files exist, include Epic progress based on their Stories.

If no Story files exist, produce a proposed KANBAN using the current planning breakdown and state that it is not yet source-backed.

## Epic Rules

Epic IDs use:

```text
EPIC-{number}
```

Epic files use:

```text
docs/scrum/prd/epic-{number}-{short-name}.md
```

Required Epic metadata:

```yaml
---
id: "EPIC-{number}"
title: "{title}"
description: "{short description}"
status: "TODO"
priority: "P1"
layer: "APP_LAYER"
owner: ""
execution_order: 0
stories: []
dependencies: []
tags: []
source_docs: []
created_at: "YYYY-MM-DD"
updated_at: "YYYY-MM-DD"
---
```

Allowed `status` values:

- `TODO`
- `IN_PROGRESS`
- `IN_REVIEW`
- `TESTING`
- `COMPLETED`
- `BLOCKED`
- `CANCELLED`

Allowed `priority` values:

- `P0`: urgent or blocking
- `P1`: high priority
- `P2`: normal priority
- `P3`: low priority

Recommended `layer` values:

- `INFRA`
- `DATA_LAYER`
- `SERVICE_LAYER`
- `APP_LAYER`
- `CROSS_LAYER`
- `AI_NATIVE`
- `DEVEX`
- `DEPLOYMENT`
- `TESTING`

## Story Rules

Story IDs use:

```text
STORY-{epic_number}-{story_number}
```

Story numbers are two digits and scoped to the Epic:

```text
STORY-1-01
STORY-1-02
STORY-2-01
```

Story files use:

```text
docs/scrum/story/story-{epic_number}-{story_number}-{short-name}.md
```

Required Story metadata:

```yaml
---
id: "STORY-{epic_number}-{story_number}"
epic_id: "EPIC-{epic_number}"
title: "{title}"
description: "{short description}"
status: "TODO"
priority: "P1"
complexity: "M"
execution_order: 0
dependencies: []
blocked_by: []
tags: []
source_docs: []
design_refs: []
dev_handoff: []
test_handoff: []
created_at: "YYYY-MM-DD"
updated_at: "YYYY-MM-DD"
---
```

Every Story must include:

- User value or engineering value
- Scope
- Acceptance criteria
- Implementation notes
- Validation plan
- Dependencies
- Execution order
- Handoff notes for `gonna-dev`
- Handoff notes for `gonna-test`
- Risks
- Source document references

## Decomposition Rules

Use INVEST as a guide:

- Independent enough to implement without hidden cross-team coupling
- Negotiable where details can be refined during implementation
- Valuable to the project, developer workflow, or system capability
- Estimable with visible scope
- Small enough for one focused implementation unit when possible
- Testable with clear acceptance criteria

For go-zero work, prefer Stories around concrete generated or hand-written boundaries:

- API spec creation or update
- RPC proto creation or update
- Model generation and persistence wiring
- ServiceContext dependency injection
- Logic implementation
- Middleware and auth integration
- Config and bootstrap wiring
- Tests and validation
- Deployment or local development setup
- Documentation and usage examples

Avoid Stories that mix too many layers unless the user asks for a thin vertical slice.

## Numbering Workflow

Before creating a new Story:

1. Identify the target Epic.
2. Inspect existing `docs/scrum/story/story-{epic_number}-*.md` files.
3. Use the next available two-digit Story number.
4. Keep filename, metadata `id`, title, and Epic `stories` list consistent.

Before creating a new Epic:

1. Inspect existing `docs/scrum/prd/epic-*.md` files.
2. Use the next available Epic number unless the user requests a specific number.
3. Keep filename and metadata `id` consistent.

If numbering conflicts exist, report them before creating new work items.

## Status Workflow

Use this status flow:

```text
TODO -> IN_PROGRESS -> IN_REVIEW -> TESTING -> COMPLETED
```

Any active Story can move to:

```text
BLOCKED
```

Cancelled work moves to:

```text
CANCELLED
```

Only mark a Story `COMPLETED` when acceptance criteria are satisfied and validation evidence exists. Evidence can include local build output, test output, review notes, or explicit user confirmation.

Do not require production access or production database checks by default. If production evidence is necessary, ask for explicit approval and scope first.

## Readiness Checklist

A Story is ready for development when:

- It has an Epic
- It has acceptance criteria
- It has source document or design references
- Dependencies are listed
- Scope is small enough to implement
- Validation steps are clear
- go-zero generation and manual implementation boundaries are clear
- `dev_handoff` is specific enough for `gonna-dev`
- `test_handoff` is specific enough for `gonna-test`

## Epic and Story Breakdown Format

When answering without writing files, use this format. By default, prefer writing the corresponding files unless the user explicitly asks for conversation-only planning.

```markdown
## Planning Breakdown

### Epics

| Epic | Priority | Layer | Goal |
| --- | --- | --- | --- |
| EPIC-1 | P1 | APP_LAYER | Create user API service |

### Stories

| Story | Epic | Priority | Complexity | Order | Goal |
| --- | --- | --- | --- | --- | --- |
| STORY-1-01 | EPIC-1 | P1 | M | 10 | Define user API spec |

### Dependencies

- STORY-1-01 before STORY-1-02

### Open Questions

- Question 1
```

## KANBAN Format

When answering without writing files, use this format:

```markdown
## Progress KANBAN

Source: docs/scrum/story/
Generated: YYYY-MM-DD

### Summary

| Metric | Value |
| --- | --- |
| Total Stories | 0 |
| Completed | 0 |
| Blocked | 0 |
| Completion Rate | 0% |

### TODO

| Story | Priority | Complexity | Layer | Blockers | Title |
| --- | --- | --- | --- | --- | --- |

### IN_PROGRESS

| Story | Priority | Complexity | Layer | Blockers | Title |
| --- | --- | --- | --- | --- | --- |

### IN_REVIEW

| Story | Priority | Complexity | Layer | Blockers | Title |
| --- | --- | --- | --- | --- | --- |

### TESTING

| Story | Priority | Complexity | Layer | Blockers | Title |
| --- | --- | --- | --- | --- | --- |

### BLOCKED

| Story | Priority | Complexity | Layer | Blockers | Title |
| --- | --- | --- | --- | --- | --- |

### COMPLETED

| Story | Priority | Complexity | Layer | Blockers | Title |
| --- | --- | --- | --- | --- | --- |
```

## Handoff to Downstream Skills

When Epic and Story files are ready:

- Development work should use `.agents/skills/gonna-dev/SKILL.md`.
- Test planning and evidence should use `.agents/skills/gonna-test/SKILL.md`.
- Submission packaging should use `.agents/skills/gonna-submit/SKILL.md`.
- Merge gates and CI/CD readiness should use future `gonna-devops` skill instructions.
