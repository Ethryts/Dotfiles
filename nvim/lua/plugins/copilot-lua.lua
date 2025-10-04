return {
    "zbirenbaum/copilot.lua",
    dependencies = {
        "copilotlsp-nvim/copilot-lsp", -- (optional) for NES functionality
    },
    opts = function()
        vim.env.NODE_EXTRA_CA_CERTS = "/etc/ssl/certs/ca-certificates.crt"
        vim.env.NODE_OPTIONS = "--use-openssl-ca"
        return {
            logger = {
                file_log_level = vim.log.levels.DEBUG,
            },
            pannel = {
                enabled = false,
            },
            suggestion = {
                keymap = {
                    accept = "<C-y>",
                    accept_word = "<C-l>",
                    next = "<C-n>",
                    prev = "<C-p>",
                    dismiss = "<C-e>",
                },
                auto_trigger = true,
            },
            nes = {
                enabled = true,
                auto_trigger = true,
            },
        }
    end
}
