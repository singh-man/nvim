local treesitter = require("nvim-treesitter")

local parsers = {
  "bash",
  "c",
  "clojure",
  "cmake",
  "cpp",
  "css",
  "dockerfile",
  "go",
  "html",
  "java",
  "javascript",
  "json",
  "kotlin",
  "latex",
  "lua",
  "markdown",
  "markdown_inline",
  "php",
  "python",
  "rust",
  "toml",
  "typescript",
  "vim",
  "yaml",
}

treesitter.setup({
  install_dir = vim.fn.stdpath("data") .. "/site",
})

local configured_parsers = {}
for _, parser in ipairs(parsers) do
  configured_parsers[parser] = true
end

local function start_highlighting(bufnr)
  if not vim.api.nvim_buf_is_valid(bufnr) then
    return
  end

  local language = vim.treesitter.language.get_lang(vim.bo[bufnr].filetype)
  if language and configured_parsers[language] then
    pcall(vim.treesitter.start, bufnr, language)
  end
end

vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    start_highlighting(args.buf)
  end,
})

-- Installation is asynchronous and is a no-op for parsers already present.
-- Start highlighting in any buffers opened while missing parsers were installed.
treesitter.install(parsers):await(function()
  vim.schedule(function()
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
      start_highlighting(bufnr)
    end
  end)
end)

-- Optional Tree-sitter folding:
-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
