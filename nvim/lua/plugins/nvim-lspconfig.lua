return {
    { 
        "neovim/nvim-lspconfig",

        config = function()

        vim.lsp.config("html", {
            capabilities = require('cmp_nvim_lsp').default_capabilities()
        })

        vim.lsp.config("lua_ls", {
            capabilities = require('cmp_nvim_lsp').default_capabilities()
        }) 

        vim.lsp.enable{"lua_ls", "html"}
    end,
    },
}

