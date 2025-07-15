-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Run PackerCompile where this file is saved
-- vim.cmd([[
--   augroup lazy_user_config
--   autocmd!
--   autocmd BufWritePost plugins.lua source <afile> | PackerCompile
--   augroup end
-- ]])

-- Setup lazy
require("lazy").setup({
  checker = { enabled = true }, -- check for updates
  spec = {
    {"nvim-lua/plenary.nvim"}, -- lua functions that many plugins use

    -- color schemes
    {"bluz71/vim-nightfly-guicolors"},
    {"folke/tokyonight.nvim"},
    {"christianchiarulli/nvcode-color-schemes.vim"},

    -- file explorer
    { "nvim-tree/nvim-tree.lua", init = function()
        require("configs.nvim-tree")
      end},

    -- Tree Sitter
    { 'nvim-treesitter/nvim-treesitter', init = function()
        require("configs.treesitter")
      end,
      build = function()
        local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
        ts_update()
      end,
    },
    -- autocompletion
    {"hrsh7th/nvim-cmp", init = function()
        require("configs.nvim-cmp")
      end
    },
    {"hrsh7th/cmp-buffer"}, -- source for text in buffer
    {"hrsh7th/cmp-path"}, -- source for file system paths

    -- snippets
    {"L3MON4D3/LuaSnip"}, -- snippet engine
    {"saadparwaiz1/cmp_luasnip"}, -- for autocompletion
    {"rafamadriz/friendly-snippets"}, -- useful snippets

    -- managing & installing lsp servers, linters & formatters
    { "williamboman/mason.nvim", init = function()
        require("configs.mason")
      end
    }, -- in charge of managing lsp servers, linters & formatters
    {"williamboman/mason-lspconfig.nvim"}, -- bridges gap b/w mason & lspconfig
    {"jose-elias-alvarez/null-ls.nvim"},
    {"jay-babu/mason-null-ls.nvim"},

    -- configuring lsp servers
    {"neovim/nvim-lspconfig", init = function()
        require("configs.lspconfig")
      end
    }, -- easily configure language servers
    {"hrsh7th/cmp-nvim-lsp"}, -- for autocompletion
    {"glepnir/lspsaga.nvim"}, -- enhanced lsp uis
    {"jose-elias-alvarez/typescript.nvim"}, -- additional functionality for typescript server (e.g. rename file & update imports)
    {"onsails/lspkind.nvim"}, -- vs-code like icons for autocompletion

    -- comment plugin
    {"tpope/vim-commentary", init = function()
        require("configs.vim-commentary")
      end
    },

    -- git plugin
    {"tpope/vim-fugitive", init = function()
        require("configs.vim-fugitive")
      end
    },

  }
})

