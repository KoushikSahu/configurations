return {
  "ray-x/lsp_signature.nvim",
  event = "VeryLazy",
  opts = {},
  config = function()
    require 'lsp_signature'.setup {
      bind = true, -- This is mandatory, otherwise border config won't get registered.
      handler_opts = {
        border = "rounded"
      },
      hi_parameter = "IncSearch",
      timer_interval = 50,
    }
  end
}
