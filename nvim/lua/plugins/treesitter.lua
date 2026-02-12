return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    opts = {

      -- A list of parser names, or "all"
      ensure_installed = { "lua", "python", "c_sharp", "javascript", "css", "java", "c" },
      autotag = {
        enabled = true,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<CR>",
          node_incremental = "<CR>",
          scope_incremental = "<S-TAB>",
          node_decremental = "<TAB>",
        },
      },

      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,

      highlight = {
        enable = true,

        -- additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true
      }
    },
    config = function(ts, opts)
      vim.opt.foldmethod = 'expr'
      vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
      vim.opt.foldenable = true
      vim.opt.foldlevel = 20
      require("nvim-treesitter.configs").setup(opts)
      -- ts.setup(opts)
    end
  },
  {
    "nvim-treesitter/playground",
    command = "TSPlaygroundToggle",
    dependencies = "nvim-treesitter/nvim-treesitter"
  },
}
