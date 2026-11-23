-- Load minimal config when running inside VSCode
if vim.g.vscode then
  require('config.vscode')
  return
end

-- Otherwise load full config
require('config')

require('config.autocmds')
require('config.options')
require('config.keymaps')
