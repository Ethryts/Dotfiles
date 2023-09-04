telescope = require('telescope')

telescope.load_extension 'file_browser'
telescope.load_extension 'project'
telescope.load_extension 'lsp_handlers'
telescope.load_extension('glyph')
telescope.load_extension('harpoon')

telescope.setup {
    defaults = {
        winbled = 30,
        -- Default configuration for telescope goes here:
        -- config_key = value,
        file_ignore_patterns = {
            "node_modules",
            ".git"
        },
        mappings = {
            i = {
                -- map actions.which_key to <C-h> (default: <C-/>)
                -- actions.which_key shows the mappings for your picker,
                -- e.g. git_{create, delete, ...}_branch for the git_branches picker
                -- ["<C-h>"] = "which_key"
            }
        },

        borderchars = {
            prompt = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
            results = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
            preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
        },
    },
    pickers = {
        find_files = {
        },
        diagnostics = {
            sorting_strategy = "ascending",
            results_title = false,
            layout_strategy = "cursor",
            previewer = false,
            layout_config = {
                width = 120,
                height = 9,
                preview_width = 10,
            },
            borderchars = {
                prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
                results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
                preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
            },

        },
        quickfix = {



            -- Default configuration for builtin pickers goes here:
            -- picker_name = {
            --   picker_config_key = value,
            --   ...
            -- }
            -- Now the picker_config_key will be applied every time you call this
            -- builtin picker
        },
        extensions = {
            project = {
                theme = "dropdown"
            },

            -- Your extension configuration goes here:
            -- extension_name = {
            --   extension_config_key = value,
            -- }
            -- please take a look at the readme of the extension you want to configure

        }
    }
}

local builtin = require('telescope.builtin')
local themes = require('telescope.themes')
