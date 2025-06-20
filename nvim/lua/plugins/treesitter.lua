return {
    { "nvim-treesitter/nvim-treesitter", branch = "master", lazy = false, build = ":TSUpdate",
    config = function()
        require("nvim-treesitter.configs").setup {
            ensure_installed = { "nu", "rust", },
            highlight = { enable = true, },
            auto_install = true,
        }
    end
    }
}
