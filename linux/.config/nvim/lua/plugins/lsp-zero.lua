return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        lazy = true,
        config = function() require('lsp-zero.settings').preset({}) end
    }, -- Autocompletion
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            { 'L3MON4D3/LuaSnip' }, { 'hrsh7th/cmp-nvim-lsp-signature-help' },
            { 'onsails/lspkind.nvim' }
        },
        config = function()
            -- Here is where you configure the autocompletion settings.
            -- The arguments for .extend() have the same shape as `manage_nvim_cmp`:
            -- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v2.x/doc/md/api-reference.md#manage_nvim_cmp

            require('lsp-zero.cmp').extend()

            -- And you can configure cmp even more, if you want to.
            local cmp = require('cmp')
            local cmp_action = require('lsp-zero.cmp').action()
            local lspkind = require('lspkind')
            local cmp_autopairs = require('nvim-autopairs.completion.cmp')

            cmp.setup({
                sources = {
                    { name = 'nvim_lsp' }, { name = 'luasnip' },
                    { name = 'nvim_lsp_signature_help' }
                },
                mapping = cmp.mapping.preset.insert({
                    ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
                    ['<C-b>'] = cmp_action.luasnip_jump_backward()
                }),
                preselect = require('cmp').PreselectMode.None,
                complete = { completeopt = menu, menuone, noinsert, noselect },
                formatting = {
                    format = lspkind.cmp_format({
                        mode = 'symbol_text',  -- show only symbol annotations
                        maxwidth = 100,        -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                        ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

                        -- The function below will be called before any actual modifications from lspkind
                        -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
                        before = function(entry, vim_item)
                            local source_name = entry.source.name
                            vim_item.menu = string.format('[%s]', source_name)
                            return vim_item
                        end
                    })
                }
            })
            cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
            require("luasnip.loaders.from_snipmate").lazy_load()
        end
    }, -- LSP
    {
        'neovim/nvim-lspconfig',
        cmd = 'LspInfo',
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' }, { 'williamboman/mason-lspconfig.nvim' }, {
            'williamboman/mason.nvim',
            build = function() pcall(vim.cmd, 'MasonUpdate') end
        }, {
            'nvim-java/nvim-java',
            ft = 'java',
            config = function() require('java').setup() end
        }
        },
        config = function()
            -- This is where all the LSP shenanigans will live

            local lsp = require('lsp-zero')

            lsp.on_attach(function(client, bufnr)
                lsp.default_keymaps({ buffer = bufnr })
                if client.server_capabilities.inlayHintProvider then
                    vim.lsp.inlay_hint.enable(true, { buffer = bufnr })
                end
            end)

            -- (Optional) Configure lua language server for neovim
            -- require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
            require("lspconfig").clangd.setup {
                on_attach = function(client, bufnr)
                    lsp.default_keymaps({ buffer = bufnr })
                end,
                capabilities = require("cmp_nvim_lsp").default_capabilities(),
                cmd = { "clangd", "--offset-encoding=utf-16" }
            }

            require("lspconfig").jdtls.setup({})

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(ev)
                    local client = vim.lsp.get_client_by_id(ev.data.client_id)
                    local function toSnakeCase(str)
                        return string.gsub(str, "%s*[- ]%s*", "_")
                    end
                end
            })

            vim.diagnostic.config({ virtual_text = false, underline = true })

            lsp.setup()
        end
    }
}
