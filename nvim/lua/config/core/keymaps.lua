-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Quickly yank to system clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y', { desc = 'Yank to clipboard (motion)' })
vim.keymap.set('n', '<leader>yy', '"+yy', { desc = 'Yank line to clipboard' })
vim.keymap.set('n', '<leader>Y', '"+Y', { desc = 'Yank line to clipboard (from current position)' })

-- Quickly cut to system clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>d', '"+d', { desc = 'Cut to clipboard (motion)' })
vim.keymap.set('n', '<leader>dd', '"+dd', { desc = 'Cut line to clipboard' })
vim.keymap.set('n', '<leader>D', '"+D', { desc = 'Cut line to clipboard (from current position)' })

-- Quickly paste from system clipboard
vim.keymap.set('n', '<leader>p', '"+p', { desc = 'Paste after from clipboard' })
vim.keymap.set('v', '<leader>p', '"+p', { desc = 'Paste (visual) from clipboard' })
vim.keymap.set('n', '<leader>P', '"+P', { desc = 'Paste before from clipboard' })
vim.keymap.set('v', '<leader>P', '"+P', { desc = 'Paste before (visual) from clipboard' })

-- Center screen when scrolling with <C-u> and <C-d>
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

