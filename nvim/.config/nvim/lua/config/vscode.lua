-- [[ Options ]]
-- Set <Space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Make line numbers default
vim.o.number = true
vim.o.relativenumber = true

-- [[ Keymaps ]]
-- Disable default functionality of <Space>
vim.keymap.set({ 'n', 'v', 'o' }, '<Space>', '<Nop>', { silent = true })

-- Quickly yank to system clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y', { desc = 'Yank to clipboard (motion)' })
vim.keymap.set('n', '<leader>yy', '"+yy', { desc = 'Yank line to clipboard' })
vim.keymap.set('n', '<leader>Y', '"+Y', { desc = 'Yank line to clipboard (from current position)' })
vim.keymap.set('n', '<leader>a', '<cmd>%y+<CR>', { desc = 'Yank all to clipboard' })

-- Quickly cut to system clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>d', '"+d', { desc = 'Cut to clipboard (motion)' })
vim.keymap.set('n', '<leader>dd', '"+dd', { desc = 'Cut line to clipboard' })
vim.keymap.set('n', '<leader>D', '"+D', { desc = 'Cut line to clipboard (from current position)' })

-- Quickly paste from system clipboard
vim.keymap.set('n', '<leader>p', '"+p', { desc = 'Paste after from clipboard' })
vim.keymap.set('v', '<leader>p', '"+p', { desc = 'Paste (visual) from clipboard' })
vim.keymap.set('n', '<leader>P', '"+P', { desc = 'Paste before from clipboard' })
vim.keymap.set('v', '<leader>P', '"+P', { desc = 'Paste before (visual) from clipboard' })

-- Stay in visual mode after indenting
vim.keymap.set('v', '<', '<gv', { desc = 'Indent left and re-select' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent right and re-select' })

-- -- Center screen when scrolling with <C-u> and <C-d>
-- vim.keymap.set('n', '<C-u>', '<C-u>zz')
-- vim.keymap.set('n', '<C-d>', '<C-d>zz')

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- -- Diagnostic keymaps
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Keybinds to make split navigation easier.
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Autocmds ]]
local group = vim.api.nvim_create_augroup('RelNumToggle', { clear = true })

-- Disable relativelinenumber when entering insert
vim.api.nvim_create_autocmd('ModeChanged', {
  group = group,
  pattern = '*:i',
  callback = function()
    vim.wo.relativenumber = false
  end,
})

-- Enable relativenumber when entering normal mode
vim.api.nvim_create_autocmd('ModeChanged', {
  group = group,
  pattern = '*:n',
  callback = function()
    vim.wo.relativenumber = true
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 200,
    })
  end,
})

-- [[ Plugins ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load Plugins
require("lazy").setup({
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      modes = {
        char = {
          enabled = true,
          jump_labels = false,
          multi_line = false,
          highlight = { backdrop = false },
        },
      },
    },
  },
})

-- Custom Colors
-- vim.api.nvim_set_hl(0, "FlashMatch", { link = "IncSearch" })
-- vim.api.nvim_set_hl(0, "FlashCurrent", { link = "IncSearch" })
-- vim.api.nvim_set_hl(0, "FlashCursor", { link = "IncSearch" })