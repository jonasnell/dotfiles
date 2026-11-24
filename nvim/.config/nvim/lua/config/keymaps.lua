-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`
--
-- Signature:
--   vim.keymap.set(mode, lhs, rhs, opts)
--
-- Modes (string or table of strings, e.g. { 'n', 'v' }):
--   'n' = Normal          'i' = Insert          'c' = Command-line
--   'v' = Visual + Select 'x' = Visual only     's' = Select only
--   't' = Terminal        'o' = Operator-pending
--
-- Arguments:
--   lhs  = Keys to press (e.g. '<leader>w', '<C-s>', '<M-j>', '<S-Tab>')
--   rhs  = Action: key sequence ('"+y'), Ex command ('<cmd>w<CR>'), or Lua function
--   opts = Optional table:
--     desc   = 'Description' (shown in which-key)
--     silent = true          (don't echo command in command line)
--     remap  = true          (allow recursive mapping; default is false)
--     expr   = true          (rhs is an expression/function returning keys to run)
--     buffer = true / bufnr  (buffer-local mapping)
--
-- Examples:
--   vim.keymap.set('n', '<leader>w', '<cmd>w<CR>', { desc = 'Save file' })
--   vim.keymap.set({ 'n', 'v' }, '<leader>x', function() print('hi') end, { desc = 'Run Lua', silent = true })

-- Quickly yank to system clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y', { desc = 'Yank to clipboard (motion)' })
vim.keymap.set('n', '<leader>yy', '"+yy', { desc = 'Yank line to clipboard' })
vim.keymap.set('n', '<leader>Y', '"+Y', { desc = 'Yank line to clipboard (from current position)' })
vim.keymap.set('n', '<leader>a', ':%y+<CR>', { desc = 'Yank all to clipboard' })

-- Quickly cut to system clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>d', '"+d', { desc = 'Cut to clipboard (motion)' })
vim.keymap.set('n', '<leader>dd', '"+dd', { desc = 'Cut line to clipboard' })
vim.keymap.set('n', '<leader>D', '"+D', { desc = 'Cut line to clipboard (from current position)' })

-- Quickly paste from system clipboard
vim.keymap.set('n', '<leader>p', '"+p', { desc = 'Paste after from clipboard' })
vim.keymap.set('v', '<leader>p', '"+p', { desc = 'Paste (visual) from clipboard' })
vim.keymap.set('n', '<leader>P', '"+P', { desc = 'Paste before from clipboard' })
vim.keymap.set('v', '<leader>P', '"+P', { desc = 'Paste before (visual) from clipboard' })

-- Stay in visual mode when indenting
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- <S-Tab> for left indentation
vim.keymap.set('i', '<S-Tab>', '<C-d>')

-- Center screen when scrolling with <C-u> and <C-d>
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Keybinds to make split navigation easier.
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
