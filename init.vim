set encoding=UTF-8
set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching brackets.
set ignorecase              " case insensitive matching
set mouse=v                 " middle-click paste with mouse
set mouse=a                 " Mouse support enabled
set hlsearch                " highlight search results
set tabstop=4               " number of columns occupied by a tab character
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set relativenumber          " show relative numbers
set wildmode=longest,list   " get bash-like tab completions
set cc=120                  " set an 120 column border for good coding style
set noshowmode              " the command bar -- INSERT -- is not shown
set timeoutlen=800          " timeout
" set termguicolors
filetype plugin indent on   " allows auto-indenting depending on file type
syntax on                   " syntax highlighting
set ic                      " search igone case
" set wrap!                   " Disable word wrap or use :set nowrap
let mapleader = "\<space>"  " default leader key in vim/nvim is \

" Installed Plugins
call plug#begin()
" NVIM tree
Plug 'nvim-tree/nvim-web-devicons' " for file icons this is used by many plugins
Plug 'nvim-tree/nvim-tree.lua'

" Cheatsheet popup - uses nvim-web-devicons
Plug 'sudormrfbin/cheatsheet.nvim'
Plug 'nvim-lua/popup.nvim'

" Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Neovim TreeSitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Tabs
Plug 'romgrk/barbar.nvim'

" Terminals
Plug 'akinsho/toggleterm.nvim'      " prefer using this with <leader> key
Plug 'voldikss/vim-floaterm'        " has shortcut for nnn, lazygit don't use

" Lualine status bar - uses nvim-web-devicons
Plug 'nvim-lualine/lualine.nvim'

" Which key
Plug 'folke/which-key.nvim'

" Auto install lsp-serveers
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
" LSP
Plug 'neovim/nvim-lspconfig'     
" Autocompletion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
" LuaSnip follow latest release and install jsregexp.
Plug 'L3MON4D3/LuaSnip', {'tag': 'v2.*', 'do': 'make install_jsregexp'} " Replace <CurrentMajor> by the latest released major (first number of latest release)
Plug 'saadparwaiz1/cmp_luasnip'
" VSCode like - doesn't add much value !!
" Plug 'onsails/lspkind-nvim'

" Trouble - uses web-dev-icons
Plug 'folke/trouble.nvim'

" Code Comment
Plug 'terrortylor/nvim-comment'
call plug#end()


" Custom mappings
" Another way to add these mappings in lua file check nvim-tree.lua

" Barbar map
nnoremap <silent><A-,> :BufferPrevious<CR>
" nnoremap <silent><A-left> :BufferPrevious<CR>
nnoremap <silent><A-.> :BufferNext<CR>
" nnoremap <silent><A-right> :BufferNext<CR>G
nnoremap <silent><A-<> :BufferMovePrevious<CR>                                                                   
nnoremap <silent><A-<> :BufferMoveNext<CR>
nnoremap <silent><leader>x :BufferClose<CR>
nnoremap <silent><A-{}> :BufferGoto {}<CR>

" <leader> based keys below this----------------------------------------- 

" Save all buffers -special using space-bar
nnoremap <leader>s :wa<CR>
nnoremap <space>W :set wrap!<CR>

" Telescope
" nnoremap <leader>ff <cmd>Telescope find_files<CR>
" nnoremap <leader>fb <cmd>Telescope buffers<CR>
" nnoremap <leader>fg <cmd>Telescope live_grep<CR>
" nnoremap <leader>fh <cmd>Telescope help_tags<CR>
" nnoremap <leader>fr <cmd>Telescope oldfiles<CR>

" Plugins config
lua require('plugin')

" Enable below WSL; uses win32yank.exe at location /usr/local/bin
" https://github.com/neovim/neovim/wiki/FAQ#how-to-use-the-windows-clipboard-From-wsl
set clipboard=unnamedplus
