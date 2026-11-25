-- Plugin management:
--   :lua vim.pack.update()                        -- update all plugins
--   :lua vim.pack.update(nil, { offline = true }) -- inspect plugin status
--   :lua vim.pack.del({ 'plugin-name' })          -- remove unused plugin

local function run_build(name, cmd, cwd)
  local result = vim.system(cmd, { cwd = cwd }):wait()
  if result.code ~= 0 then
    local stderr = result.stderr or ''
    local stdout = result.stdout or ''
    local output = stderr ~= '' and stderr or stdout
    if output == '' then output = 'No output from build command.' end
    vim.notify(('Build failed for %s:\n%s'):format(name, output), vim.log.levels.ERROR)
  end
end

-- Runs after plugin is installed/updated, running build if necessary
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if kind ~= 'install' and kind ~= 'update' then return end

    if name == 'telescope-fzf-native.nvim' and vim.fn.executable 'make' == 1 then
      run_build(name, { 'make' }, ev.data.path)
    elseif name == 'nvim-treesitter' then
      if not ev.data.active then vim.cmd.packadd 'nvim-treesitter' end
      vim.cmd 'TSUpdate'
    end
  end,
})

-- UI & appearance (load theme and icons first for downstream plugins)
require('plugins.colorscheme')
require('plugins.mini')
require('plugins.dashboard')
require('plugins.indent_line')
require('plugins.gitsigns')
require('plugins.which-key')

-- Navigation & editing
require('plugins.telescope')
require('plugins.neo-tree')
require('plugins.flash')
require('plugins.autopairs')
require('plugins.guess-indent')
require('plugins.practice')

-- Coding & LSP (load completion before lsp for capabilities)
require('plugins.completion')
require('plugins.lsp')
require('plugins.conform')
require('plugins.treesitter')
