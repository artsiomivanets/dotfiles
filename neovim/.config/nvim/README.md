# lua-neovim
# Leader = Space

# Recomendations

- `<C-[> - ESC`
- `map <Caps Lock> to <Ctrl>`

# Requirenments
- fzf
- ripgrep
- nerd font

# Search
- FZF: `<leader>fa`
- Find Files: `<leader>ff`
- Buffers: `<leader>b`

# Tree
- toggle: `<leader><leader>`

# SQL / PostgreSQL (vim-dadbod)
Requires `psql` (or `sqlite3`, `mysql`, ...) on PATH. Passwords go in `~/.pgpass`.

Connect:
- `<leader>su` toggle the DB UI (browse DBs, tables, saved queries)
- `<leader>sa` add a connection, e.g. `postgres://user@localhost:5432/mydb`
- or `export DATABASE_URL=...` before starting nvim
- `<leader>sc` choose the connection for the current `.sql` buffer

Run (the results open in a split below; press `q` there to close it):
- `<leader>ss` run the statement (paragraph) under the cursor, or the visual selection
- `<leader>sf` run the whole file
- `Q{motion}` run any motion/text object: `Qip`, `Qap`, `QQ` (line), `Q` in visual
- `<leader>sl` last query info

Completion: tables/columns from the live connection (blink `DB` source).
LSP: `postgres_lsp` for syntax errors. Add a `postgres-language-server.jsonc`
with a `db` section to a project to get type-checking against the schema.
Format: `pg_format` (on save, or `<space>cf`).
