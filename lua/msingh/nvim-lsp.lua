local nvim_lsp = require('lspconfig')
local null_ls = require('null-ls')
local cmp_nvim_lsp = require('cmp_nvim_lsp') -- This plugin is a part of nvim-cmp and adds capabilities to lsp server

--
-- Lspconfig
--

-- Use an on_attach function to only map the following keys after
-- the language server attaches to the current buffer
local on_attach  = function(client, bufnr)
    local function buf_set_keymap(...) 
        vim.api.nvim_buf_set_keymap(bufnr, ...) 
    end

    -- Mappings
    local opts = { noremap=true, silent=true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    -- buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    -- buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    -- buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    -- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    -- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    -- buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    -- buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    -- buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    -- buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    -- buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    -- buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    -- buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    -- buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    -- buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    -- buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

    require('which-key').add({
        { "<leader>l", group = "lsp" },
        { "<leader>lD", "<cmd>lua vim.lsp.buf.delaration()<CR>", desc = "Go to declaration" },
        { "<leader>lK", "<cmd>lua vim.lsp.buf.hover()<CR>", desc = "Hover" },
        { "<leader>lN", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", desc = "Go to previous diagnostic" },
        { "<leader>lR", "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "Rename" },
        { "<leader>lW", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", desc = "Remove workspace folder" },
        { "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", desc = "Code actions" },
        { "<leader>ld", "<cmd>lua vim.lsp.buf.definition()<CR>", desc = "Go to definition" },
        { "<leader>le", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", desc = "Show line diagnostics" },
        { "<leader>lf", "<cmd>lua vim.lsp.buf.fomatting<CR>", desc = "Format code" },
        { "<leader>li", "<cmd>lua vim.lsp.buf.implementation()<CR>", desc = "Go to Implementation" },
        { "<leader>lk", "<cmd>lua vim.lsp.buf.signature_help()<CR>", desc = "Signature help" },
        { "<leader>ll", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", desc = "List workspace folder" },
        { "<leader>ln", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", desc = "Go to next diagnostic" },
        { "<leader>lr", "<cmd>lua vim.lsp.buf.references()<CR>", desc = "References" },
        { "<leader>lt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", desc = "Type definition" },
        { "<leader>lw", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", desc = "Add workspace folder" },
    })

    -- Disable Autoformat
    client.server_capabilities.document_formatting = false
    client.server_capabilities.document_range_formatting = false
end

-- nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches using on_attach function
local servers = { 'bashls', 'jdtls', 'pyright', 'ts_ls', 'yamlls', 'dockerls' }
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        capabilities = capabilities,
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150,
        }
    }
end

-- dockerls server setup
-- nvim_lsp['dockerls'].setup {
--     capabilities = capabilities,
--     on_attach = on_attach,
--     flags = {
--         debounce_text_changes = 150,
--     },
--     cmd = {"docker-langserver", "--stdio"},
--     filetypes = {"dockerfile", "qib-11-Dockerfile"},
--     -- root_dir = root_pattern("Dockerfile"),
--     single_file_support = true
-- }

require'lspconfig'.lua_ls.setup {
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if path ~= vim.fn.stdpath('config') and (vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc')) then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT'
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME
          -- Depending on the usage, you might want to add additional paths here.
          -- "${3rd}/luv/library"
          -- "${3rd}/busted/library",
        }
        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
        -- library = vim.api.nvim_get_runtime_file("", true)
      }
    })
  end,
  settings = {
    Lua = {}
  }
}

-- Null-ls
--
-- null-ls is a general purpose language server that doesn't need
-- the same config as actual language servers like tsserver, so
-- setup is a little different.
null_ls.setup({
    on_attach = function(client, bufnr)
        sources = {
            -- prettierd is installed globally via npm
            null_ls.builtins.formatting.prettier
        }
        -- Autoformat
        --if client.server_capabilities.document_formatting then
        --   vim.cmd [[augroup Format]]
        --   vim.cmd [[autocmd! * <buffer>]]
        --   vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]]
        --   vim.cmd [[augroup END]]
        --end
        -- call local on_attach
        return on_attach(client, bufnr)
    end
})

--
-- Diagnostics
--

-- Set diganostic sign icons
-- https://github.com/neovim/nvim-lspconfig/wiki/UI-customization#change-diagnostic-symbols-in-the-sign-column-gutter
local signs = { Error = " ", Warning = " ", Hint = " ", Information = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Show icons in autocomplete
require('vim.lsp.protocol').CompletionItemKind = {
  '', '', 'ƒ', ' ', '', '', '', 'ﰮ', '', '', '', '', '了', ' ', '﬌ ', ' ', ' ', '', ' ', ' ',
  ' ', ' ', '', '', '<>'
}

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  virtual_text = {spacing = 5, min = 'severity'},
  update_in_insert = true
})
