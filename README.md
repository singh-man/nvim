# Neovim configuration

This configuration requires Neovim 0.12 or newer and uses its built-in `vim.pack` plugin manager.

## Install Neovim and dependencies

Follow the latest [Neovim installation guide](https://github.com/neovim/neovim/wiki/Installing-Neovim) to install Neovim 0.12 or newer. Distribution repositories can contain older Neovim releases, especially on Debian and Ubuntu.

The configuration also uses:

- Git and curl to install plugins.
- A C/C++ compiler and `tree-sitter-cli` 0.26.1 or newer to install Tree-sitter parsers.
- Python 3 and pip for Python tooling.
- Node.js and npm for Prettier and Node-based language servers installed by Mason.
- `ripgrep` (`rg`) for Telescope live grep and file search.
- `fd` for additional Telescope capabilities (optional because Telescope can use `rg`).
- `jq` for the `<leader>jq` JSON-formatting mapping.
- `trash` for nvim-tree's trash action.

### Debian, Ubuntu, or WSL

```sh
sudo apt update
sudo apt install git curl build-essential python3 python3-pip nodejs npm ripgrep fd-find jq trash-cli
```

Debian-based systems install the `fd` executable as `fdfind`; Telescope detects both names.

Install the Tree-sitter CLI using Cargo, or download a prebuilt binary from the [Tree-sitter releases](https://github.com/tree-sitter/tree-sitter/releases). If `cargo` is unavailable, install the Rust toolchain first by following the [Rust installation guide](https://www.rust-lang.org/tools/install).

```sh
cargo install --locked tree-sitter-cli
```

### macOS with Homebrew

```sh
brew install neovim git curl python node ripgrep fd jq tree-sitter-cli
```

Current macOS releases provide `/usr/bin/trash`; verify that it is available with `command -v trash` because nvim-tree uses it for trash operations.

### Verify the required commands

```sh
nvim --version
python3 --version
pip3 --version
node --version
npm --version
tree-sitter --version
rg --version
```

## Install fonts

Install a [Nerd Font](https://www.nerdfonts.com/font-downloads) so file and diagnostic icons render correctly. Recommended fonts:

- JetBrainsMono Nerd Font
- Hack Nerd Font

### Linux

Place the font files in `~/.local/share/fonts`, refresh the font cache, and verify the installation:

```sh
fc-cache -f -v
fc-list | grep "JetBrainsMono"
```

### Windows and WSL

Install the font through Windows Settings, then select it in Windows Terminal. WSL uses the Windows Terminal font rather than a font installed inside the WSL filesystem.

## Clone this repository

On Linux, macOS, or WSL, clone with SSH:

```sh
git clone git@github.com:singh-man/nvim.git ~/.config/nvim
```

Or clone with HTTPS:

```sh
git clone https://github.com/singh-man/nvim.git ~/.config/nvim
```

On native Windows PowerShell:

```powershell
git clone https://github.com/singh-man/nvim.git "$env:LOCALAPPDATA\nvim"
```

## Install and update plugins

- Start Neovim with `nvim`. `vim.pack.add()` installs missing plugins automatically.
- Tree-sitter installs the configured parsers asynchronously on the first run. Restart Neovim after installation finishes.
- Run `:lua vim.pack.update()`, review the proposed changes, and use `:write` to confirm a plugin update.
- Run `:TSUpdate` after updating `nvim-treesitter` so installed parsers remain compatible.
- Run `:checkhealth` to verify plugins and external dependencies.

## Install LSP servers

Mason installs language servers from inside Neovim:

```vim
:MasonInstall lua-language-server bash-language-server pyright vim-language-server docker-language-server jdtls
```

Edit `lua/plugin/nvim-lsp.lua` when enabling or configuring additional servers.
Refer to the [nvim-lspconfig configurations](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md) for server-specific settings and project-root behavior.

The **leader** key is Space.

## Format files

[`conform.nvim`](https://github.com/stevearc/conform.nvim) uses Prettier for JavaScript, TypeScript, JSON, JSONC, YAML, HTML, CSS, SCSS, Less, Vue, Angular, Markdown, MDX, GraphQL, and Handlebars files.

Install Prettier through Mason:

```vim
:MasonInstall prettier
```

Press `<leader>p` in normal mode to format the current file. Select a range in visual mode and press `<leader>p` to format only that range. Run `:ConformInfo` to check which formatter is available for the current buffer.

The `<leader>jq` mapping formats an entire JSON buffer using `jq` in normal mode, or only the selected JSON in visual mode. The input must contain valid JSON; the mapping does not support comments in JSONC files or block selections.

## Further reading

*Beginner Friendly*
https://www.jakewiesler.com/blog/getting-started-with-vim --- or --- https://github.com/jakewies/.dotfiles/blob/main/nvim/.config/nvim/

*Intermediate level*
https://github.com/VapourNvim/VapourNvim

*Good One*
https://github.com/josean-dev/dev-environment-files/tree/main/.config/nvim

*Advanced setup*
https://github.com/LunarVim/LunarVim
