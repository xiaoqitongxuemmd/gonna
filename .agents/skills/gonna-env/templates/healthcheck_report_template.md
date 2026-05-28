# Local Environment Healthcheck Report

When instantiated for a user-facing project artifact, write headings and prose in Simplified Chinese. Keep commands, paths, service names, status literals, ports, and config keys in their required technical form.

Environment Profile: `minimal | integration | observability`
Generated: `YYYY-MM-DD`

## Summary

Result: `Pass | Partial | Fail`

## Container Status

| Service | Expected | Actual | Result |
| --- | --- | --- | --- |
| postgres | running/healthy | {actual} | {result} |

## Connectivity Checks

| Check | Command | Result | Notes |
| --- | --- | --- | --- |
| Docker Compose config | `docker compose config` | {result} | {notes} |
| Database connection | `{command}` | {result} | {notes} |
| Redis ping | `{command}` | {result} | {notes} |
| Kafka broker | `{command}` | {result} | {notes} |
| OpenTelemetry Collector | `{command}` | {result} | {notes} |
| Prometheus targets | `{command}` | {result} | {notes} |
| Grafana reachability | `{command}` | {result} | {notes} |

## go-zero Config Checks

| Config File | Dependency | Result | Notes |
| --- | --- | --- | --- |
| `etc/{service}.yaml` | {dependency} | {result} | {notes} |

## Observability Checks

| Signal | Expected | Actual | Result |
| --- | --- | --- | --- |
| Logs | trace fields present | {actual} | {result} |
| Metrics | service target up | {actual} | {result} |
| Traces | sample span received | {actual} | {result} |

## Issues

- {issue}

## Next Actions

- {action}
