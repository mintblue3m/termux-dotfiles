return {
    {
        "echasnovski/mini.nvim", version = false,
        config = function()
            require("mini.statusline").setup()
            require("mini.pairs").setup()
            require("mini.move").setup()
            require("mini.surround").setup()
        end,
    }
}
