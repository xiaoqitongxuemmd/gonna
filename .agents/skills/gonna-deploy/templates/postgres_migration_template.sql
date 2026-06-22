-- Migration: {000001}_{action}_{subject}
-- Purpose: {approved schema or data change}
-- Prerequisite: {required prior migration or schema state}
-- Validation: {query or expected post-migration state}
-- Rollback: not included unless explicitly approved

BEGIN;

-- Add explicit precondition checks before destructive or data-changing statements.
-- Use idempotent DDL only when it cannot conceal an invalid schema state.

-- {migration statements}

COMMIT;
