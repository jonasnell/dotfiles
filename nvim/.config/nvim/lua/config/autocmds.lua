-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands` and `:help events`
--
-- Signature:
--   vim.api.nvim_create_autocmd(event, opts)
--
-- Common Events (string or table):
--   'FileType'   'BufEnter'   'BufWritePre'   'TextYankPost'   'LspAttach'
--
-- Opts:
--   group    = vim.api.nvim_create_augroup('name', { clear = true })
--   pattern  = Glob/filetype filter (e.g. '*.lua', { 'md', 'txt' }; default '*')
--   buffer   = Buffer-local bufnr (mutually exclusive with `pattern`)
--   callback = function(ev) ... end  (ev.buf, ev.match, ev.file)
--   command  = Vim Ex command string (alternative to `callback`)
--   desc     = 'Description'
--   once     = true (run once, then --
--
-- Example:
--   vim.api.nvim_create_autocmd('FileType', {
--     group = vim.api.nvim_create_augroup('my-group', { clear = true }),
--     pattern = 'markdown',
--     command = 'setlocal wrap',
--   })delete)

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

-- Don't auto-continue comments when pressing o/O in normal mode
vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('disable-auto-comment', { clear = true }),
  callback = function() vim.opt_local.formatoptions:remove { 'o' } end,
})
