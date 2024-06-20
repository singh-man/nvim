require('telescope').setup{
  -- defaults = {
  --   layout_strategy='vertical',
  --   layout_config = {
  --     vertical = { width = 0.8 }
  --     -- other layout configuration here
  --   },
  -- },
  -- pickers = {
  --   -- find_files = {
  --   --   theme = "dropdown",
  --   --   horizontal = "0.8",
  --   -- },
  --   -- -- live_grep = {
  --   --   theme = "dropdown",
  --   -- }
  --   --
  -- },
  -- extensions = {
  --   -- ...
  -- }
}

-- Shows line number and wraps text in telescope preview
vim.api.nvim_create_autocmd("User", {
  pattern = "TelescopePreviewerLoaded",
  callback = function(args)
    -- if args.data.filetype ~= "help" then
    --   vim.wo.number = true
    -- elseif args.data.bufname:match("*.csv") then
      vim.wo.number = true
      -- vim.wo.relativenumber = true
      vim.wo.wrap = true
    -- end
  end,
})
