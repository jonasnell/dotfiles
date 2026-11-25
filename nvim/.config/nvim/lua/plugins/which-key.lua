vim.pack.add { 'https://github.com/folke/which-key.nvim' }

require('which-key').setup {
  delay = 500,
  icons = { mappings = vim.g.have_nerd_font },
  spec = {
    { '<leader>b', group = '[B]uffer' },
    { '<leader>g', group = '[G]it' },
    { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
    { '<leader>s', group = '[S]earch', mode = { 'n', 'v' } },
    { '<leader>t', group = '[T]oggle' },
    { 'gr', group = 'LSP Actions', mode = { 'n' } },
    { 'gz', group = 'Surround', mode = { 'n', 'x' } },
  },
}
