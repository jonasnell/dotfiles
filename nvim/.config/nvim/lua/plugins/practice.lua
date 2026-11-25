vim.pack.add { 'https://github.com/szymonwilczek/vim-be-better' }

-- Remove floating window background color only for :VimBeBetter
vim.api.nvim_create_autocmd('VimEnter', {
  once = true,
  callback = function()
    vim.api.nvim_create_user_command('VimBeBetter', function()
      require('vim-be-better').menu()
      vim.schedule(function() vim.wo.winhighlight = 'NormalFloat:Normal,FloatBorder:Normal' end)
    end, {})
  end,
})
