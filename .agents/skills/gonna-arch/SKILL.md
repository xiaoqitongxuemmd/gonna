---
name: gonna-arch
description: Use this skill as the primary architecture authority when the user asks to analyze a PRD, specification, technical design, architecture document, or any source document; define technical stack; design system architecture; decompose services; design API/RPC/event/data contracts; plan go-zero scaffold; define deployment/environment and observability contracts; design security, resilience, migration, or evolution strategy; or turn documented intent into implementation-ready go-zero architecture.
version: 1.0.0
license: MIT
---

# Architecture Skill

This skill is the architecture source-of-truth producer and maintainer for `gonna`. It turns source documents into go-zero architecture, technical stack decisions, scaffold plans, environment contracts, observability contracts, and implementation-ready handoffs. Source documents can include PRDs, specifications, technical designs, architecture notes, API drafts, data model drafts, or documents produced by tools such as `specx`. It uses `ai-context` and `zero-skills` as internal references so the user can work through this single skill.

The maintained, versioned design documents under `docs/design/` are the project-wide architecture source of truth. Temporary notes, reference documents, exploratory drafts, screenshots, chat summaries, and unversioned files are inputs only; they do not become accepted architecture facts until their decisions are promoted into the appropriate versioned design document.

## When to Use

Use this skill for:

- Analyzing PRDs, specifications, technical designs, and architecture documents
- Interpreting source documents placed in this project, including documents authored with `specx`
- Reviewing or improving an existing design document
- Creating system, service, API, or data-layer architecture documents
- Decomposing requirements into go-zero services, APIs, RPCs, models, and tasks
- Defining the technical stack and scaffold architecture
- Defining deployment/environment, runtime dependency, and observability contracts
- Designing API, RPC, event, data, security, resilience, and migration architecture
- Planning the go-zero project scaffold and code generation flow
- Making technical decisions and recording architecture rationale
- Managing design document versions and archives

Do not use the full document governance workflow for quick notes, throwaway analysis, or exploratory conversation. In those cases, produce a concise architecture summary and ask whether it should be promoted to a versioned design document.

## Source Document Intake

When the user provides or points to a source document, first identify what kind of input it is:

- PRD or product requirement
- Functional specification
- Technical design
- Architecture design
- API contract draft
- Data model draft
- Mixed or incomplete notes
- `specx`-authored document
- Temporary or reference material

Then extract:

- Business capabilities
- Actors and external systems
- Service boundaries
- API and RPC contracts
- Data ownership and persistence needs
- Async jobs, events, queues, or scheduled tasks
- Authentication, authorization, and tenancy rules
- Configuration and infrastructure dependencies
- Non-functional requirements such as latency, availability, observability, and security
- Ambiguities, contradictions, and missing decisions

If the document is already a technical or architecture design, preserve its intent and avoid redesigning from scratch unless the design conflicts with go-zero conventions or contains implementation risks. Translate it into go-zero project structure, specs, generated code boundaries, and manual implementation tasks.

## Design Source of Truth Governance

Use these rules whenever architecture work reads, writes, updates, or hands off design decisions.

### Document Classification

Classify every design-related file before treating it as a fact source.

Authoritative design documents:

- Live under `docs/design/`.
- Match an approved versioned design filename such as `system_architecture_vX.Y.Z.md`, `api_design_vX.Y.Z.md`, or another naming pattern listed in Document Governance.
- Include version metadata and status in the document header.
- Are not under `docs/design/archive/`.

Archived design documents:

- Live under `docs/design/archive/`.
- Are historical evidence only.
- Must not override the latest maintained document.

Non-authoritative inputs:

- Unversioned files, ad hoc notes, temporary documents, screenshots, chat exports, copied references, and exploratory drafts.
- Files under reference or draft folders, if the project creates them.
- Files in `docs/design/` that do not match the maintained versioned naming and metadata rules.

Location alone is not enough. A temporary file placed in `docs/design/` is still non-authoritative until its decisions are promoted into a maintained versioned design document.

### Source of Truth Rules

- Treat the latest maintained versioned design documents as the only accepted architecture facts for downstream planning, development, testing, deployment, and selftest.
- Before producing a new architecture answer, inspect existing maintained design documents relevant to the request.
- If a temporary or reference document contains a technical change that is absent from the maintained design documents, mark it as a pending design sync item instead of silently treating it as accepted fact.
- If a temporary or reference document conflicts with a maintained design document, the maintained design document wins until the user explicitly approves updating it.
- Do not hand work to `gonna-plan`, `gonna-dev`, `gonna-test`, `gonna-deploy`, or `gonna-selftest` based only on temporary/reference material. First update or create the relevant maintained versioned design document, or explicitly state that the output is exploratory and not ready for downstream execution.
- Every downstream architecture handoff must cite the maintained design document path, version, and relevant section when one exists.
- When no maintained design document exists yet, create the smallest required versioned design document before declaring architecture facts ready for downstream work.

### Design Sync Workflow

When a source document, temporary note, implementation finding, test finding, or selftest feedback changes architecture intent:

1. Identify the affected maintained design document type.
2. Compare the proposed detail against the latest versioned document.
3. Decide whether the change is MAJOR, MINOR, or PATCH using the versioning rules below.
4. Update the maintained design document, including version history and cross-document links.
5. Archive the previous version when the change is MAJOR or MINOR.
6. Only then produce planning, implementation, deployment, test, or selftest handoff material.

For quick notes or throwaway analysis, do not force this workflow. Instead, label the output as exploratory and ask whether it should be promoted into a versioned design document.

## Architecture Responsibilities

This skill owns architecture decisions and architecture facts. It should answer:

- What capabilities does the system provide?
- How should services be decomposed?
- Which technology stack should be used and why?
- Which go-zero API, RPC, model, and config boundaries should exist?
- Which dependencies are required for local development and integration testing?
- How should services communicate synchronously and asynchronously?
- Which data stores own which data?
- How should authentication, authorization, tenancy, and secrets be handled?
- How should resilience, timeout, retry, rate limiting, and degradation work?
- How should metrics, traces, and logs be produced and observed?
- How should the architecture evolve when a feature changes the stack or scaffold?

Do not leave downstream skills to guess architecture decisions. Produce explicit artifacts or handoff sections that `gonna-plan`, `gonna-deploy`, `gonna-dev`, and `gonna-test` can consume.

## Compatibility Approval Gate

Do not design compatibility by default.

Compatibility design includes backward compatibility, forward compatibility, legacy support, dual-write or dual-read, shadow fields, alias fields, fallback behavior, deprecated fields, reserved fields, versioned endpoints, adapters, migration-only fields, optional future fields, and speculative extensibility.

This gate applies to:

- REST API routes, request fields, response fields, headers, status codes, and error codes
- RPC services, methods, proto messages, fields, tags, and error details
- Kafka/event topics, keys, message fields, and schema evolution
- Database tables, columns, indexes, constraints, default values, migration paths, and compatibility views
- Redis/cache keys, value shapes, TTLs, and fallback keys
- Config keys, environment variables, feature flags, and rollout switches
- Selftest contracts and test data that imply compatibility behavior

Rules:

- Prefer the minimal contract required by the user's current accepted intent.
- Do not add fields or interfaces only because they may be useful later.
- Do not include compatibility strategy in architecture artifacts unless the user explicitly approved it in the current workflow.
- If a source document appears to require compatibility, surface it as an approval question instead of treating the document as automatic approval.
- When compatibility may be necessary, stop and ask for approval with:
  - compatibility goal
  - affected contracts and storage
  - exact fields, endpoints, messages, tables, or config keys to add
  - operational cost and risk
  - risk of not doing compatibility
- Record the approval decision in the relevant design document before handing work to `gonna-plan`.

## Language Policy

Produce human-facing architecture output in Simplified Chinese by default. This includes architecture analysis, maintained design documents under `docs/design/`, scaffold plans, environment contracts, observability architecture, implementation handoffs, review notes, and user-facing summaries.

Keep code identifiers, paths, commands, API/RPC field names, config keys, status values, and upstream technical terms in their required technical form. Skill instructions and embedded reference documents may remain in English.

## Internal References

Use these project resources as references for this skill. The user should not need to invoke them directly.

Always read the workflow reference before producing a go-zero scaffold or implementation handoff:

- `.agents/ai-context/00-instructions.md`

Read these references when the task needs specific detail:

- `.agents/ai-context/workflows.md` for task sequencing
- `.agents/ai-context/tools.md` for goctl commands
- `.agents/ai-context/patterns.md` for concise go-zero patterns
- `.agents/skills/zero-skills/SKILL.md` for go-zero knowledge navigation
- `.agents/skills/zero-skills/references/rest-api-patterns.md` for REST API design
- `.agents/skills/zero-skills/references/rpc-patterns.md` for RPC design
- `.agents/skills/zero-skills/references/database-patterns.md` for models, SQL, Redis, MongoDB, and caching
- `.agents/skills/zero-skills/references/resilience-patterns.md` for rate limits, circuit breakers, retries, degradation, and timeouts
- `.agents/skills/zero-skills/references/goctl-commands.md` for exact generation commands

Reference loading rule:

- For source document analysis only, load `00-instructions.md` plus the smallest relevant references.
- For scaffold planning, load `00-instructions.md`, `workflows.md`, `tools.md`, and `goctl-commands.md`.
- For API, RPC, database, or resilience design, load only the matching detailed reference files.

## Core Output Modes

Choose one mode based on the user's request.

### 1. Architecture Analysis

Use when the user already has a source document and wants feedback, architecture mapping, or implementation planning.

Produce:

- Requirements summary
- Service boundaries
- API and RPC candidates
- Data model candidates
- Integration points and infrastructure dependencies
- Risks, open questions, and assumptions
- Implementation phases

### 2. Versioned Design Document

Use when the output should become a maintained project artifact under `docs/design/`.

`docs/design/` is reserved for accepted project architecture facts. Do not keep default framework baseline documents there. Generate files in `docs/design/` only after the user provides source material or explicitly asks to create architecture artifacts for the current project.

When a decision is accepted, record it in the relevant versioned design document before downstream handoff. Temporary or reference files can inform the decision, but they must not remain the only place where the accepted decision exists.

Prefer producing a split document set from the beginning. Keep `system_architecture_vX.Y.Z.md` as the overview and index, and place detailed decisions in topic-specific documents. Create only the documents required by the current source material.

Produce or update one or more versioned files:

- `docs/design/system_architecture_vX.Y.Z.md`
- `docs/design/service_layer_architecture_vX.Y.Z.md`
- `docs/design/api_design_vX.Y.Z.md`
- `docs/design/rpc_contract_vX.Y.Z.md`
- `docs/design/event_contract_vX.Y.Z.md`
- `docs/design/data_layer_design_vX.Y.Z.md`
- `docs/design/scaffold_architecture_vX.Y.Z.md`
- `docs/design/environment_contract_vX.Y.Z.md`
- `docs/design/observability_architecture_vX.Y.Z.md`
- `docs/design/security_architecture_vX.Y.Z.md`
- `docs/design/resilience_architecture_vX.Y.Z.md`
- `docs/design/migration_plan_vX.Y.Z.md`

Use the matching templates in `.agents/skills/gonna-arch/templates/` when writing these documents:

- `system_architecture_template.md`
- `service_layer_architecture_template.md`
- `api_design_template.md`
- `rpc_contract_template.md`
- `event_contract_template.md`
- `data_layer_design_template.md`
- `scaffold_architecture_template.md`
- `environment_contract_template.md`
- `observability_architecture_template.md`
- `security_architecture_template.md`
- `resilience_architecture_template.md`
- `migration_plan_template.md`

Do not create every document for every task. Create the smallest split set that gives downstream work a clear source of truth.

### 3. go-zero Implementation Handoff

Use when architecture must become concrete backend work.

Produce:

- go-zero service list
- `.api` specs to create or update
- `.proto` specs to create or update
- model generation needs
- `goctl` command plan
- files expected to be generated
- files expected to be hand-written
- validation commands

Base this handoff on the internal go-zero references above. Do not make the user manually switch to another skill.

When the user wants planning, use `.agents/skills/gonna-plan/SKILL.md` to turn the handoff into Epics, Stories, acceptance criteria, dependencies, and Sprint-ready backlog.

### 4. go-zero Scaffold Plan

Use when the user wants to bootstrap the project from a PRD, specification, technical design, or architecture document.

Produce:

- Module and repository layout
- Service directories and ownership
- API and RPC spec file locations
- Config file locations
- Model generation locations
- Shared package boundaries
- Development, build, and validation commands
- First implementation milestone

The scaffold plan should prefer go-zero conventions and `goctl` generation. Avoid inventing custom framework structure unless the source document requires it.

When the scaffold plan becomes a maintained project artifact, write it to `docs/design/scaffold_architecture_vX.Y.Z.md` using `.agents/skills/gonna-arch/templates/scaffold_architecture_template.md`.

### 5. Technical Stack Decision

Use when starting the project, adding a major capability, or changing infrastructure.

Produce:

- Go, go-zero, and goctl version expectations
- API and RPC framework choices
- Database, cache, queue, service discovery, object storage, and search/vector dependencies
- Observability stack choices
- Local development stack choices
- Rationale and rejected alternatives
- Impact on scaffold, config, environment, testing, and deployment

### 6. Environment Contract

Use when project setup, local debugging, integration testing, or a new feature needs runtime dependencies.

Produce or update `docs/design/environment_contract_vX.Y.Z.md`.

Use `.agents/skills/gonna-arch/templates/environment_contract_template.md` for the maintained document.

The contract should define:

- Required and optional local dependencies
- Docker images and version constraints
- Ports, credentials placeholders, volumes, and seed data
- go-zero config mapping for `etc/*.yaml`
- Profiles such as `minimal`, `integration`, and `observability`
- Health checks and connection checks
- Feature-to-dependency mapping
- Evolution rules for adding or removing dependencies

This skill decides what deployment/environment requires. `gonna-deploy` materializes it into Docker Compose, dependency containers, microservice containers, env files, health checks, and local run instructions.

### 7. Observability Architecture

Use when the system needs metrics, tracing, logging, dashboards, or local observability.

Produce or update `docs/design/observability_architecture_vX.Y.Z.md`.

Use `.agents/skills/gonna-arch/templates/observability_architecture_template.md` for the maintained document.

Define:

- Metrics, traces, and logs to emit
- OpenTelemetry Collector expectations
- Prometheus scrape expectations
- Grafana dashboard expectations
- Trace backend choice such as Jaeger or Tempo
- Log backend choice such as Loki when needed
- Required correlation fields such as trace ID and span ID
- go-zero service instrumentation expectations
- Local observability profile requirements for `gonna-deploy`

### 8. Architecture Evolution

Use when a feature changes service boundaries, contracts, dependencies, scaffold, data ownership, or observability.

Produce:

- Current architecture impact
- New or changed architecture artifacts
- Migration plan, and compatibility plan only when explicitly approved by the user
- Environment contract updates
- Planning handoff for `gonna-plan`
- Implementation handoff for `gonna-dev`
- Verification expectations for `gonna-test`

Also use this mode when `gonna-selftest` feedback marks a case as `Needs Design Update`. Treat that feedback as a human design-intent correction, then update the relevant architecture document, contract, open question, or implementation handoff before downstream planning or development continues.

## Document Governance

Use these rules only for maintained design documents.

Maintained design documents are the project-wide architecture source of truth. Downstream skills should not need to scan temporary notes to know the accepted architecture.

### Naming

Use semantic versioned names:

- `system_architecture_vX.Y.Z.md`
- `service_layer_architecture_vX.Y.Z.md`
- `api_design_vX.Y.Z.md`
- `rpc_contract_vX.Y.Z.md`
- `event_contract_vX.Y.Z.md`
- `data_layer_design_vX.Y.Z.md`
- `scaffold_architecture_vX.Y.Z.md`
- `environment_contract_vX.Y.Z.md`
- `observability_architecture_vX.Y.Z.md`
- `security_architecture_vX.Y.Z.md`
- `resilience_architecture_vX.Y.Z.md`
- `migration_plan_vX.Y.Z.md`
- `{topic}_faq_vX.Y.Z.md`

Avoid temporary names such as:

- `plan.md`
- `proposal.md`
- `design_update.md`
- `{feature}_design_updates.md`
- date-only version names

### Versioning

Use `vMAJOR.MINOR.PATCH`.

- MAJOR: incompatible architecture change, new major service boundary, data model redesign, API contract rewrite
- MINOR: approved backward-compatible feature, new endpoint group, new config, new integration, meaningful section addition
- PATCH: typo, clarification, small correction, formatting, reference fix

### Archives

Keep only the latest maintained version in `docs/design/`.

For MAJOR and MINOR updates:

1. Move the previous version to `docs/design/archive/`.
2. Add the archive date to the filename.
3. Create the new version in `docs/design/`.

Archive filename format:

```text
{original_name_without_extension}_{archive_date}.md
```

Example:

```text
docs/design/archive/api_design_v1.0.0_20260527.md
```

For PATCH updates, update the current file in place unless the user asks to preserve the previous patch version.

### Document Length

Use these limits as guidance, not as a reason to over-structure small projects.

- Main design document: 1000 to 2000 lines maximum
- Topic document: 200 to 500 lines maximum
- Move detailed implementation guides, large diagrams, and long examples into topic documents

## Required Document Structure

For maintained design documents, include:

```markdown
# {Title} vX.Y.Z

Version: vX.Y.Z
Created: YYYY-MM-DD
Updated: YYYY-MM-DD
Status: Draft | Approved | Implementing | Deprecated

## Document Governance

- Source of truth: yes
- Source documents: {PRD/spec/reference paths}
- Non-authoritative references: {temporary/reference paths or none}
- Downstream consumers: `gonna-plan`, `gonna-deploy`, `gonna-dev`, `gonna-test`, `gonna-selftest`

## Version History

| Version | Date | Changes | Author |
| --- | --- | --- | --- |
| v1.0.0 | YYYY-MM-DD | Initial version | {Author} |

## Overview

## Goals and Non-Goals

## Architecture

## Data Model

## API and RPC Design

## Operational Concerns

## Implementation Handoff

## Open Questions
```

Adjust sections to match the document type. Keep version numbers in the filename and document header consistent.

## Review Checklist

Before finalizing an architecture artifact, verify:

- The requested scope is clear
- The artifact is either a maintained versioned design document or clearly labeled exploratory
- Temporary/reference inputs are not treated as accepted facts unless promoted into a maintained design document
- Accepted design changes are recorded in the relevant `docs/design/*_vX.Y.Z.md` document before downstream handoff
- Assumptions are explicit
- Service boundaries are named
- API and RPC responsibilities do not overlap
- Data ownership is clear
- External dependencies are listed
- Failure handling is considered
- Security and permissions are considered
- Version numbers are consistent
- Relative links are used for cross-document references
- Downstream handoff cites maintained design document path, version, and section where applicable
- The implementation handoff is specific enough for go-zero work

## go-zero Handoff Format

When the user wants implementation detail, end with this structure:

```markdown
## go-zero Implementation Handoff

### Services

| Service | Type | Responsibility |
| --- | --- | --- |
| user-api | REST API | Public user endpoints |

### API Specs

- `api/user.api`: routes, request types, response types, auth groups

### RPC Specs

- `rpc/user/user.proto`: internal user service contract

### Models

- `model/user`: generated from `users` table

### goctl Plan

- `goctl api go -api api/user.api -dir services/user-api --style go_zero`
- `goctl rpc protoc rpc/user/user.proto --go_out=. --go-grpc_out=. --zrpc_out=services/user-rpc`

### Manual Implementation

- Implement business logic under `internal/logic`
- Inject dependencies through `internal/svc/service_context.go`
- Add config under `etc/*.yaml`

### Validation

- `go mod tidy`
- `go build ./...`
- Add focused tests for changed logic
```

Keep the handoff concrete and avoid writing generated code by hand.

## Environment Contract Format

When the user asks for project setup, local debugging dependencies, observability, or a feature changes infrastructure, use this structure:

```markdown
## Environment Contract

### Runtime Stack

| Component | Version or Constraint | Required | Notes |
| --- | --- | --- | --- |
| Go | {version} | yes | {notes} |
| go-zero | {version} | yes | {notes} |
| goctl | {version} | yes | {notes} |

### Local Dependencies

| Dependency | Image or Version | Profile | Ports | Purpose |
| --- | --- | --- | --- | --- |
| PostgreSQL | {image} | minimal | 5432 | Primary database |
| Redis | {image} | integration | 6379 | Cache |
| Kafka | {image} | integration | 9092 | Events |

### go-zero Config Mapping

| Config Path | Environment Value | Description |
| --- | --- | --- |
| `etc/{service}.yaml` | `{KEY}` | {description} |

### Profiles

- `minimal`: {dependencies}
- `integration`: {dependencies}
- `observability`: {dependencies}

### Health Checks

- Database connection: {check}
- Redis ping: {check}
- Kafka broker/topic: {check}
- OpenTelemetry Collector: {check}
- Prometheus target: {check}
- Grafana reachability: {check}

### Evolution Rules

- When a feature adds a runtime dependency or service container need, update this contract before `gonna-deploy` materializes it.
- When a feature changes observability requirements, update this contract and the observability architecture.
```

## Architecture Handoff Map

Use this mapping when producing handoffs:

- `gonna-plan` consumes Epics, Stories, acceptance criteria, dependencies, and implementation phases.
- `gonna-deploy` consumes deployment/environment contracts and observability architecture.
- `gonna-dev` consumes API/RPC/data/scaffold designs, generation plans, and manual implementation boundaries.
- `gonna-test` consumes acceptance criteria, API/RPC contracts, resilience expectations, observability expectations, and validation requirements.
- Online deployment architecture, release workflows, CI/CD, and production operations are project-specific and outside the generic `gonna` framework.

## Scaffold Planning Format

When the user asks to create or plan the project scaffold, use this structure:

````markdown
## go-zero Scaffold Plan

### Repository Layout

```text
.
|-- api/
|-- rpc/
|-- services/
|-- model/
|-- pkg/
|-- deploy/
`-- docs/
```

### Services

| Service | Type | Directory | Responsibility |
| --- | --- | --- | --- |
| user-api | REST API | `services/user-api` | Public user endpoints |

### Specs

- `api/user.api`
- `rpc/user/user.proto`

### Generation Plan

- `goctl api go -api api/user.api -dir services/user-api --style go_zero`
- `goctl rpc protoc rpc/user/user.proto --go_out=. --go-grpc_out=. --zrpc_out=services/user-rpc`

### Manual Work

- Implement logic in generated `internal/logic` packages
- Wire dependencies in `internal/svc/service_context.go`
- Add configs in `etc/*.yaml`
- Add models generated from database schema

### Validation

- `go mod tidy`
- `go build ./...`
- Add focused tests for core logic
````

Adjust the layout to the source document and keep generation boundaries clear.
