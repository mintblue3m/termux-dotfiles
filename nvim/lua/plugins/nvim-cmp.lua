return {
  { -- do read the installation section in the readme of mini.snippets!
    "echasnovski/mini.snippets",
    dependencies = "rafamadriz/friendly-snippets",
    event = "InsertEnter", -- don't depend on other plugins to load...
    -- :h MiniSnippets-examples:
    opts = function()
      local snippets = require("mini.snippets")
      return { snippets = { snippets.gen_loader.from_lang() }}
    end,
  },

  { -- do read the installation section in the readme of nvim-cmp!
    "hrsh7th/nvim-cmp",
    main = "cmp",
    dependencies = { "abeldekat/cmp-mini-snippets", "hrsh7th/cmp-nvim-lsp" }, -- this plugin
    event = "InsertEnter",
    opts = function()
      local cmp = require("cmp")
      return {
        snippet = {
          expand = function(args) -- mini.snippets expands snippets from lsp...
            local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
            insert({ body = args.body }) -- Insert at cursor
            cmp.resubscribe({ "TextChangedI", "TextChangedP" })
            require("cmp.config").set_onetime({ sources = {} })
          end,
        },
        sources = cmp.config.sources({ { name = "mini_snippets", "nvim_lsp" } }),
        mapping = cmp.mapping.preset.insert(), -- more opts...
      }
    end,
  },
}
