return {
    {
        "echasnovski/mini.nvim", version = false,
        dependencies = { "rafamadriz/friendly-snippets"},
        config = function()
            require("mini.statusline").setup()
            require("mini.pairs").setup()
            require("mini.move").setup()
            require("mini.surround").setup()

            local gen_loader = require('mini.snippets').gen_loader
            event = "InsertEnter",
            require('mini.snippets').setup({
                snippets = {
                    -- Load custom file with global snippets first (adjust for Windows)
                    gen_loader.from_file('~/.config/nvim/snippets/global.json'),

                    -- Load snippets based on current language by reading files from
                    -- "snippets/" subdirectories from 'runtimepath' directories.
                    gen_loader.from_lang(),
                },
            })
        end,
    }
}
