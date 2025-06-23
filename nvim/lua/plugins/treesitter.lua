return {
    { "nvim-treesitter/nvim-treesitter", branch = "master", lazy = false, build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup {
            ensure_installed = { "nu", "rust", "markdown", "c", "vim", "vimdoc"},
            highlight = { enable = true, },
            auto_install = false,
        }
    end
}
}
