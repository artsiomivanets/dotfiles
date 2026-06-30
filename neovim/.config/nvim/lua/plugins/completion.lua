return {
  "saghen/blink.cmp",
  version = "1.*", -- downloads the prebuilt Rust fuzzy-matcher (no cargo needed)
  dependencies = {
    "L3MON4D3/LuaSnip",
    "rafamadriz/friendly-snippets",
  },
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    snippets = { preset = "luasnip" },

    -- Ported 1:1 from the old nvim-cmp mappings
    keymap = {
      preset = "none",
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-p>"] = { "select_prev", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },
      ["<C-n>"] = { "select_next", "fallback" },
      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      ["<C-Space>"] = { "show", "fallback" },
      ["<C-e>"] = { "cancel", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
      ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
    },

    appearance = {
      nerd_font_variant = "mono",
      -- Kind icons carried over from the old config
      kind_icons = {
        Text = "",
        Method = "m",
        Function = "",
        Constructor = "",
        Field = "",
        Variable = "",
        Class = "",
        Interface = "",
        Module = "",
        Property = "",
        Unit = "",
        Value = "",
        Enum = "",
        Keyword = "",
        Snippet = "",
        Color = "",
        File = "",
        Reference = "",
        Folder = "",
        EnumMember = "",
        Constant = "",
        Struct = "",
        Event = "",
        Operator = "",
        TypeParameter = "",
      },
    },

    completion = {
      documentation = { auto_show = true, auto_show_delay_ms = 200 },
      menu = {
        draw = {
          -- show source label, matching the old [LSP]/[Snippet]/[Buffer]/[Path]
          columns = { { "kind_icon" }, { "label", "label_description", gap = 1 }, { "source_name" } },
        },
      },
    },

    sources = {
      default = { "lsp", "snippets", "buffer", "path" },
    },

    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
  opts_extend = { "sources.default" },
}
