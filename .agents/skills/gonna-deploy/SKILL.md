---
name: gonna-deploy
description: Use this skill when the user asks to create, update, run, or verify local deployment assets, local database state SQL, or versioned online migration SQL for this ai-native go-zero microservice framework project. It maintains deploy/local/sql as the local database target and derives deploy/sql migrations for release handoff.
version: 1.2.0
license: MIT
---

# Deploy Skill

This skill materializes deployment contracts for `gonna`: Docker Compose files, dependency containers, go-zero microservice containers, local env files, go-zero config mapping, observability wiring, health checks, local deployment runbooks, local database state SQL, and versioned online migration assets for release handoff.

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
- Updating the desired local database state under `deploy/local/sql/{engine}/` for an approved schema change
- Comparing local database state with the versioned online database state to prepare the missing release migration
- Organizing versioned online migration assets under `deploy/sql/{engine}/`
- Verifying migration ordering, state comparison, dependency checks, and local migration rehearsal instructions

If the required stack, service list, or local deployment target is unclear, ask `gonna-arch` to produce or update the deployment/environment contract first. Do not choose major infrastructure technologies or online deployment platforms inside this generic skill.

## Inputs

Prefer one of these inputs:

- `docs/design/environment_contract_vX.Y.Z.md`
- `docs/design/observability_architecture_vX.Y.Z.md`
- `gonna-arch` technical stack decision
- `gonna-arch` go-zero scaffold plan
- `gonna-dev` implementation needs
- `gonna-test` integration or observability needs
- Existing `deploy/local/`, `deploy/local/sql/`, `docker-compose*.yaml`, `.env*`, or `etc/*.yaml` files
- Existing `deploy/sql/` online migration files and the database engine in use
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
- `deploy/local/sql/{engine}/` for local database initialization state when a SQL database is used
- Optional observability config files under `deploy/local/observability/`
- Optional Dockerfiles or service build references for development microservices when the project has not already defined them

Use templates in:

- `.agents/skills/gonna-deploy/templates/docker_compose_template.yaml`
- `.agents/skills/gonna-deploy/templates/env_template.md`
- `.agents/skills/gonna-deploy/templates/observability_config_template.md`
- `.agents/skills/gonna-deploy/templates/postgres_local_state_template.sql` when initializing PostgreSQL local state

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

Use when the user explicitly asks to prepare an online release and an accepted architecture or Story has changed the desired local database schema, persistent data shape, index, constraint, seed baseline, or other database state.

Create or update:

- `deploy/local/sql/{engine}/` first when the local target state is missing or stale
- `deploy/sql/{engine}/{NNNNNN}_{action}_{subject}.sql`
- Local Compose initialization mount for `deploy/local/sql/{engine}/` when the existing local deployment needs it
- Release migration notes in the relevant implementation, test, or commit artifact when requested

Use:

- `.agents/skills/gonna-deploy/templates/postgres_migration_template.sql` for PostgreSQL migrations

Do not create local state SQL or a migration from an unapproved schema idea. The accepted versioned design document, `.api`/`.proto` contract, Story, or explicit user instruction must define the current-intent data change first.

## Database State and Release Migration Rules

Maintain two repository database views for each SQL engine:

- `deploy/local/sql/{engine}/` is the desired local database state. Its scripts initialize an empty local Docker volume to the schema and baseline data required by current development.
- `deploy/sql/{engine}/` is the versioned representation of the online database state. Its ordered scripts are the online migrations already released or prepared for the next approved release.

The two roots must have the same database-engine and domain subdirectory structure, for example `deploy/local/sql/postgres/auth/` and `deploy/sql/postgres/auth/`. They do not need identical files: local SQL describes the current target state, while online SQL records incremental transitions. Do not copy a full local schema file into `deploy/sql/` as a substitute for a migration.

When development changes a database schema:

1. `gonna-dev` hands the approved change to `gonna-deploy`.
2. `gonna-deploy` updates `deploy/local/sql/{engine}/` so a fresh local database reaches the new target state.
3. Do not create an online migration merely because local development changed the schema.

When the user asks to prepare an online release:

1. Read both `deploy/local/sql/{engine}/` and `deploy/sql/{engine}/`.
2. Reconstruct the repository online baseline from the ordered `deploy/sql/{engine}/` migrations and the desired target from `deploy/local/sql/{engine}/`, using an engine-native schema dump or introspection command. Do not rely on a text diff alone and do not access a real production database.
3. Generate only the next incremental `deploy/sql/{engine}/{NNNNNN}_{action}_{subject}.sql` needed to bring the online baseline to the local target.
4. Apply the generated migration to the reconstructed online baseline in a local or approved test environment and verify that its normalized schema matches the local target state.

Migration file rules:

- Use a six-digit, monotonically increasing sequence and a concise functional name: `000001_init_schema.sql`, `000002_add_vehicle_status.sql`, `000003_drop_legacy_ota_tables.sql`.
- Derive the next sequence from the highest committed online migration in the same engine directory. Do not use Story, Epic, task, sprint, or iteration IDs in migration file names.
- A released migration is immutable. Never edit, reorder, rename, or delete an already applied migration; create a new incremental migration instead.
- Include only the current approved change. Do not add reserved columns, speculative indexes, compatibility tables, dual-write helpers, or migration-only fallbacks without explicit user approval.
- Use idempotent DDL only when it does not conceal an invalid schema state. When an expected predecessor is required, add an explicit precondition and fail with a clear message instead of silently proceeding.
- For destructive or data-changing operations, state and verify prerequisites, preserve transaction boundaries when the engine supports them, and abort before destructive DDL when data validation fails.
- Do not add a rollback migration by default. Prepare one only when the user explicitly requests and approves that rollback contract.

Local state rules:

- Keep `deploy/local/sql/{engine}/` mounted into the local database image initialization directory, or use an equivalent local initializer, so a fresh local volume reaches the desired development state.
- Keep local engine and domain subdirectories aligned with `deploy/sql/{engine}/`; create the matching empty directory when one side needs a new domain area.
- Local SQL must be safe to initialize a fresh local volume. It is not an online migration history and must not contain production credentials, hostnames, or release-only operational steps.
- Database image initialization hooks run only for a fresh local volume. When verifying a local state change against an existing volume, use an explicit local reset or engine-specific update procedure; do not represent fresh initialization as proof that an online migration will work.

Before handing off a migration package, verify:

- The migration sequence is unique and ordered.
- The local target and online baseline use matching engine/domain directory structures.
- The target engine and schema contract are clear.
- The generated online migration closes the verified difference between the repository online baseline and local target.
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

Versioned files under `deploy/sql/{engine}/` are allowed as reviewed release migration artifacts derived from the repository database-state comparison. They are not permission to connect to, execute against, or verify a staging or production database. Remote execution, release ordering, backups, approvals, and rollback operations remain project-specific responsibilities.

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
- `gonna-dev` hands every approved database schema change to `gonna-deploy` so `deploy/local/sql/{engine}/` remains the current local target state.
- `gonna-test` uses them for integration and observability verification.
- `gonna-commit` may include local deployment changes in the commit scope when requested.

When release migration files are ready:

- `gonna-dev` keeps models, queries, and service logic aligned with the local target state and generated post-migration schema.
- `gonna-test` verifies migration preconditions and post-migration behavior in a local or approved test environment.
- `gonna-selftest` prepares human-facing database-visible contract checks when applicable.
- `gonna-commit` includes migration files in the implementation commit unit and records any missing execution evidence.
