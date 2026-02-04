return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { '<leader>ff', "<cmd>FzfLua files<cr>",                 "Find File" },
    { '<leader>fg', "<cmd>FzfLua live_grep<cr>",             "Find Grep" },
    { '<leader>fc', "<cmd>FzfLua commands<cr>",              "Find Commands" },
    { '<leader>fq', "<cmd>FzfLua quickfix<cr>",              "Find Quickfix" },
    { '<leader>fb', "<cmd>FzfLua buffers<cr>",               "Find Buffers" },
    { '<leader>fh', "<cmd>FzfLua help_tags<cr>",             "Find Help Tags" },
    { '<leader>fd', "<cmd>FzfLua diagnostics_workspace<cr>", "Find Diagnostics" },
    { '<leader>ft', "<cmd>FzfLua builtin<cr>",               "Find Pickers" }
  },
  opts = function(_, opts)
    local fzf = require("fzf-lua")
    return {
      fzf_opts = {
        ["--bind"] = {
          ["tab:toggle"] = "",
          ["ctrl-space:toggle+down"] = "",
        },
      },
      keymap = {
        builtin = {
          ["<C-u>"] = "preview-page-up",
          ["<C-d>"] = "preview-page-down",
        }
      },
      actions = {
        files = {
          ["ctrl-y"] = fzf.actions.file_edit_or_qf,
        }
      }
    }
  end
}
