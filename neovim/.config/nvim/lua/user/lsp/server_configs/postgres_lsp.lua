-- Postgres Language Server (pg-language-server.com): syntax errors, linting and,
-- when a project has a postgres-language-server.jsonc with a `db` section,
-- type-checking + completion against the real schema.
-- Upstream requires that jsonc to start; relax it so loose .sql files get
-- diagnostics too (the server falls back to its defaults).
return {
  root_markers = { "postgres-language-server.jsonc", ".git" },
  workspace_required = false,
}
