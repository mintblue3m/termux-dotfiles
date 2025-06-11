-- OPTIONS
local set = vim.opt

set.autoread = true
set.undofile = true
--line nums
set.relativenumber = true
set.number = true

-- indentation and tabs
set.tabstop = 4
set.shiftwidth = 4
set.autoindent = true
set.expandtab = true

-- search settings
set.ignorecase = true
set.smartcase = true

-- appearance
set.termguicolors = true
set.background = "dark"
set.signcolumn = "yes"

-- cursor line
set.cursorline = true

-- 80th column
set.colorcolumn = "80"


-- backspace
set.backspace = "indent,eol,start"

-- split windows
set.splitbelow = true
set.splitright = true

-- keep cursor at least 8 rows from top/bot
set.scrolloff = 8


-- incremental search
set.incsearch = true

-- faster cursor hold
set.updatetime = 300
