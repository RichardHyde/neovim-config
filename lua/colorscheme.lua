local opt = vim.opt

-- Colour setup
opt.termguicolors = true

-- set colorscheme to tokyonight with protected call
-- in case it isn't installed
local status, tokyonight = pcall(require, "tokyonight")
if status then

  vim.cmd([[colorscheme tokyonight-night]])
  return
end


