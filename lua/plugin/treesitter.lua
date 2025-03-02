require'nvim-treesitter.configs'.setup {
    ensure_installed = {"bash", "c", "clojure", "cmake", "cpp", "css", "dockerfile", "go", "html", "java", "javascript", "json", "kotlin", "latex", "lua", "php", "python", "rust", "toml", "typescript", "vim", "yaml"}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
    sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
    ignore_install = { "dart" }, -- List of parsers to ignore installing
    highlight = {
        enable = true,              -- false will disable the whole extension
        disable = { "c", "rust" },  -- list of language that will be disabled
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
      },
    incremental_selection = { enable = true }
}

-- Code folding
-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
