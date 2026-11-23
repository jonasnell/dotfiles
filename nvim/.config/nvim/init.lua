-- Load minimal config when running inside VSCode
if vim.g.vscode then
  require('config.vscode')
  return
end

-- Enable faster startup by caching compiled Lua modules
vim.loader.enable()

require('config.options')
require('config.keymaps')
require('config.autocmds')
require('plugins')
