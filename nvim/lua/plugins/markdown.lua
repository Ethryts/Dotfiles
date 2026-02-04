return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' },     -- if you use the mini.nvim suite
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      file_types = { 'markdown', 'codecompanion' },
    },
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    config = function()
      vim.cmd([[
            function OpenMarkdownPreview (url)
                " execute "silent ! start chrome --app=" . a:url
                " execute "silent !  chrome --app=" . a:url
                execute "silent ! open -a chrome.exe -n --args --new-window " . a:url
            endfunction
            let g:mkdp_browserfunc = 'OpenMarkdownPreview'
            ]])
    end,
    ft = { "markdown" },
  },

}
