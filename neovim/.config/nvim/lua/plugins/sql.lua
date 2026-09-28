-- SQL / PostgreSQL workflow built on vim-dadbod:
--   * vim-dadbod             runs queries (psql, sqlite3, mysql, ... under the hood)
--   * vim-dadbod-ui          connection/table browser + scratch query buffers
--   * vim-dadbod-completion  schema-aware completion (tables, columns) for blink.cmp
-- Results open in a split below as a `dbout` buffer.
--
-- Connections: `:DBUIAddConnection` (saved to stdpath("data")/db_ui), or export
-- DATABASE_URL, e.g. postgres://user@localhost:5432/mydb (passwords via ~/.pgpass).

local sql_fts = { "sql", "mysql", "plsql" }

return {
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = sql_fts, lazy = true },
    },
    cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer", "DB" },
    ft = sql_fts,
    keys = {
      { "<leader>su", "<cmd>DBUIToggle<CR>", desc = "SQL: toggle DB UI" },
      { "<leader>sa", "<cmd>DBUIAddConnection<CR>", desc = "SQL: add connection" },
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_show_database_icon = 1
      vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/db_ui"
      -- Never run a query just because the buffer was saved (format-on-save is on)
      vim.g.db_ui_execute_on_save = 0
      vim.g.db_ui_auto_execute_table_helpers = 1
      vim.g.db_ui_win_position = "left"
      vim.g.db_ui_winwidth = 35
      vim.g.db_ui_force_echo_notifications = 1

      vim.api.nvim_create_autocmd("FileType", {
        pattern = sql_fts,
        callback = function(ev)
          local function map(mode, lhs, rhs, desc, extra)
            vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", { buffer = ev.buf, silent = true, desc = desc }, extra or {}))
          end

          -- Operator: Q{motion} runs the text it covers, e.g. `Qip`, `Qap`, `QQ` (line)
          map({ "n", "x" }, "Q", "db#op_exec()", "SQL: execute {motion}", { expr = true })
          map("n", "QQ", "db#op_exec() .. '_'", "SQL: execute line", { expr = true })

          -- Run the statement (paragraph) under the cursor / the selection / the file
          map("n", "<leader>ss", "db#op_exec() .. 'ip'", "SQL: execute statement", { expr = true })
          map("x", "<leader>ss", "db#op_exec()", "SQL: execute selection", { expr = true })
          map("n", "<leader>sf", "<cmd>%DB<CR>", "SQL: execute file")

          -- Pick which connection this buffer runs against
          map("n", "<leader>sc", "<cmd>DBUIFindBuffer<CR>", "SQL: choose connection")
          map("n", "<leader>sl", "<cmd>DBUILastQueryInfo<CR>", "SQL: last query info")
          map("n", "<leader>sr", "<cmd>DBUIRenameBuffer<CR>", "SQL: rename query buffer")
        end,
      })

      -- Results buffer: readable, no wrapping, `q` closes it
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "dbout",
        callback = function(ev)
          vim.opt_local.wrap = false
          vim.opt_local.number = false
          vim.opt_local.signcolumn = "no"
          vim.opt_local.foldenable = false
          vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = ev.buf, silent = true, desc = "Close results" })
        end,
      })
    end,
  },
}
