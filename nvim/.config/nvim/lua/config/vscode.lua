-- [[ Options ]]
-- Set <Space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Make line numbers default
vim.o.number = true
vim.o.relativenumber = true

-- Use smart case for search (/, ?)
vim.o.ignorecase = true
vim.o.smartcase = true

-- [[ Keymaps ]]
-- Disable default functionality of <Space>
vim.keymap.set({ 'n', 'v', 'o' }, '<Space>', '<Nop>', { silent = true })

-- Quickly yank to system clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y', { desc = 'Yank to clipboard' })
vim.keymap.set('n', '<leader>yy', '"+yy', { desc = 'Yank line to clipboard' })
vim.keymap.set('n', '<leader>Y', '"+Y', { desc = 'Yank line to clipboard (from cursor)' })
vim.keymap.set('n', '<leader>a', '<cmd>%y+<CR>', { desc = 'Yank all to clipboard' })

-- Quickly cut to system clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>d', '"+d', { desc = 'Cut to clipboard' })
vim.keymap.set('n', '<leader>dd', '"+dd', { desc = 'Cut line to clipboard' })
vim.keymap.set('n', '<leader>D', '"+D', { desc = 'Cut line to clipboard (from cursor)' })

-- Quickly paste from system clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>p', '"+p', { desc = 'Paste after from clipboard' })
vim.keymap.set({ 'n', 'v' }, '<leader>P', '"+P', { desc = 'Paste before from clipboard' })

-- Stay in visual mode after indenting
vim.keymap.set('v', '<', '<gv', { desc = 'Indent left and re-select' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent right and re-select' })

-- -- Center screen when scrolling with <C-u> and <C-d>
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Keybinds to make split navigation easier.
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Autocmds ]]
-- Toggle relativelinenumber when entering insert/normal
local group = vim.api.nvim_create_augroup('vscode-relnum-toggle', { clear = true })
vim.api.nvim_create_autocmd('ModeChanged', {
  group = group,
  pattern = '*:i',
  callback = function() vim.wo.relativenumber = false end,
})
vim.api.nvim_create_autocmd('ModeChanged', {
  group = group,
  pattern = '*:n',
  callback = function() vim.wo.relativenumber = true end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('vscode-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank { higroup = 'IncSearch', timeout = 200 } end,
})

-- [[ Plugins ]]
require('plugins.flash')
