vim.g.mapleader = " "

local function keymap(mode, lhs, rhs) 

  if vim.fn.has('nvim-0.7') == 1 then
    vim.keymap(mode, lhs, rhs)
  else
    vim.api.nvim_set_keymap(mode, lhs, rhs, { noremap = true } )
  end
end
  

-- open the config files
keymap("n", "<Leader>Vi", ":e ~/.config/nvim/init.lua<CR>")
keymap("n", "<Leader>Vk", ":e ~/.config/nvim/lua/keymaps.lua<CR>")
keymap("n", "<Leader>Vo", ":e ~/.config/nvim/lua/options.lua<CR>")

-- hide search highlights
keymap("n", "<Leader>nh", ":nohl<CR>")

-- remap x to not copy deleted character
keymap("n", "x", "\"_x")

-- increment/decrement numbers
keymap("n", "<leader>+", "<C-a>") -- increment
keymap("n", "<leader>-", "<C-x>") -- decrement

-- window management
keymap("n", "<leader>\|", "<C-w>v") -- split window vertically
keymap("n", "<leader>-", "<C-w>s") -- split window horizontally
keymap("n", "<leader>se", "<C-w>=") -- make split windows equal width & height
keymap("n", "<leader>sx", ":close<CR>") -- close current split window

-- Ctrl-j + Ctrl+k to move lines up and down
keymap("n", "<c-j>", ":m .+1<CR>==")
keymap("n", "<c-k>", ":m .-2<CR>==")
keymap("i", "<c-j>", "<Esc>:m .+1<CR>==gi")
keymap("i", "<c-k>", "<Esc>:m .-2<CR>==gi")
keymap("v", "<c-j>", ":m '>+1<CR>gv=gv")
keymap("v", "<c-k>", ":m '<-2<CR>gv=gv")

-- Indenting
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")
