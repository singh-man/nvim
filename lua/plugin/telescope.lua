require('telescope').setup{
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    -- Keep the preview on the right when wide; stack it vertically when narrow.
    layout_strategy = "flex",
    layout_config = {
      flex = {
        flip_columns = 120,
        flip_lines = 20,
        horizontal = {
          preview_cutoff = 120,
        },
        vertical = {
          preview_cutoff = 20,
          preview_height = 0.5,
        },
      },
    },
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-h>"] = "which_key"
      }
    }
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  }
}

-- Shows line number and wraps text in telescope preview
vim.api.nvim_create_autocmd("User", {
  pattern = "TelescopePreviewerLoaded",
  callback = function(args)
    local data = args.data or {}
    local is_csv = vim.endswith((data.bufname or ""):lower(), ".csv")

    vim.wo.wrap = not is_csv
    vim.wo.linebreak = not is_csv
    vim.wo.number = data.filetype ~= "help"
  end,
})
