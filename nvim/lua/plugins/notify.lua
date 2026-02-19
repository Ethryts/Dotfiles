return {
  "rcarriga/nvim-notify",
  opts = {},
  config = function(_, opts)
    vim.notify = require("notify")
    require("notify").setup(opts)
  end
}
