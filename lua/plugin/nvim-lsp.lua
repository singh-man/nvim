local cmp_nvim_lsp = require('cmp_nvim_lsp') -- This plugin is a part of nvim-cmp and adds capabilities to lsp server
-- nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers. Enable autocompletion to every lsp server config
local capabilities = cmp_nvim_lsp.default_capabilities()

vim.lsp.config("*", {
    capabilities = capabilities,
})
-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches using on_attach function
-- local servers = { 'bashls', 'jdtls', 'pyright', 'ts_ls', 'yamlls', 'dockerls' }
-- for _, lsp in ipairs(servers) do
--     vim.lsp.config(lsp, {
--         capabilities = capabilities,
--     })
--     vim.lsp.enable(lsp)
-- end

vim.lsp.config('lua_ls', {
  capabilities = capabilities,

  on_init = function(client)
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
  settings = {
    Lua = {}
  }
})

-- -- Show icons in autocomplete
-- require('vim.lsp.protocol').CompletionItemKind = {
--   '', '', 'ƒ', ' ', '', '', '', 'ﰮ', '', '', '', '', '了', ' ', '﬌ ', ' ', ' ', '', ' ', ' ',
--   ' ', ' ', '', '', '<>'
-- }

--
-- Diagnostics
--
vim.diagnostic.config({ virtual_text = true })

-- Set diganostic sign icons
-- https://github.com/neovim/nvim-lspconfig/wiki/UI-customization#change-diagnostic-symbols-in-the-sign-column-gutter
-- local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }
-- for type, icon in pairs(signs) do
--     local hl = "DiagnosticSign" .. type
--     vim.diagnostic.config({ virtual_text = true })
-- end

-- vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
--   underline = true,
--   virtual_text = {spacing = 5, min = 'severity'},
--   update_in_insert = true
-- })
