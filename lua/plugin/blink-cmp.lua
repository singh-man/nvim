-- Below is the built-in neovim code completion. Doesn't work properly
-- vim.cmd("set completeopt+=noselect")
--
-- vim.api.nvim_create_autocmd("LspAttach", {
-- 	callback = function(ev)
-- 		local client = vim.lsp.get_client_by_id(ev.data.client_id)
-- 		if client ~= nil and client:supports_method("textDocument/completion") then
-- 			vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
-- 		end
-- 	end,
-- })

-- Search blink cmp keymap on google and modify accordingly
-- require("luasnip.loaders.from_vscode").lazy_load(
require("blink.cmp").setup({
    fuzzy = { implementation = "prefer_rust_with_warning" },
	signature = { enabled = true },
    opts = {
        -- snippets = { preset = 'luasnip' },
        -- -- ensure you have the `snippets` source (enabled by default)
        -- sources = {
        --     default = { 'lsp', 'path', 'snippets', 'buffer' },
        -- },
    },
	completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 500 },
		menu = {
			auto_show = true,
			draw = {
				treesitter = { "lsp" },
				columns = { { "kind_icon", "label", "label_description", gap = 1 }, { "kind" } },
			},
		},
	},
    keymap = {
        preset = "enter", -- 'default' is not good
        ["<ESC>"] = { "cancel", "fallback" }, -- Reverts and hide the completion menu
    --     ["<Tab>"] = { "select_next", "fallback" },
    --     ["<S-Tab>"] = { "select_prev", "fallback" },
    --     ["<C-Up>"] = { "scroll_documentation_up", "fallback" },
    --     ["<C-Down>"] = { "scroll_documentation_down", "fallback" },
    --     [",."] = { "cancel" },
      },
})
