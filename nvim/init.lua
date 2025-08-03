-- Load minimal config when running inside VSCode
if vim.g.vscode then
  require 'config.vscode'
  return
end

-- Otherwise load full config
require 'config'

require 'config.core.autocmds'
require 'config.core.keymaps'
require 'config.core.options'

require 'config.plugins'

require 'config.lsp'
