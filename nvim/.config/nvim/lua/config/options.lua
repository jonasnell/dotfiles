-- [[ Leader & Globals ]]
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

-- [[ UI & Appearance ]]
vim.o.number = true          -- Show line numbers
vim.o.relativenumber = true  -- Show relative line numbers
vim.o.signcolumn = 'yes'     -- Keep signcolumn on by default
vim.o.cursorline = true      -- Highlight the current line
vim.o.scrolloff = 10         -- Minimum lines to keep above/below cursor
vim.o.showmode = false       -- Hide mode (already shown in statusline)
vim.o.ruler = false          -- Hide built-in ruler when statusline is hidden
vim.o.laststatus = 3         -- Single global statusline across all splits
vim.o.fillchars = 'eob: '    -- Hide ~ symbol on empty lines

-- [[ Indentation ]]
vim.o.tabstop = 2            -- Number of spaces a <Tab> counts for
vim.o.shiftwidth = 2         -- Number of spaces for auto-indent
vim.o.softtabstop = 2        -- Number of spaces <Tab> inserts
vim.o.expandtab = true       -- Use spaces instead of tabs
vim.o.breakindent = true     -- Preserve indentation on wrapped lines

-- [[ Search & Replace ]]
vim.o.ignorecase = true      -- Case-insensitive search...
vim.o.smartcase = true       -- ...unless \C or capital letters are used
vim.o.inccommand = 'split'   -- Preview substitutions live in a split

-- [[ Splits & Behavior ]]
vim.o.splitright = true      -- Open vertical splits to the right
vim.o.splitbelow = true      -- Open horizontal splits below
vim.o.mouse = 'a'            -- Enable mouse support
vim.o.undofile = true        -- Save persistent undo history
vim.o.confirm = true         -- Prompt to save on unsaved close
vim.o.updatetime = 250       -- Faster CursorHold / swap write
vim.o.timeoutlen = 300       -- Faster mapped sequence timeout

-- [[ Diagnostics ]]
vim.diagnostic.config {
  update_in_insert = false,
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = { min = vim.diagnostic.severity.WARN } },
  virtual_text = true,   -- Show diagnostics at end of line
  virtual_lines = false, -- Show diagnostics underneath the line
  jump = {
    -- Auto-open float when jumping with `[d` and `]d`
    on_jump = function(_, bufnr)
      vim.diagnostic.open_float {
        bufnr = bufnr,
        scope = 'cursor',
        focus = false,
      }
    end,
  },
}
