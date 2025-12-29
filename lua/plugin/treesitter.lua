require'nvim-treesitter'.setup {
    ensure_installed = {"bash", "c", "clojure", "cmake", "cpp", "css", "dockerfile", "go", "html", "java", "javascript", "json", "kotlin", "latex", "lua", "php", "python", "rust", "toml", "typescript", "vim", "yaml"}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    auto_install = true,
    ignore_install = { "dart" }, -- List of parsers to ignore installing
    incremental_selection = { enable = true }
}

-- Code folding
-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
