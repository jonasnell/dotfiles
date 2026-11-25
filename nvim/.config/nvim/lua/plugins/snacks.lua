vim.pack.add { 'https://github.com/folke/snacks.nvim' }

local header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]]

local function colored_header()
  local lines = vim.split(header, '\n')
  local chunks = {}
  for i, line in ipairs(lines) do
    for ch in line:gmatch '[%z\1-\127\194-\244][\128-\191]*' do
      local hl = (ch == '█') and 'SnacksDashboardHeader' or 'SnacksDashboardHeaderShadow'
      table.insert(chunks, { ch, hl = hl })
    end
    if i < #lines then table.insert(chunks, { '\n' }) end
  end
  return chunks
end

require('snacks').setup {
  lazygit = { enabled = true },
  dashboard = {
    enabled = true,
    sections = {
      { text = colored_header(), align = 'center', padding = 2 },
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

vim.api.nvim_set_hl(0, 'SnacksDashboardHeader', { fg = '#fd9353' })
vim.api.nvim_set_hl(0, 'SnacksDashboardHeaderShadow', { fg = '#5ad4e6' })
vim.api.nvim_set_hl(0, 'SnacksDashboardIcon', { fg = '#7bd88f' })
vim.api.nvim_set_hl(0, 'SnacksDashboardDesc', { fg = '#f7f1ff' })
vim.api.nvim_set_hl(0, 'SnacksDashboardKey', { fg = '#5ad4e6', bold = true })
vim.api.nvim_set_hl(0, 'SnacksDashboardFooter', { fg = '#69676c' })

vim.keymap.set('n', '<leader>gg', function() Snacks.lazygit() end, { desc = 'Open Lazy[g]it' })
