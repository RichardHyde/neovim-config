local opt = vim.opt

-- line numbering
opt.relativenumber = true
opt.number = true

-- tabs
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- line wrapping
opt.wrap = false

-- Search options
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

opt.signcolumn = "yes"

-- Syntax highlighting
opt.syntax = "on"

-- backspace key
opt.backspace = "indent,eol,start"

-- clipboard
opt.clipboard:append("unnamedplus")

-- splits
opt.splitright = true
opt.splitbelow = true

opt.iskeyword:append("-")
