-- =============================================================================
-- init.lua - Plugin Manager: vim.pack (Neovim 0.12+)
-- =============================================================================
-- vim.pack.add()    → install missing plugins and add them to the runtime
-- vim.pack.update() → fetch updates and open a confirmation buffer
--
-- Plugins land in:
--   stdpath("data")/site/pack/core/opt/<name>
-- =============================================================================

-- ---------------------------------------------------------------------------
-- LEADER KEY  (set before any plugin that reads mapleader)
-- ---------------------------------------------------------------------------
vim.g.mapleader = " "

-- ---------------------------------------------------------------------------
-- PLUGINS
-- ---------------------------------------------------------------------------
-- Required key: src = "<Git repository URI>"
-- Optional key: version = "<branch, tag, or commit>"
--
-- After adding a plugin here:
--   1. Save the file
--   2. Restart Neovim; vim.pack.add() installs the missing plugin
-- ---------------------------------------------------------------------------

vim.pack.add({
  -- Icons (shared dependency – keep near top)
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },

  -- File explorer
  { src = "https://github.com/nvim-tree/nvim-tree.lua" },

  -- Telescope fuzzy finder
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/nvim-telescope/telescope.nvim" },

  -- Treesitter  (run :TSUpdate after install to pull language parsers)
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },

  -- Status line
  { src = "https://github.com/nvim-lualine/lualine.nvim" },

  -- Which-key
  { src = "https://github.com/folke/which-key.nvim" },

  -- Mason (LSP server installer)
  { src = "https://github.com/mason-org/mason.nvim" },

  -- LSP config
  { src = "https://github.com/neovim/nvim-lspconfig" },

  -- Formatting
  { src = "https://github.com/stevearc/conform.nvim" },

  -- Autocompletion
  { src = "https://github.com/rafamadriz/friendly-snippets" },
  -- { src = "https://github.com/saghen/blink.cmp", version = "v1.10.2" },
  { src = "https://github.com/saghen/blink.cmp"},
  { src = "https://github.com/saghen/blink.lib"},

  -- Diagnostics UI
  { src = "https://github.com/folke/trouble.nvim" },

})

-- Pin a plugin with its version field, for example:
-- { src = "https://github.com/example/plugin", version = "v1.2.3" }
-- Run vim.pack.update() after changing a version to synchronize the checkout.

-- ---------------------------------------------------------------------------
-- OPTIONS
-- ---------------------------------------------------------------------------
local opt = vim.opt

opt.encoding       = "UTF-8"
opt.showmatch      = true           -- show matching brackets
opt.ignorecase     = true           -- case-insensitive search
opt.smartcase      = true           -- search like /Vim becomes case-sensitive
opt.spell          = true           -- highlight misspelled words
opt.mouse          = "a"            -- full mouse support
opt.mousescroll    = "ver:1,hor:1"  -- use :set mousescroll& = to use default which is mousescroll=ver:3,hor:6
opt.hlsearch       = true           -- highlight search results
opt.tabstop        = 4              -- columns per tab character
opt.softtabstop    = 4              -- treat N spaces as a tab on backspace
opt.expandtab      = true           -- convert tabs to spaces
opt.shiftwidth     = 4              -- width for autoindents
opt.autoindent     = true           -- copy indent from current line
opt.number         = true           -- absolute line numbers
opt.relativenumber = true           -- relative line numbers
opt.wildmode       = { "longest", "list" }  -- bash-like tab completion
opt.colorcolumn    = "120"          -- 120-column guide
opt.showmode       = false          -- hide -- INSERT -- in command bar
opt.timeoutlen     = 800            -- key sequence timeout (ms)
opt.foldmethod     = "indent"       -- indent-based folding -- 'z' based commands
opt.foldenable     = false          -- keep folds open by default
opt.smoothscroll   = true           -- scroll wrapped lines by screen line; like visual scroll of other IDE's 
-- opt.clipboard      = "unnamedplus"  -- system clipboard (WSL: needs win32yank)
opt.clipboard = ""                  -- Do not use system clipboard
opt.termguicolors = true            -- uncomment if your terminal supports it
-- opt.wrap          = false           -- uncomment to disable word wrap
opt.display:append("lastline")      -- show as much of the last wrapped line as possible

vim.cmd("filetype plugin indent on")
vim.cmd("syntax on")

-- ---------------------------------------------------------------------------
-- KEYMAPS
-- ---------------------------------------------------------------------------
local map   = vim.keymap.set
local mopts = { silent = false }

-- Close the current buffer
-- map("n", "<leader>x", "<Cmd>bdelete<CR>",            { silent = true, desc = "Close buffer" })
map("n", "<leader>x", function()
  require("buffer").close_current()
end, { silent = true, desc = "Close buffer" })
map("n", "<leader>X", function()
  require("buffer").close_current(true)
end, { silent = true, desc = "Force close buffer" })

-- Save all buffers
map("n", "<leader>s", "<Cmd>wa<CR>",                 mopts)

-- Toggle word wrap
map("n", "<Space>W",  "<Cmd>set wrap!<CR>",          mopts)

-- Toggle fold under cursor
map("n", "<leader>z", "za",                          { desc = "Toggle fold" })

-- Telescope (uncomment to activate)
-- map("n", "<leader>ff", "<Cmd>Telescope find_files<CR>",  mopts)
-- map("n", "<leader>fb", "<Cmd>Telescope buffers<CR>",     mopts)
-- map("n", "<leader>fg", "<Cmd>Telescope live_grep<CR>",   mopts)
-- map("n", "<leader>fh", "<Cmd>Telescope help_tags<CR>",   mopts)
-- map("n", "<leader>fr", "<Cmd>Telescope oldfiles<CR>",    mopts)

-- ---------------------------------------------------------------------------
-- LOAD CONFIG MODULES
-- ---------------------------------------------------------------------------
require("diff")
require("terminal")
require("plugin")
