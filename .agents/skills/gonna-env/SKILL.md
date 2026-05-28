---
name: gonna-env
description: Use this skill when the user asks to create, update, run, or verify a local development/debug environment for this ai-native go-zero microservice framework project, including databases, Redis, Kafka, etcd, OpenTelemetry, Prometheus, Grafana, tracing, logging, Docker Compose profiles, environment variables, go-zero config mapping, health checks, or local observability wiring.
version: 1.0.0
license: MIT
---

# Environment Skill

This skill materializes architecture environment contracts into local development and debugging environments. It is responsible for Docker Compose plans, dependency containers, local env files, go-zero config mapping, observability wiring, health checks, and environment reports.

It is not responsible for choosing the system architecture, implementing application code, writing independent tests, or production deployment.

## Project Role

`gonna` is an ai-native engineering framework for go-zero based microservice development.

Use this skill as the local environment and observability support layer:

- `gonna-arch`: defines technical stack, environment contract, and observability architecture
- `gonna-plan`: turns architecture into Epics and Stories
- `gonna-env`: materializes local dependencies and observability from architecture contracts
- `gonna-dev`: implements go-zero services against the local environment
- `gonna-test`: validates services using the local environment
- future `gonna-deploy`: handles release and deployment execution

## When to Use

Use this skill for:

- Creating or updating local Docker Compose environment plans
- Adding database, cache, queue, service discovery, or object storage dependencies
- Adding Kafka, Redis, MySQL, PostgreSQL, MongoDB, etcd, MinIO, or similar local services
- Adding OpenTelemetry Collector, Prometheus, Grafana, Jaeger, Tempo, or Loki for observability
- Mapping local dependency values to go-zero `etc/*.yaml` config
- Creating or updating `.env` guidance for local development
- Defining local environment profiles such as `minimal`, `integration`, and `observability`
- Verifying container health and connectivity
- Producing local environment runbooks or healthcheck reports
- Updating local environment when a feature adds infrastructure dependencies

If the required stack is unclear, ask `gonna-arch` to produce or update the environment contract first. Do not choose major infrastructure technologies without an architecture decision.

## Inputs

Prefer one of these inputs:

- `docs/design/environment_contract_vX.Y.Z.md`
- `docs/design/observability_architecture_vX.Y.Z.md`
- `gonna-arch` technical stack decision
- `gonna-arch` go-zero scaffold plan
- `gonna-dev` implementation needs
- `gonna-test` integration or observability needs
- Existing `deploy/local/`, `docker-compose*.yaml`, `.env*`, or `etc/*.yaml` files

When input is incomplete, produce an environment proposal and clearly mark assumptions.

## Language Policy

Produce human-facing environment output in Simplified Chinese by default. This includes local environment plans, `deploy/local/README.md`, environment runbooks, healthcheck reports, observability notes, dependency explanations, and user-facing summaries.

Keep Docker image names, service names, ports, environment variable names, config keys, paths, commands, and protocol names in their required technical form. Skill instructions, templates, and low-level config files may remain in English when that is the natural technical format.

## Internal References

Use these project resources as internal references:

- `.agents/skills/gonna-arch/SKILL.md` for environment contract expectations
- `.agents/skills/zero-skills/SKILL.md` for go-zero knowledge navigation
- `.agents/skills/zero-skills/references/database-patterns.md` for database, Redis, cache, and model configuration
- `.agents/skills/zero-skills/references/rpc-patterns.md` for etcd/service discovery and RPC dependencies
- `.agents/skills/zero-skills/references/resilience-patterns.md` for local testing of timeout, retry, rate limit, and circuit breaker behavior
- `.agents/skills/zero-skills/troubleshooting/common-issues.md` for debugging go-zero runtime issues

The user should not need to invoke these references directly.

## Output Modes

Choose the smallest useful mode.

### 1. Environment Plan

Use when the user asks what local dependencies are needed.

Produce:

- Required services
- Optional services
- Profiles
- Ports
- Credentials placeholders
- Volumes
- go-zero config mapping
- Health checks
- Open questions

### 2. Local Compose Scaffold

Use when the user asks to create or update local environment files.

Create or update:

- `deploy/local/docker-compose.yaml`
- `deploy/local/.env.example`
- `deploy/local/README.md`
- Optional observability config files under `deploy/local/observability/`

Use templates in:

- `.agents/skills/gonna-env/templates/docker_compose_template.yaml`
- `.agents/skills/gonna-env/templates/env_template.md`
- `.agents/skills/gonna-env/templates/observability_config_template.md`

### 3. Healthcheck and Debug Report

Use when the user asks to verify local environment status.

Produce:

- Container status
- Connection checks
- go-zero config checks
- Observability target checks
- Failed dependency diagnosis
- Next actions

Use:

- `.agents/skills/gonna-env/templates/healthcheck_report_template.md`

## Environment Profiles

Use profiles to avoid starting unnecessary services.

### minimal

For focused local development.

Typical services:

- Current Story dependencies only
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

### observability

For tracing, metrics, logs, and local debugging.

Typical services:

- OpenTelemetry Collector
- Prometheus
- Grafana
- Jaeger or Tempo
- Loki when log aggregation is required
- All integration dependencies needed by the target service

## Dependency Rules

Do not add dependencies because they are popular. Add them because the environment contract, architecture design, Story, or implementation needs them.

For every dependency, define:

- Purpose
- Required profile
- Docker image and version constraint
- Port mapping
- Credentials placeholder
- Volume requirement
- Health check
- go-zero config mapping

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

A local environment is ready when required checks pass:

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

When asked to run local services:

- Inspect existing compose files first.
- Avoid overwriting user customizations.
- Use `docker compose config` before `docker compose up`.
- Use profile-specific startup when possible.
- Do not remove volumes or data unless the user explicitly asks.
- Do not access production systems.

## Environment Plan Format

When answering without writing files, use this format:

```markdown
## Local Environment Plan

### Source Contract

- `{path or summary}`

### Profiles

| Profile | Services | Purpose |
| --- | --- | --- |
| minimal | {services} | {purpose} |
| integration | {services} | {purpose} |
| observability | {services} | {purpose} |

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

When local environment files are ready:

- `gonna-dev` uses them to run and debug services.
- `gonna-test` uses them for integration and observability verification.
- Future `gonna-deploy` may reuse architecture decisions, but production deployment remains separate.
