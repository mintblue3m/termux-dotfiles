vim.o.autoread = true
vim.o.undofile = true
vim.o.relativenumber = true
vim.o.number = true

-- indent, tabs
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.autoindent = true
vim.o.expandtab = true

-- misc
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = "no"
vim.o.incsearch = true
vim.o.updatetime = 300
vim.o.winborder = "single"
vim.o.cursorcolumn = false
vim.o.signcolumn = "yes"
vim.o.termguicolors = true
-- windows
vim.o.splitright = false
vim.o.splitbelow = true

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.timeoutlen = 300

vim.pack.add({
    {src = "https://github.com/echasnovski/mini.nvim"},
    {src = "https://github.com/neovim/nvim-lspconfig"},
    {src = "https://github.com/rafamadriz/friendly-snippets"},
    {src = "https://github.com/Saghen/blink.cmp", version = 'v1'},
    {src = "https://github.com/nvim-treesitter/nvim-treesitter.git"},
    {src = "https://github.com/catgoose/nvim-colorizer.lua"},
    {src = "https://github.com/metalelf0/black-metal-theme-neovim"},
    {src = "https://github.com/chomosuke/typst-preview.nvim"},
    {src = "https://github.com/mikesmithgh/kitty-scrollback.nvim"},
    {src = "https://github.com/brianhuster/live-preview.nvim.git"},
    {src = "https://github.com/projekt0n/github-nvim-theme.git"},
    {src = "https://github.com/vague-theme/vague.nvim.git"},
    {src = "https://github.com/chrisgrieser/nvim-origami.git"},
    {src = "https://codeberg.org/mfussenegger/nvim-dap.git"},
    {src = "https://github.com/NeogitOrg/neogit.git"},
    {src = "https://github.com/esmuellert/codediff.nvim"},
    {src = "https://github.com/igorlfs/nvim-dap-view", version = vim.version.range("1.*")},
})
vim.cmd(":hi statusline guibg=NONE")

require("colorizer").setup()
-- mini config
require("mini.tabline").setup()
require("mini.sessions").setup()
require("mini.starter").setup({
    evaluate_single = true,
    items = {
      require("mini.starter").sections.builtin_actions(),
      require("mini.starter").sections.recent_files(10, false),
      require("mini.starter").sections.recent_files(10, true),
      -- Use this if you set up 'mini.sessions'
      require("mini.starter").sections.sessions(5, true)
    },
    content_hooks = {
      require("mini.starter").gen_hook.adding_bullet(),
      require("mini.starter").gen_hook.indexing('all', { 'Builtin actions' }),
      require("mini.starter").gen_hook.aligning('center', 'center'),
    },
  })
require("mini.icons").setup()
require("mini.statusline").setup()
require("mini.pairs").setup()
require("mini.move").setup()
require("mini.surround").setup()
require("mini.pick").setup()
require("mini.files").setup()
require("mini.jump").setup()
require("mini.jump2d").setup()
require("mini.extra").setup()
require("mini.ai").setup()
require("mini.splitjoin").setup()
-- require("mini.animate").setup({
--     cursor = {
--         enable = false,
--     },
--     scroll = {
--         enable = true,
--
--         timing = require("mini.animate").gen_timing.quadratic({ duration = 160, easing = "out", unit = "total" }),
--
--         subscroll = require("mini.animate").gen_subscroll.equal({ max_output_steps = 120 }),
--
--     },
--     resize = {
--         enable = false,
--     },
--     open = { enable = false},
--     close = { enable = false },
-- })

local gen_loader = require('mini.snippets').gen_loader
require('mini.snippets').setup({
  snippets = {
    -- Load custom file with global snippets first (adjust for Windows)
    gen_loader.from_file('~/.config/nvim/snippets/global.json'),

    -- Load snippets based on current language by reading files from
    -- "snippets/" subdirectories from 'runtimepath' directories.
    gen_loader.from_lang(),
  },
})

-- treesitter
require("nvim-treesitter").setup()
-- keybinds
vim.keymap.set("n", "<leader>ff", ":Pick files<CR>")
vim.keymap.set("n", "<leader>fm", ":lua MiniFiles.open()<CR>")
vim.keymap.set("n", "<leader>c", ":lua MiniFiles.open('~/.config/nvim')<CR>")
vim.keymap.set("n", "<leader>p", ":lua MiniFiles.open('~/.local/share/nvim/site/pack/core/opt')<CR>")
vim.keymap.set("n", "<leader>b", ":Pick buffers<CR>")
vim.keymap.set("n", "<leader>rg", ":Pick grep_live<CR>")
vim.keymap.set("n", "<leader>j", ":bnext<CR>")
vim.keymap.set("n", "<leader>k", ":bprevious<CR>")
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>yy", '"+Y')
vim.keymap.set("n", "<leader>d", ':lua vim.lsp.buf.definition()<CR>')
vim.keymap.set("n", "<leader>D", ':lua vim.lsp.buf.declaration()<CR>')
vim.keymap.set("n", "<leader><leader>d", ':lua vim.diagnostic.open_float()<CR>')
vim.keymap.set("n", "<leader>bd", ':bd<CR>')
vim.keymap.set("n", "<leader>bdd", ':bd!<CR>')
vim.keymap.set("n", "<leader>bw", ':bwipeout<CR>')

vim.ui.select = require("mini.pick").ui_select

-- lsp config
vim.lsp.config('lua_ls', {on_init = function(client)
if client.workspace_folders then
    local path = client.workspace_folders[1].name
    if
        path ~= vim.fn.stdpath('config')
        and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
        then
            return
        end
    end
client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
        runtime = {
            -- Tell the language server which version of Lua you're using (most
            -- likely LuaJIT in the case of Neovim)
            version = 'LuaJIT',
            -- Tell the language server how to find Lua modules same way as Neovim
            -- (see `:h lua-module-load`)
            path = {
                'lua/?.lua',
                'lua/?/init.lua',
            },
        },
        -- Make the server aware of Neovim runtime files
        workspace = {
            checkThirdParty = false,
            library = {
                vim.env.VIMRUNTIME
                -- Depending on the usage, you might want to add additional paths
                -- here.
                -- '${3rd}/luv/library'
                -- '${3rd}/busted/library'
            }
            -- Or pull in all of 'runtimepath'.
            -- NOTE: this is a lot slower and will cause issues when working on
            -- your own configuration.
            -- See https://github.com/neovim/nvim-lspconfig/issues/3189
            -- library = {
                --   vim.api.nvim_get_runtime_file('', true),
                -- }
            }
        })
    end,
    capabilities = require("blink.cmp").get_lsp_capabilities(),
    settings = {
        Lua = {}
    }
})

vim.lsp.config("clangd", {
    capabilities =
  {
    offsetEncoding = { "utf-8", "utf-16" },
    textDocument = {
      completion = {
        editsNearCursor = true
      }
    }
  },
  require("blink.cmp").get_lsp_capabilities()
})

vim.lsp.config("ols", {
    capabilities = require("blink.cmp").get_lsp_capabilities()
})

vim.lsp.config("basedpyright", {
    capabilities = require("blink.cmp").get_lsp_capabilities()
})
vim.lsp.enable({"lua_ls", "clangd", "tinymist", "rust_analyzer", "ols", "basedpyright"})
require("blink.cmp").setup({
  -- Disable cmdline
  cmdline = { enabled = false },

  completion = {
    -- 'prefix' will fuzzy match on the text before the cursor
    -- 'full' will fuzzy match on the text before _and_ after the cursor
    -- example: 'foo_|_bar' will match 'foo_' for 'prefix' and 'foo__bar' for 'full'
    keyword = { range = 'full' },

    -- Disable auto brackets
    -- NOTE: some LSPs may add auto brackets themselves anyway
    accept = { auto_brackets = { enabled = false }, },

    -- Don't select by default, auto insert on selection
    list = { selection = { preselect = false, auto_insert = true } },

    menu = {
      -- nvim-cmp style menu
      draw = {
        columns = {
          { "label", "label_description", gap = 1 },
          { "kind_icon", "kind" }
        },
      },
      auto_show = true
    },

    -- Show documentation when selecting a completion item
    documentation = { auto_show = true, auto_show_delay_ms = 500 },
  },
  snippets = { preset = 'mini_snippets'},

  sources = {
    -- Remove 'buffer' if you don't want text completions, by default it's only enabled when LSP returns no items
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
  -- Experimental signature help support
  signature = { enabled = true }
})



-- kitty scrollback
require("kitty-scrollback").setup()

require("black-metal").setup()

vim.cmd.colorscheme("dark-funeral")

require('livepreview.config').set()

vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

-- default settings (code folding)
require("origami").setup {
	useLspFoldsWithTreesitterFallback = {
		enabled = true,
		foldmethodIfNeitherIsAvailable = "indent", ---@type string|fun(bufnr: number): string
	},
	pauseFoldsOnSearch = true,
	foldtext = {
		enabled = true,
		padding = {
			character = " ",
			width = 3,  ---@type number|fun(win: number, foldstart: number, currentVirtualTextLength: number): number
			hlgroup = nil,
		},
		lineCount = {
			template = "%d lines", -- `%d` is replaced with the number of folded lines
			hlgroup = "Comment",
		},
		diagnosticsCount = true, -- uses hlgroups and icons from `vim.diagnostic.config().signs`
		gitsignsCount = true, -- requires `gitsigns.nvim`
		disableOnFt = { "snacks_picker_input" }, ---@type string[]
	},
	autoFold = {
		enabled = true,
		kinds = { "comment", "imports" }, ---@type lsp.FoldingRangeKind[]
	},
	foldKeymaps = {
		setup = true, -- modifies `h`, `l`, `^`, and `$`
		closeOnlyOnFirstColumn = false, -- `h` and `^` only fold in the 1st column
		scrollLeftOnCaret = false, -- `^` should scroll left (basically mapped to `0^`)
	},
}

-- dap
local dap = require('dap')
dap.adapters.codelldb = {
  type = "executable",
  command = "codelldb", -- or if not in $PATH: "/absolute/path/to/codelldb"

  -- On windows you may have to uncomment this:
  -- detached = false,
}

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },
}

-- typst
require("typst-preview").setup({
    open_cmd = 'firefox %s -P typst-preview --class typst-preview',
    port = 10043
})

