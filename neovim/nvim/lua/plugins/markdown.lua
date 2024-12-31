return {
    {
        'MeanderingProgrammer/markdown.nvim',
        name = 'render-markdown', -- Only needed if you have another plugin named markdown.nvim
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' },   -- if you use the mini.nvim suite
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
        dependencies = {
            'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons'
        },                 -- if you prefer nvim-web-devicons
        ft = { 'markdown' }, -- Filetype to attach the plugin
        config = function() require('render-markdown').setup({}) end
    }, {
        "iamcco/markdown-preview.nvim",
        cmd = {
            "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop"
        },
        build = "cd app && yarn install",
        init = function() vim.g.mkdp_filetypes = { "markdown" } end,
        ft = { "markdown" }
    }
}
