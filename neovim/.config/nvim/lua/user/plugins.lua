local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]


return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use "ellisonleao/gruvbox.nvim"
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins


  -- Completion plugins
  use 'hrsh7th/nvim-cmp' -- The completion plugin
  use 'hrsh7th/cmp-buffer' -- Buffer completion
  use 'hrsh7th/cmp-path' -- Path completion
  use 'hrsh7th/cmp-cmdline' -- Cmdline completion
  use 'hrsh7th/cmp-nvim-lsp' -- Cmdline completion

  use 'saadparwaiz1/cmp_luasnip' -- Snippet completions
  use 'L3MON4D3/LuaSnip'

  -- LSP
  use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP
  use 'williamboman/mason.nvim' -- simple to use language server isntaller
  use 'WhoIsSethDaniel/mason-tool-installer.nvim' -- lanugage tools installer
  use "williamboman/mason-lspconfig.nvim"

  -- FZF
  use 'ibhagwan/fzf-lua'

  -- NvimTREE
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
  }

  -- NULL-LS
  use { "jose-elias-alvarez/null-ls.nvim", requires = { "nvim-lua/plenary.nvim" } }

  -- TreeSitter
  use { "nvim-treesitter/nvim-treesitter", run = ':TSUpdate' }

  -- Nvim Surroud
  use({
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
  })

  -- Autopairs
  use { "windwp/nvim-autopairs" }

  -- Comments
  use { 'numToStr/Comment.nvim' }

  use { 'RRethy/vim-illuminate' }

  -- Statusline
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  -- Git
  use { 'lewis6991/gitsigns.nvim' }

  --DiffView
  use { 'sindrets/diffview.nvim' }

  if packer_bootstrap then
    require('packer').sync()
  end
end)
