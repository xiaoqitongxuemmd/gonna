---
name: gonna-deploy
description: Use this skill when the user asks to create, update, run, or verify local deployment assets or versioned release migration SQL for this ai-native go-zero microservice framework project. It provides local Docker Compose deployment and release-ready database migration asset planning.
version: 1.1.0
license: MIT
---

# Deploy Skill

This skill materializes deployment contracts for `gonna`: Docker Compose files, dependency containers, go-zero microservice containers, local env files, go-zero config mapping, observability wiring, health checks, local deployment runbooks, and versioned database migration assets for release handoff.

The generic `gonna` framework does not provide online deployment execution, production release execution, CI/CD, or DevOps behavior because those rules vary heavily by project and team. It may prepare versioned migration SQL as release artifacts, but it must not execute them against staging or production.

## Project Role

`gonna` is an ai-native engineering framework for go-zero based microservice development.

Use this skill as the deployment materialization layer:

- `gonna-arch`: defines technical stack, deployment/environment contract, and observability architecture
- `gonna-plan`: turns architecture into Epics and Stories
- `gonna-deploy`: materializes local Docker Compose deployment and release migration assets
- `gonna-dev`: implements go-zero services that can be containerized and run by the local deployment
- `gonna-test`: validates services using the local deployment

## When to Use

Use this skill for:

- Creating or updating local Docker Compose deployment plans
- Organizing local dependency containers and development microservice containers in one Compose topology
- Adding go-zero API/RPC service containers for services under `services/`
- Adding database, cache, queue, service discovery, or object storage dependency containers
- Adding Kafka, Redis, MySQL, PostgreSQL, MongoDB, etcd, MinIO, or similar local services
- Adding OpenTelemetry Collector, Prometheus, Grafana, Jaeger, Tempo, or Loki for observability
- Mapping local dependency values to go-zero `etc/*.yaml` config
- Creating or updating `.env` guidance for local deployment
- Defining local deployment profiles such as `minimal`, `integration`, `observability`, and service-specific profiles
- Verifying container health, network connectivity, and sample service startup
- Producing local deployment runbooks or healthcheck reports
- Updating local deployment when a feature adds infrastructure dependencies or new microservices
- Updating local deployment assets when a project-specific online deployment workflow requires local parity inputs
- Preparing versioned database migration SQL for a reviewed and accepted schema change
- Organizing release migration assets under `deploy/sql/{engine}/`
- Verifying migration ordering, dependency checks, and local migration rehearsal instructions

If the required stack, service list, or local deployment target is unclear, ask `gonna-arch` to produce or update the deployment/environment contract first. Do not choose major infrastructure technologies or online deployment platforms inside this generic skill.

## Inputs

Prefer one of these inputs:

- `docs/design/environment_contract_vX.Y.Z.md`
- `docs/design/observability_architecture_vX.Y.Z.md`
- `gonna-arch` technical stack decision
- `gonna-arch` go-zero scaffold plan
- `gonna-dev` implementation needs
- `gonna-test` integration or observability needs
- Existing `deploy/local/`, `docker-compose*.yaml`, `.env*`, or `etc/*.yaml` files
- Existing `deploy/sql/` migration files and the database engine in use
- Existing service directories under `services/`

When input is incomplete, produce a deployment proposal and clearly mark assumptions.

## Language Policy

Produce human-facing deployment output in Simplified Chinese by default. This includes local deployment plans, `deploy/local/README.md`, deployment runbooks, healthcheck reports, observability notes, dependency explanations, and user-facing summaries.

Keep Docker image names, service names, ports, environment variable names, config keys, paths, commands, and protocol names in their required technical form. Skill instructions, templates, and low-level config files may remain in English when that is the natural technical format.

## Internal References

Use these project resources as internal references:

- `.agents/skills/gonna-arch/SKILL.md` for deployment/environment contract expectations
- `.agents/skills/zero-skills/SKILL.md` for go-zero knowledge navigation
- `.agents/skills/zero-skills/references/database-patterns.md` for database, Redis, cache, and model configuration
- `.agents/skills/zero-skills/references/rpc-patterns.md` for etcd/service discovery and RPC dependencies
- `.agents/skills/zero-skills/references/resilience-patterns.md` for local testing of timeout, retry, rate limit, and circuit breaker behavior
- `.agents/skills/zero-skills/troubleshooting/common-issues.md` for debugging go-zero runtime issues

The user should not need to invoke these references directly.

## Output Modes

Choose the smallest useful mode.

### 1. Local Deployment Plan

Use when the user asks what local deployment, dependencies, or service containers are needed.

Produce:

- Required services
- Development microservices
- Optional services
- Profiles
- Ports
- Credentials placeholders
- Volumes
- go-zero config mapping
- Health checks
- Open questions

### 2. Local Compose Deployment Scaffold

Use when the user asks to create or update local deployment files.

Create or update:

- `deploy/local/docker-compose.yaml`
- `deploy/local/.env.example`
- `deploy/local/README.md`
- Optional observability config files under `deploy/local/observability/`
- Optional Dockerfiles or service build references for development microservices when the project has not already defined them

Use templates in:

- `.agents/skills/gonna-deploy/templates/docker_compose_template.yaml`
- `.agents/skills/gonna-deploy/templates/env_template.md`
- `.agents/skills/gonna-deploy/templates/observability_config_template.md`

### 3. Healthcheck and Debug Report

Use when the user asks to verify local deployment status.

Produce:

- Container status
- Connection checks
- go-zero config checks
- Observability target checks
- Failed dependency diagnosis
- Next actions

Use:

- `.agents/skills/gonna-deploy/templates/healthcheck_report_template.md`

### 4. Release Migration Package

Use when an accepted architecture or Story changes a database schema, persistent data shape, index, constraint, seed baseline, or other database state that must be prepared before application rollout.

Create or update:

- `deploy/sql/{engine}/{NNNNNN}_{action}_{subject}.sql`
- Local migration runner or Compose mount only when the existing local deployment needs it
- Release migration notes in the relevant implementation, test, or commit artifact when requested

Use:

- `.agents/skills/gonna-deploy/templates/postgres_migration_template.sql` for PostgreSQL migrations

Do not create a migration from an unapproved schema idea. The accepted versioned design document, `.api`/`.proto` contract, Story, or explicit user instruction must define the current-intent data change first.

## Release Migration Rules

Treat `deploy/sql/{engine}/` as the release migration source of truth for SQL databases. Use a database-specific subdirectory such as `deploy/sql/postgres/` or `deploy/sql/mysql/`; do not mix database engines in one directory.

Migration file rules:

- Use a six-digit, monotonically increasing sequence and a concise functional name: `000001_init_schema.sql`, `000002_add_vehicle_status.sql`, `000003_drop_legacy_ota_tables.sql`.
- Derive the next sequence from the highest committed migration in the same engine directory. Do not use Story, Epic, task, sprint, or iteration IDs in migration file names.
- A released migration is immutable. Never edit, reorder, rename, or delete an already applied migration; create a new incremental migration instead.
- Include only the current approved change. Do not add reserved columns, speculative indexes, compatibility tables, dual-write helpers, or migration-only fallbacks without explicit user approval.
- Use idempotent DDL only when it does not conceal an invalid schema state. When an expected predecessor is required, add an explicit precondition and fail with a clear message instead of silently proceeding.
- For destructive or data-changing operations, state and verify prerequisites, preserve transaction boundaries when the engine supports them, and abort before destructive DDL when data validation fails.
- Do not add a rollback migration by default. Prepare one only when the user explicitly requests and approves that rollback contract.

Local parity rules:

- Reuse the release migration files for local verification whenever practical. Mount `deploy/sql/{engine}/` read-only into a local migration runner or database container rather than maintaining a divergent copy.
- If an existing repository intentionally has `deploy/local/sql/`, update it in the same change only when its local runner requires separate bootstrap SQL; document how it stays synchronized with `deploy/sql/{engine}/`.
- Database image initialization hooks are for a fresh local volume only. Do not represent them as a substitute for applying incremental release migrations to an existing environment.

Before handing off a migration package, verify:

- The migration sequence is unique and ordered.
- The target engine and schema contract are clear.
- Precondition, data-validation, and transaction behavior are suitable for the operation.
- Local rehearsal command or runner is documented when local deployment exists.
- Application code and generated models/config expect the post-migration schema.
- The migration file contains no credentials, production hostnames, or machine-specific paths.

## Local Deployment Profiles

Use profiles to avoid starting unnecessary services.

### minimal

For focused local development and debugging.

Typical services:

- Current Story dependencies only
- Current target microservice
- One database if required
- Redis only if required

### integration

For service integration and `gonna-test` integration checks.

Typical services:

- Database
- Redis
- Kafka or message broker
- etcd if go-zero RPC service discovery is required
- Object storage if required
- Target API/RPC services that participate in the integration scenario

### observability

For tracing, metrics, logs, and local debugging.

Typical services:

- OpenTelemetry Collector
- Prometheus
- Grafana
- Jaeger or Tempo
- Loki when log aggregation is required
- All integration dependencies needed by the target service
- Target API/RPC services with observability enabled

## Local Compose Service Rules

Do not add dependencies or service containers because they are popular. Add them because the deployment contract, architecture design, Story, implementation, or test scenario needs them.

For every dependency container, define:

- Purpose
- Required profile
- Docker image and version constraint
- Port mapping
- Credentials placeholder
- Volume requirement
- Health check
- go-zero config mapping

For every go-zero microservice container, define:

- Service name and type: API, RPC, job, worker, consumer, or other
- Source directory under `services/`
- Build context and Dockerfile, or a prebuilt image reference
- Runtime command or entrypoint
- Config file mounted or baked into the image
- Required dependency containers and `depends_on` health checks
- Exposed ports when needed
- Profile membership
- Log, metrics, and trace settings when observability is enabled

Use version-pinned images where practical. Avoid `latest` in durable project files.

Do not commit real secrets. Use examples and placeholders.

## go-zero Config Mapping

For each service dependency, map local values to go-zero config.

Examples:

- Database DSN to `etc/{service}.yaml`
- Redis host, type, pass, and key prefix
- Kafka broker list and topic names
- etcd hosts for zrpc service discovery
- OpenTelemetry collector endpoint
- Prometheus scrape endpoint
- Log level and trace correlation fields

Inspect existing `etc/*.yaml` files before editing or recommending exact fields.

## Online Deployment Boundary

Local Docker Compose deployment is the default. Do not create Kubernetes, Helm, Terraform, cloud, production, staging, or CI/CD deployment assets by default.

Versioned files under `deploy/sql/{engine}/` are allowed as reviewed release migration artifacts. They are not permission to connect to, execute against, or verify a staging or production database. Remote execution, release ordering, backups, approvals, and rollback operations remain project-specific responsibilities.

Do not add other online deployment assets from this generic skill. When a project needs online deployment, require a project-specific workflow or skill that defines:

- Target platform
- Environment names
- Image registry and tag strategy
- Secret management
- Runtime config source
- Network and ingress rules
- Observability requirements
- Rollback and release gate expectations

This local deployment skill may provide Docker Compose parity notes for those project-specific workflows, but it must not author the online deployment implementation itself.

## Observability Rules

When observability is requested, define:

- What metrics should be exposed
- Where Prometheus should scrape
- Where traces should be exported
- How logs should include trace IDs
- Which Grafana dashboards are expected
- Which sample request should produce observable signals

For go-zero services, prefer explicit service name, environment, and version labels.

Do not assume the exact go-zero telemetry config shape without inspecting the current code and config.

## Healthcheck Rules

A local deployment is ready when required checks pass:

- Docker Compose config is valid
- Required containers are running or healthy
- Database connection works
- Redis ping works when Redis is required
- Kafka broker is reachable and topics can be listed or created when Kafka is required
- etcd is reachable when zrpc discovery is required
- OpenTelemetry Collector is reachable when observability is enabled
- Prometheus targets are up when Prometheus is enabled
- Grafana is reachable when Grafana is enabled
- The target go-zero service starts with local config
- A sample request produces expected logs, traces, or metrics when observability is enabled

If a check cannot run, explain why and list the residual risk.

## Safe Execution

Prefer planning and file generation before starting services.

When asked to run local deployment:

- Inspect existing compose files first.
- Avoid overwriting user customizations.
- Use `docker compose config` before `docker compose up`.
- Use profile-specific startup when possible.
- Do not remove volumes or data unless the user explicitly asks.
- Do not access production systems.

## Local Deployment Plan Format

When answering without writing files, use this format:

```markdown
## Local Deployment Plan

### Source Contract

- `{path or summary}`

### Profiles

| Profile | Services | Purpose |
| --- | --- | --- |
| minimal | {services} | {purpose} |
| integration | {services} | {purpose} |
| observability | {services} | {purpose} |

### Microservices

| Service | Type | Build/Image | Profile | Ports | Purpose |
| --- | --- | --- | --- | --- | --- |
| `{service}` | API/RPC | `{build or image}` | minimal | `{port}` | {purpose} |

### Dependencies

| Service | Image | Profile | Ports | Purpose |
| --- | --- | --- | --- | --- |
| postgres | postgres:{version} | minimal | 5432:5432 | Primary database |

### go-zero Config Mapping

| Config | Value Source | Description |
| --- | --- | --- |
| `etc/{service}.yaml` | `{ENV_VAR}` | {description} |

### Health Checks

- {check}

### Open Questions

- {question}
```

## Handoff

When local deployment files are ready:

- `gonna-dev` uses them to run and debug services.
- `gonna-test` uses them for integration and observability verification.
- `gonna-commit` may include local deployment changes in the commit scope when requested.

When release migration files are ready:

- `gonna-dev` keeps models, queries, and service logic aligned with the post-migration schema.
- `gonna-test` verifies migration preconditions and post-migration behavior in a local or approved test environment.
- `gonna-selftest` prepares human-facing database-visible contract checks when applicable.
- `gonna-commit` includes migration files in the implementation commit unit and records any missing execution evidence.
