return {
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
        input = {},
        indent = {},
        statuscolumn = {
            left = { "mark", "sign"},     -- priority of signs on the left (high to low)
            right = {"fold", "git" },
            -- right = { },     -- priority of signs on the right (high to low)
            folds = {
                open = false,              -- show open fold icons
                git_hl = false,            -- use Git Signs hl for fold icons
            },
            git = {
                -- patterns to match Git signs
                patterns = { "GitSign", "MiniDiffSign" },
            },
            refresh = 50,     -- refresh at most every 50ms


        },
        ------@class snacks.notifier.Config
        ------@field enabled? boolean
        ------@field keep? fun(notif: snacks.notifier.Notif): boolean # global keep function
        ------@field filter? fun(notif: snacks.notifier.Notif): boolean # filter our unwanted notifications (return false to hide)
        ---notifier = {
        ---    margin = {top=1}
        ---},
    }
}
