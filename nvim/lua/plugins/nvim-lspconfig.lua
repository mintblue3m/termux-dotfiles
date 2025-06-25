return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "saghen/blink.cmp",
            {
                "folke/lazydev.nvim",
                ft = "lua", -- only load on lua files
                opts = {
                    library = {
                        -- See the configuration section for more details
                        -- Load luvit types when the `vim.uv` word is found
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    },
                },
            },
        },
        config = function()
            local capabilities = require("blink.cmp").get_lsp_capabilities()
            require("lspconfig").lua_ls.setup { capabilities = capabilities }
            require("lspconfig").rust_analyzer.setup { capabilities = capabilities }
            require("lspconfig").nushell.setup { capabilities = capabilities }
            require("lspconfig").cssls.setup { capabilities = capabilities }
            require("lspconfig").html.setup { capabilities = capabilities }
            require("lspconfig").jsonls.setup { capabilities = capabilities }
            require("lspconfig").ts_ls.setup { capabilities = capabilities }
            require("lspconfig").pyright.setup { capabilities = capabilities }
            require("lspconfig").ccls.setup { capabilities = capabilities }
        end,
    }
}
