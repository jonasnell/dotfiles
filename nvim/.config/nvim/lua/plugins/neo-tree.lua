vim.pack.add {
  { src = 'https://github.com/nvim-neo-tree/neo-tree.nvim', version = vim.version.range '*' },
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/MunifTanjim/nui.nvim',
}

vim.keymap.set('n', '<leader>e', '<Cmd>Neotree dir=. toggle reveal<CR>', { desc = 'Toggle [E]xplorer', silent = true })
vim.keymap.set('n', '\\', '<Cmd>Neotree reveal<CR>', { desc = 'NeoTree reveal', silent = true })

require('neo-tree').setup {
  window = {
    position = 'left',
    width = 35,
    mappings = {
      ['<space>'] = 'none', -- Keep <leader> usable while focused inside neo-tree
      ['\\'] = 'close_window',
    },
  },
  filesystem = {
    follow_current_file = { enabled = true },
  },
}

local function set_neotree_hl()
  local bg = '#262626'
  vim.api.nvim_set_hl(0, 'NeoTreeNormal', { bg = bg })
  vim.api.nvim_set_hl(0, 'NeoTreeNormalNC', { bg = bg })
  vim.api.nvim_set_hl(0, 'NeoTreeEndOfBuffer', { fg = bg, bg = bg })
  vim.api.nvim_set_hl(0, 'NeoTreeSignColumn', { bg = bg })
  vim.api.nvim_set_hl(0, 'NeoTreeWinSeparator', { fg = '#69676c', bg = bg })
  vim.api.nvim_set_hl(0, 'NeoTreeStatusLine', { fg = '#f7f1ff', bg = bg })
  vim.api.nvim_set_hl(0, 'NeoTreeStatusLineNC', { fg = '#69676c', bg = bg })
end

vim.schedule(set_neotree_hl)
vim.api.nvim_create_autocmd('ColorScheme', {
  group = vim.api.nvim_create_augroup('custom-neotree-hl', { clear = true }),
  callback = set_neotree_hl,
})
