# Selftest Feedback

When instantiated for a user-facing project artifact, write headings and prose in Simplified Chinese. Keep Story IDs, case IDs, status values, paths, commands, and raw output in their required technical form.

Story: `{STORY-X-XX}`
Case: `{HTTP-XXX | RPC-XXX | KAFKA-XXX | DB-XXX | REDIS-XXX | JOB-XXX | WEBHOOK-XXX}`
Human Result: `不符合预期`

## 实际行为

```text
{actual behavior}
```

## 预期意图

```text
{user intended behavior}
```

## 证据

- Command: `{command}`
- Output:

```text
{raw output}
```

## 建议回流

- `gonna-arch`: {design document update needed}
- `gonna-dev`: {implementation change needed}
- `gonna-test`: {automated test update needed}
