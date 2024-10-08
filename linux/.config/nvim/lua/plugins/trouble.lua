map('n', '<leader>tt', '<cmd>Trouble diagnostics toggle focus=true<CR>', { silent = true })

return {
  'folke/trouble.nvim',
  cmd = { 'Trouble' },
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function() require("trouble").setup {} end
}
