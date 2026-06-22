-- Migration: {000001}_{action}_{subject}
-- Purpose: {approved schema or data change}
-- Local target: deploy/local/sql/postgres/{matching domain or state file}
-- Online baseline: deploy/sql/postgres/ through {000000 or latest migration}
-- Prerequisite: {required prior online migration or schema state}
-- Validation: {normalized post-migration schema matches the local target}
-- Rollback: not included unless explicitly approved

BEGIN;

-- Add explicit precondition checks before destructive or data-changing statements.
-- Use idempotent DDL only when it cannot conceal an invalid schema state.

-- {migration statements}

COMMIT;
