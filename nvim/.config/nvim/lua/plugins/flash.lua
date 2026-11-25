vim.pack.add { 'https://github.com/folke/flash.nvim' }

require('flash').setup {
  modes = {
    search = { enabled = false },
    char = {
      enabled = true,
      jump_labels = false,
      multi_line = false,
      highlight = {
        backdrop = false,
        priority = 9000,
      },
    },
  },
}

local function set_flash_hl()
  local hl = { fg = '#fce566', bg = '#222222', bold = true, reverse = true }
  vim.api.nvim_set_hl(0, 'FlashMatch', hl)
  vim.api.nvim_set_hl(0, 'FlashCurrent', hl)
  vim.api.nvim_set_hl(0, 'FlashLabel', hl)
end

vim.schedule(set_flash_hl)
vim.api.nvim_create_autocmd('ColorScheme', {
  group = vim.api.nvim_create_augroup('custom-flash-hl', { clear = true }),
  callback = set_flash_hl,
})
