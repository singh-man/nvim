-- =============================================================================
-- init.lua - Plugin Manager: vim.pack (Neovim 0.11+)
-- =============================================================================
-- vim.pack.add()     → declare plugins; each entry MUST use src = "..."
-- vim.pack.install() → clone any not-yet-present plugins (run once after edits)
-- vim.pack.update()  → pull latest commits for all managed plugins
--
-- Plugins land in:
--   ~/.local/share/nvim/site/pack/nvim/start/<name>  (auto-loaded)
--   ~/.local/share/nvim/site/pack/nvim/opt/<name>    (opt=true, load via :packadd)
-- =============================================================================

-- ---------------------------------------------------------------------------
-- LEADER KEY  (set before any plugin that reads mapleader)
-- ---------------------------------------------------------------------------
vim.g.mapleader = " "

-- ---------------------------------------------------------------------------
-- PLUGINS
-- ---------------------------------------------------------------------------
-- Required key: src = "github-owner/repo"  (shorthand, no full URL needed)
-- Optional key: opt = true  → load on demand with :packadd <name>
--
-- After adding a plugin here:
--   1. Save & restart Neovim
--   2. :lua vim.pack.install()
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

  -- Tab bar
  { src = "https://github.com/romgrk/barbar.nvim" },

  -- Terminals
  -- prefer using this with <leader> key
  { src = "https://github.com/akinsho/toggleterm.nvim" },
  -- has shortcut for nnn, lazygit don't use
  { src = "https://github.com/voldikss/vim-floaterm" },

  -- Status line
  { src = "https://github.com/nvim-lualine/lualine.nvim" },

  -- Which-key
  { src = "https://github.com/folke/which-key.nvim" },

  -- Mason (LSP server installer)
  { src = "https://github.com/williamboman/mason.nvim" },

  -- LSP config
  { src = "https://github.com/neovim/nvim-lspconfig" },

  -- Formatting
  { src = "https://github.com/stevearc/conform.nvim" },

  -- Autocompletion
  { src = "https://github.com/rafamadriz/friendly-snippets" },
  { src = "https://github.com/saghen/blink.cmp", version = "v1.10.2" },

  -- Diagnostics UI
  { src = "https://github.com/folke/trouble.nvim" },

  -- Code comments
  { src = "https://github.com/terrortylor/nvim-comment" },
})

-- NOTE: vim.pack has no native tag pinning. To pin a specific release:
--   cd ~/.local/share/nvim/site/pack/nvim/start/<plugin-dir>
--   git checkout <tag>          e.g. v0.2.0 for telescope, v1.x for blink.cmp
-- vim.pack.update() will not override a manually checked-out ref.

-- ---------------------------------------------------------------------------
-- OPTIONS
-- ---------------------------------------------------------------------------
local opt = vim.opt

opt.encoding       = "UTF-8"
opt.showmatch      = true           -- show matching brackets
opt.ignorecase     = true           -- case-insensitive search
opt.smartcase      = true           -- search like /Vim becomes case-sensitive
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
local mopts = { silent = true }

-- Barbar: tab navigation
map("n", "<A-,>",     "<Cmd>BufferPrevious<CR>",    mopts)
map("n", "<A-.>",     "<Cmd>BufferNext<CR>",         mopts)
-- macOS Option-comma/period may be sent as these characters unless Option is
-- configured as Meta in the terminal.
map("n", "≤",         "<Cmd>BufferPrevious<CR>",    mopts)
map("n", "≥",         "<Cmd>BufferNext<CR>",         mopts)
map("n", "<A-<>",     "<Cmd>BufferMovePrevious<CR>", mopts)
-- Uncomment and pick a distinct key for MoveNext if needed:
-- map("n", "<A->>",  "<Cmd>BufferMoveNext<CR>",     mopts)
map("n", "<leader>x", "<Cmd>BufferClose<CR>",        mopts)

-- Save all buffers
map("n", "<leader>s", "<Cmd>wa<CR>",                 mopts)

-- Toggle word wrap
map("n", "<Space>W",  "<Cmd>set wrap!<CR>",          mopts)

-- Toggle fold under cursor
map("n", "<leader>z", "za",                          { desc = "Toggle fold" })

-- Diff current buffer with another open buffer
map("n", "<leader>db", function()
  local current_win = vim.api.nvim_get_current_win()
  local current_buf = vim.api.nvim_get_current_buf()

  local buffers = vim.tbl_filter(function(buf)
    return buf ~= current_buf
      and vim.api.nvim_buf_is_loaded(buf)
      and vim.bo[buf].buflisted
  end, vim.api.nvim_list_bufs())

  if #buffers == 0 then
    vim.notify("No other listed buffers to diff", vim.log.levels.INFO)
    return
  end

  vim.ui.select(buffers, {
    prompt = "Diff with buffer",
    format_item = function(buf)
      local name = vim.api.nvim_buf_get_name(buf)
      return vim.fn.fnamemodify(name ~= "" and name or "[No Name]", ":~:.")
    end,
  }, function(buf)
    if not buf then
      return
    end

    vim.cmd("vertical sbuffer " .. buf)
    local diff_win = vim.api.nvim_get_current_win()

    vim.api.nvim_set_current_win(current_win)
    vim.cmd("diffthis")
    vim.wo.wrap = true

    vim.api.nvim_set_current_win(diff_win)
    vim.cmd("diffthis")
    vim.wo.wrap = true
  end)
end, { desc = "Diff with buffer" })

-- Turn off diff mode and close the compared split
map("n", "<leader>do", function()
  local current_win = vim.api.nvim_get_current_win()
  local diff_wins = vim.tbl_filter(function(win)
    return vim.api.nvim_win_is_valid(win) and vim.wo[win].diff
  end, vim.api.nvim_tabpage_list_wins(0))

  vim.cmd("diffoff!")

  for _, win in ipairs(diff_wins) do
    if win ~= current_win and vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, false)
    end
  end
end, { desc = "Diff off" })

-- Telescope (uncomment to activate)
-- map("n", "<leader>ff", "<Cmd>Telescope find_files<CR>",  mopts)
-- map("n", "<leader>fb", "<Cmd>Telescope buffers<CR>",     mopts)
-- map("n", "<leader>fg", "<Cmd>Telescope live_grep<CR>",   mopts)
-- map("n", "<leader>fh", "<Cmd>Telescope help_tags<CR>",   mopts)
-- map("n", "<leader>fr", "<Cmd>Telescope oldfiles<CR>",    mopts)

-- ---------------------------------------------------------------------------
-- LOAD PLUGIN CONFIGS
-- ---------------------------------------------------------------------------
require("plugin")
