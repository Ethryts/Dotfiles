return {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    -- or if using mini.icons/mini.nvim
    -- dependencies = { "echasnovski/mini.icons" },
    opts = function(_, opts)
        local fzf = require("fzf-lua")

        return {
            keymap = {
                builtin={
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
