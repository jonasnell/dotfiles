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

-- [[ General & Files ]]
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlights' })
vim.keymap.set('n', '<leader>w', '<cmd>w<CR>', { desc = '[W]rite file' })
vim.keymap.set('n', '<leader>q', function() require('mini.bufremove').delete(0, false) end, { desc = '[Q]uit (close) buffer' })
vim.keymap.set('n', '<leader>Q', '<cmd>qa<CR>', { desc = '[Q]uit all' })

-- [[ Clipboard ]]
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y', { desc = 'Yank to clipboard' })
vim.keymap.set('n', '<leader>yy', '"+yy', { desc = 'Yank line to clipboard' })
vim.keymap.set('n', '<leader>Y', '"+Y', { desc = 'Yank line to clipboard (from cursor)' })
vim.keymap.set('n', '<leader>a', '<cmd>%y+<CR>', { desc = 'Yank all to clipboard' })

vim.keymap.set({ 'n', 'v' }, '<leader>d', '"+d', { desc = 'Cut to clipboard' })
vim.keymap.set('n', '<leader>dd', '"+dd', { desc = 'Cut line to clipboard' })
vim.keymap.set('n', '<leader>D', '"+D', { desc = 'Cut line to clipboard (from cursor)' })

vim.keymap.set({ 'n', 'v' }, '<leader>p', '"+p', { desc = 'Paste after from clipboard' })
vim.keymap.set({ 'n', 'v' }, '<leader>P', '"+P', { desc = 'Paste before from clipboard' })

-- [[ Editing ]]
vim.keymap.set('i', '<S-Tab>', '<C-d>', { desc = 'Unindent line' })
vim.keymap.set('v', '<', '<gv', { desc = 'Indent left and reselect' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent right and reselect' })
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })

-- [[ Navigation & Scrolling ]]
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up and center' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down and center' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next search match (centered)' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Prev search match (centered)' })

-- [[ Buffers ]]
vim.keymap.set('n', '<S-h>', '<cmd>bprevious<CR>', { desc = 'Previous buffer' })
vim.keymap.set('n', '<S-l>', '<cmd>bnext<CR>', { desc = 'Next buffer' })
vim.keymap.set('n', '<leader>bb', '<cmd>e #<CR>', { desc = 'Switch to alternate buffer' })

-- [[ Windows & Splits ]]
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<C-Up>', '<cmd>resize +2<CR>', { desc = 'Increase window height' })
vim.keymap.set('n', '<C-Down>', '<cmd>resize -2<CR>', { desc = 'Decrease window height' })
vim.keymap.set('n', '<C-Left>', '<cmd>vertical resize -2<CR>', { desc = 'Decrease window width' })
vim.keymap.set('n', '<C-Right>', '<cmd>vertical resize +2<CR>', { desc = 'Increase window width' })

-- [[ Diagnostics & Terminal ]]
vim.keymap.set('n', '<leader>drq', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
