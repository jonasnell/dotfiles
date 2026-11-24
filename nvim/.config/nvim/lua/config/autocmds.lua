-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

-- Don't auto-continue comments when pressing o/O in normal mode
-- (Keep 'r' so <CR> in insert mode still continues comments; add 'r' below to disable both)
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('disable-auto-comment', { clear = true }),
  callback = function() vim.opt_local.formatoptions:remove { 'o' } end,
})
