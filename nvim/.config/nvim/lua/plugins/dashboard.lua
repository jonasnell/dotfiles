vim.pack.add { 'https://github.com/folke/snacks.nvim' }

-- Change accent to '#7bd88f' (green) or '#5ad4e6' (cyan/blue)
local accent = '#7bd88f'

local function set_dashboard_hl()
  vim.api.nvim_set_hl(0, 'SnacksDashboardHeader', { fg = accent })
  vim.api.nvim_set_hl(0, 'SnacksDashboardIcon', { fg = accent })
  vim.api.nvim_set_hl(0, 'SnacksDashboardKey', { fg = '#5ad4e6', bold = true })
  vim.api.nvim_set_hl(0, 'SnacksDashboardDesc', { fg = '#f7f1ff' })
  vim.api.nvim_set_hl(0, 'SnacksDashboardFooter', { fg = '#69676c' })
end

set_dashboard_hl()
vim.api.nvim_create_autocmd('ColorScheme', {
  group = vim.api.nvim_create_augroup('custom-dashboard-hl', { clear = true }),
  callback = set_dashboard_hl,
})

require('snacks').setup {
  dashboard = {
    enabled = true,
    sections = {
      { section = 'header' },
      { section = 'keys', gap = 1, padding = 1 },
    },
    preset = {
      keys = {
        { icon = ' ', key = 'f', desc = 'Find File', action = ':Telescope find_files' },
        { icon = ' ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
        { icon = ' ', key = 'g', desc = 'Find Text', action = ':Telescope live_grep' },
        { icon = ' ', key = 'r', desc = 'Recent Files', action = ':Telescope oldfiles' },
        { icon = ' ', key = 'c', desc = 'Config', action = ":lua require('telescope.builtin').find_files({ cwd = vim.fn.stdpath('config') })" },
        { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
      },
    },
  },
}
