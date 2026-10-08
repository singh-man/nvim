-- must be set before calling require
-- vim.g.nvim_tree_ignore = {'*.tmp', '.git'}
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require'nvim-tree'.setup {
  sort = { sorter = "case_sensitive",},
  view = { width = { min = 25 }, side = 'left',},
  renderer = { group_empty = true,},
  filters = { dotfiles = false, git_ignored = false, },
  git = { enable = true, timeout = 200, },
  trash = { cmd = "trash" },
  ui = { confirm = { trash = true } },
}

-- NeoVim key map for this
vim.keymap.set("n", "<leader>n", "<Cmd>NvimTreeToggle<CR>", {
  silent = true,
  desc = "Toggle file tree",
})
vim.keymap.set("n", "<leader>nr", "<Cmd>NvimTreeRefresh<CR>", {
  silent = true,
  desc = "Refresh file tree",
})
