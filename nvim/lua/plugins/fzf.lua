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
    { '<leader>ft', "<cmd>FzfLua builtin<cr>",               "Find Pickers" },
    { '<leader>fp',
      function()
        require("fzf-lua").files({
          cwd = "~/dev/",
          -- cmd = "find . -maxdepth 2 -type d -not -path '*/.*'",
          cmd = "fd --max-depth 2 --type d --hidden --exclude .git",
          previewer = false,
          fzf_opts = {
            ['--tiebreak'] = 'length',
            ['--preview'] = [[
               # Display directory size along with contents for better context
               target=~/dev/$(echo {} | sed 's/^[^\.a-zA-Z0-9\/]*//')
               echo $target
               ls -lhF --color=always "$target" | awk '{printf "%-30s %-10s %-40s\n", $9, $5, $6" "$7" "$8}'
               # Pad file listing to always show exactly 10 lines
               count=$(ls -1 "$target" | wc -l)
               pad=$((10 - count))
               if [ $pad -gt 0 ]; then
                  for i in $(seq 1 $pad); do
                    echo ""
                  done
               fi
               # Find and preview the first readme with syntax highlighting
                readme=$(fd --max-depth 2 --type f "readme.*" "$target"  | head -n 1)
                if [ -f "$readme" ]; then
                  echo "Previewing README:"
                  bat --style=header,grid --color=always "$readme"
                else
                  echo "No README file found"
                fi
               # Show the total disk usage of the target directory
               echo "Directory size:"
               du -sh "$target" | awk '{printf "%-10s %-20s\n", $1, $2}'
              ]]
          },
          prompt = "Dirs>",
          actions = {
            ["default"] = function(selected)
              local fzf = require("fzf-lua")
              local entry = fzf.path.entry_to_file(selected[1])
              local dir = entry.path
              vim.cmd("cd ~/dev/" .. dir)
              require("fzf-lua").files()
            end,
          },



        })
      end
      , "Find Projects" }
  },
  ---@module 'fzf-lua'
  ---@type fzf-lua.config
  ---@diagnostic disable-next-line: missing-fields
  opts = {
    fzf_opts = {
      ["--bind"] = {
        ["tab:toggle"] = "",
        ["ctrl-space:toggle+down"] = "",
      },
    },
    keymap = {
      fzf = {
        ["ctrl-y"] = "accept",
        ["ctrl-u"] = "preview-page-up",
        ["ctrl-d"] = "preview-page-down",
      },
      builtin = {
        ["<C-v>"] = "file_vsplit",
        ["<C-x>"] = "file_split",
        ["<C-t>"] = "file_tabedit",
      }
    },
  },
  config = function(_, opts)
    require("fzf-lua").setup(opts)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "fzf",
      callback = function(ev)
        vim.keymap.set("t", "jk", "<Nop>", { buffer = ev.buf, silent = true, desc = "Disable jk in FzfLua" })
      end
    })
  end,
}
