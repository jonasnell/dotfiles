vim.pack.add { 'https://github.com/nvim-mini/mini.nvim' }

-- If a nerd font is available, load the icons module for pretty icons in various plugins.
if vim.g.have_nerd_font then
  require('mini.icons').setup()
  -- Used for backwards compatibility with plugins that require `nvim-web-devicons` (e.g. telescope.nvim)
  MiniIcons.mock_nvim_web_devicons()
end

-- Better Around/Inside textobjects
--
-- Examples:
--  - va)  - [V]isually select [A]round [)]paren
--  - yiiq - [Y]ank [I]nside [I]+1 [Q]uote
--  - ci'  - [C]hange [I]nside [']quote
require('mini.ai').setup {
  -- NOTE: Avoid conflicts with the built-in incremental selection mappings on Neovim>=0.12 (see `:help treesitter-incremental-selection`)
  mappings = {
    around_next = 'aa',
    inside_next = 'ii',
  },
  n_lines = 500,
}

-- Add/delete/replace surroundings (brackets, quotes, etc.)
--
-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
-- - sd'   - [S]urround [D]elete [']quotes
-- - sr)'  - [S]urround [R]eplace [)] [']
require('mini.surround').setup {
  -- This rebinds all commands to start with 'gz' instead of 's'
  mappings = {
    add = 'gza', -- Add surrounding
    delete = 'gzd', -- Delete surrounding
    find = 'gzf', -- Find surrounding (right)
    find_left = 'gzF', -- Find surrounding (left)
    highlight = 'gzh', -- Highlight surrounding
    replace = 'gzr', -- Replace surrounding
    update_n_lines = 'gzn', -- Update n_lines
    suffix_last = 'l', -- Suffix for left
    suffix_next = 'n', -- Suffix for next
  },
}

local statusline = require 'mini.statusline'

local palette = {
  bg = '#262626',
  bg_dark = '#222222',
  pill_bg = '#363537',
  fg_light = '#f7f1ff',
  fg_muted = '#69676c',
  green = '#7bd88f',
  cyan = '#5ad4e6',
  purple = '#948ae3',
  yellow = '#fce566',
  red = '#fc618d',
  orange = '#fd9353',
}

local mode_hl_map = {
  MiniStatuslineModeNormal = 'StatusPillModeNormal',
  MiniStatuslineModeInsert = 'StatusPillModeInsert',
  MiniStatuslineModeVisual = 'StatusPillModeVisual',
  MiniStatuslineModeReplace = 'StatusPillModeReplace',
  MiniStatuslineModeCommand = 'StatusPillModeCommand',
  MiniStatuslineModeOther = 'StatusPillModeOther',
}

local function set_statusline_hl()
  local hl = vim.api.nvim_set_hl

  hl(0, 'StatusLine', { fg = palette.fg_light, bg = palette.bg })
  hl(0, 'StatusLineNC', { fg = palette.fg_muted, bg = palette.bg })

  local modes = {
    StatusPillModeNormal = palette.green,
    StatusPillModeInsert = palette.cyan,
    StatusPillModeVisual = palette.purple,
    StatusPillModeReplace = palette.red,
    StatusPillModeCommand = palette.yellow,
    StatusPillModeOther = palette.orange,
  }
  for group, color in pairs(modes) do
    hl(0, group, { fg = palette.bg_dark, bg = color, bold = true })
    hl(0, group .. 'Cap', { fg = color, bg = palette.bg })
  end

  hl(0, 'StatusPillDim', { fg = palette.fg_light, bg = palette.pill_bg })
  hl(0, 'StatusPillDimBold', { fg = palette.fg_light, bg = palette.pill_bg, bold = true })
  hl(0, 'StatusPillCyan', { fg = palette.cyan, bg = palette.pill_bg })
  hl(0, 'StatusPillDimCap', { fg = palette.pill_bg, bg = palette.bg })
end

local function pill(body_hl, cap_hl, text)
  if not text or text == '' then return '' end
  return string.format('%%#%s#%%#%s#%s%%#%s#%%#StatusLine#', cap_hl, body_hl, text, cap_hl)
end

statusline.setup {
  use_icons = vim.g.have_nerd_font,
  content = {
    active = function()
      local mode, mode_hl = statusline.section_mode { trunc_width = 120 }
      local git = statusline.section_git { trunc_width = 40 }
      local diff = statusline.section_diff { trunc_width = 75 }
      local diagnostics = statusline.section_diagnostics { trunc_width = 75 }
      local filename = statusline.section_filename { trunc_width = 140 }
      local fileinfo = statusline.section_fileinfo { trunc_width = 120 }
      local location = '%l:%v'

      local pill_hl = mode_hl_map[mode_hl] or 'StatusPillModeOther'
      local left = { pill(pill_hl, pill_hl .. 'Cap', mode) }

      local devinfo = table.concat(vim.tbl_filter(function(s) return s ~= '' end, { git, diff, diagnostics }), ' ')
      if devinfo ~= '' then table.insert(left, pill('StatusPillDim', 'StatusPillDimCap', devinfo)) end

      local right = {}
      if fileinfo ~= '' then table.insert(right, pill('StatusPillCyan', 'StatusPillDimCap', fileinfo)) end
      table.insert(right, pill('StatusPillDimBold', 'StatusPillDimCap', location))

      return table.concat(left, ' ') .. ' %<' .. filename .. ' %=' .. table.concat(right, ' ')
    end,
    inactive = function()
      local filename = statusline.section_filename { trunc_width = 140 }
      return '%#StatusLineNC# ' .. filename .. ' %='
    end,
  },
}

set_statusline_hl()
vim.api.nvim_create_autocmd('ColorScheme', {
  group = vim.api.nvim_create_augroup('custom-statusline-hl', { clear = true }),
  callback = set_statusline_hl,
})

-- ... and there is more!
--  Check out: https://github.com/nvim-mini/mini.nvim
