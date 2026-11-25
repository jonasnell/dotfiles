vim.pack.add { { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' } }

local ts = require('nvim-treesitter')

local parsers = {
  'bash',
  'bibtex',
  'c',
  'diff',
  'html',
  'latex',
  'lua',
  'luadoc',
  'markdown',
  'markdown_inline',
  'python',
  'query',
  'rust',
  'toml',
  'vim',
  'vimdoc',
}
ts.install(parsers)

local function attach(buf, lang)
  if not vim.api.nvim_buf_is_valid(buf) then return end
  if not vim.treesitter.language.add(lang) then return end

  vim.treesitter.start(buf, lang)

  if vim.treesitter.query.get(lang, 'indents') ~= nil then
    vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end
end

local available = ts.get_available()

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('custom-treesitter', { clear = true }),
  callback = function(ev)
    local buf = ev.buf
    local lang = vim.treesitter.language.get_lang(ev.match)
    if not lang then return end

    if vim.tbl_contains(ts.get_installed 'parsers', lang) then
      attach(buf, lang)
    elseif vim.tbl_contains(available, lang) then
      ts.install(lang):await(function() attach(buf, lang) end)
    else
      attach(buf, lang)
    end
  end,
})
