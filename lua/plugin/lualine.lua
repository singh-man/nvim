require("lualine").setup({
  options = {
    always_show_tabline = true,
  },
  tabline = {
    lualine_a = {
      {
        "buffers",
        mode = 0,
        show_filename_only = true,
        show_modified_status = true,
        buffers_color = {
          active = { gui = "bold" },
          inactive = "lualine_c_inactive",
        },
        fmt = function(name, buffer)
          return buffer.current and ("▌ " .. name) or name
        end,
        max_length = function()
          return vim.o.columns
        end,
        symbols = {
          modified = " ●",
          alternate_file = "#",
          directory = "",
        },
      },
    },
    lualine_z = {
      {
        function()
          return " × "
        end,
        on_click = function(_, button)
          if button == "l" then
            -- vim.cmd("bdelete")
            require("buffer").close_current()
          end
        end,
        desc = "Close current buffer",
      },
    },
  },
})
