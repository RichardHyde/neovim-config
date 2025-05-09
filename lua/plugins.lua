-- auto install packer if not installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
  return
end

-- Run PackerCompile where this file is saved
vim.cmd([[
  augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

-- add list of plugins to install
return packer.startup(function(use)
  -- packer can manage itself
  use("wbthomason/packer.nvim")

  use("nvim-lua/plenary.nvim") -- lua functions that many plugins use

  -- color schemes
  use("bluz71/vim-nightfly-guicolors")
  use("folke/tokyonight.nvim")
  use("christianchiarulli/nvcode-color-schemes.vim")

  -- file explorer
  use {
   "nvim-tree/nvim-tree.lua",
    config = require("configs.nvim-tree"),
  }

  -- Tree Sitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
    config = require("configs.treesitter"),
  }

  -- autocompletion
  use {-- completion plugin
    "hrsh7th/nvim-cmp",
    config = require("configs.nvim-cmp"),
  }
  use("hrsh7th/cmp-buffer") -- source for text in buffer
  use("hrsh7th/cmp-path") -- source for file system paths

  -- snippets
  use("L3MON4D3/LuaSnip") -- snippet engine
  use("saadparwaiz1/cmp_luasnip") -- for autocompletion
  use("rafamadriz/friendly-snippets") -- useful snippets

  -- managing & installing lsp servers, linters & formatters
  use {
    "williamboman/mason.nvim",
    config = require("configs.mason")
  } -- in charge of managing lsp servers, linters & formatters
  use("williamboman/mason-lspconfig.nvim") -- bridges gap b/w mason & lspconfig
  use("jose-elias-alvarez/null-ls.nvim")
  use("jay-babu/mason-null-ls.nvim")

  -- configuring lsp servers
  use {
    "neovim/nvim-lspconfig",
    config = require("configs.lspconfig"),
  }-- easily configure language servers
  use("hrsh7th/cmp-nvim-lsp") -- for autocompletion
  use({ "glepnir/lspsaga.nvim", branch = "main" }) -- enhanced lsp uis
  use("jose-elias-alvarez/typescript.nvim") -- additional functionality for typescript server (e.g. rename file & update imports)
  use("onsails/lspkind.nvim") -- vs-code like icons for autocompletion

  -- comment plugin
  use {
    "tpope/vim-commentary",
    config = require("configs.vim-commentary"),
  }

  -- git plugin
  use {
    "tpope/vim-fugitive",
    config = require("configs.vim-fugitive"),
  }

  if packer_bootstrap then
    require("packer").sync()
  end
end)
