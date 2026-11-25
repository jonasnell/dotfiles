vim.pack.add { 'https://github.com/lukas-reineke/indent-blankline.nvim' }

local highlight = {
  'Red',
  'Yellow',
  'Green',
  'Blue',
  'Purple',
}

local hooks = require 'ibl.hooks'

hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  vim.api.nvim_set_hl(0, 'Red', { fg = '#432B32' })
  vim.api.nvim_set_hl(0, 'Yellow', { fg = '#433F2C' })
  vim.api.nvim_set_hl(0, 'Green', { fg = '#2F3D32' })
  vim.api.nvim_set_hl(0, 'Blue', { fg = '#2A3D40' })
  vim.api.nvim_set_hl(0, 'Purple', { fg = '#33323F' })
end)

require('ibl').setup {
  indent = {
    highlight = highlight,
  },
  scope = {
    enabled = false,
  },
}
