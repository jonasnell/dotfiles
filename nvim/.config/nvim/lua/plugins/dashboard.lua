vim.pack.add { 'https://github.com/folke/snacks.nvim' }

local function set_dashboard_hl()
  vim.api.nvim_set_hl(0, 'SnacksDashboardHeader', { fg = '#7bd88f' })
  vim.api.nvim_set_hl(0, 'SnacksDashboardIcon', { fg = '#5ad4e6' })
  vim.api.nvim_set_hl(0, 'SnacksDashboardDesc', { fg = '#f7f1ff' })
  vim.api.nvim_set_hl(0, 'SnacksDashboardKey', { fg = '#fd9353', bold = true })
  vim.api.nvim_set_hl(0, 'SnacksDashboardFooter', { fg = '#69676c' })
end

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

vim.api.nvim_create_autocmd('User', {
  group = vim.api.nvim_create_augroup('custom-dashboard-hl', { clear = true }),
  pattern = 'SnacksDashboardOpened',
  callback = function() vim.schedule(set_dashboard_hl) end,
})
