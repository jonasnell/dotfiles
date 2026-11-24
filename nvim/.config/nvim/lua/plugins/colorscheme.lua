vim.pack.add { 'https://github.com/loctvl842/monokai-pro.nvim' }

---@diagnostic disable-next-line: missing-fields
require('monokai-pro').setup {
  transparent_background = false,
  terminal_colors = true,
  devicons = true,
  filter = 'spectrum',
  styles = {
    comment = { italic = true },
    keyword = { italic = true },
    type = { italic = true },
    storageclass = { italic = true },
    structure = { italic = true },
    parameter = { italic = true },
    annotation = { italic = true },
    tag_attribute = { italic = true },
  },
  override_palette = function()
    return {
      background = '#262626',
      dark1 = '#222222',
      dark2 = '#1c1c1c',
      text = '#f7f1ff',
      accent1 = '#fc618d', -- red/pink
      accent2 = '#fd9353', -- orange
      accent3 = '#fce566', -- yellow
      accent4 = '#7bd88f', -- green
      accent5 = '#5ad4e6', -- cyan/blue
      accent6 = '#948ae3', -- purple
    }
  end,
}

vim.cmd.colorscheme 'monokai-pro'
