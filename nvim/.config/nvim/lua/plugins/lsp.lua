vim.pack.add {
  'https://github.com/folke/lazydev.nvim',
  'https://github.com/j-hui/fidget.nvim',
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/mason-org/mason.nvim',
  'https://github.com/mason-org/mason-lspconfig.nvim',
  'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim',
}

require('lazydev').setup {
  library = {
    { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
  },
}
require('fidget').setup {}

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('user-lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode) vim.keymap.set(mode or 'n', keys, func, { buf = event.buf, desc = 'LSP: ' .. desc }) end

    map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method('textDocument/documentHighlight', event.buf) then
      local hl_group = vim.api.nvim_create_augroup('user-lsp-highlight', { clear = false })
      vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
        buffer = event.buf,
        group = hl_group,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
        buffer = event.buf,
        group = hl_group,
        callback = vim.lsp.buf.clear_references,
      })
      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('user-lsp-detach', { clear = true }),
        callback = function(ev)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'user-lsp-highlight', buffer = ev.buf }
        end,
      })
    end

    if client and client:supports_method('textDocument/inlayHint', event.buf) then
      map('<leader>th', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end, '[T]oggle Inlay [H]ints')
    end
  end,
})

---@type table<string, vim.lsp.Config>
local servers = {
  -- Lua
  lua_ls = {
    -- Formatting delegated to stylua via conform.nvim
    on_init = function(client) client.server_capabilities.documentFormattingProvider = false end,
    settings = { Lua = { format = { enable = false } } },
  },

  -- Python (basedpyright for types/hover, ruff for fast linting & fixes)
  basedpyright = {
    settings = {
      basedpyright = {
        analysis = { typeCheckingMode = 'standard' },
      },
    },
  },
  ruff = {
    -- Let basedpyright handle hover docs
    on_attach = function(client) client.server_capabilities.hoverProvider = false end,
  },

  -- Rust, Bash, Markdown, LaTeX
  rust_analyzer = {},
  bashls = {},
  marksman = {},
  texlab = {},
}

require('mason').setup {}
require('mason-lspconfig').setup { automatic_enable = false }

local ensure_installed = vim.tbl_keys(servers)
vim.list_extend(ensure_installed, {
  'stylua', -- Lua formatter
  'shfmt', -- Bash formatter
  'shellcheck', -- Used automatically by bashls for Bash linting
  'tex-fmt', -- Fast Rust LaTeX formatter
  'prettier', -- Markdown formatter (manual <leader>f)
})
require('mason-tool-installer').setup { ensure_installed = ensure_installed }

for name, config in pairs(servers) do
  vim.lsp.config(name, config)
  vim.lsp.enable(name)
end
