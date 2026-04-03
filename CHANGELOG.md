# Changelog

## [Unreleased]

### Added
- **LSP**: Extract shared `vdmgolub.lsp` module with `on_attach` and `capabilities`; migrate from `lspconfig.setup()` to native `vim.lsp.config/enable` API; add servers: vtsls, eslint, gopls, elixirls, postgres_lsp, harper_ls, sqls; add `fidget.nvim` for LSP progress UI
- **AI**: Add `claudecode.nvim` with WezTerm pane integration (reuses sibling pane or opens a 35% right split); add `pi.nvim` for inline AI queries; remove `avante.nvim`
- **Debug**: Add `nvim-dap` with Go (`nvim-dap-go`) and Elixir (`elixir-ls-debugger`) adapters; add `timber.nvim` for smart debug logging; add `logsitter.nvim`
- **Elixir**: Add `elixir-tools.nvim`; add `mix` formatter for Elixir/HEEx/EEx; add `sqlfluff` for SQL
- **Navigation**: Add `smart-splits.nvim` replacing `vim-tmux-navigator`; supports WezTerm multiplexer-aware split movement
- **Notes**: Add `obsidian.nvim` with `pkm` and `deutsch` workspaces; add `render-markdown.nvim`; add `bullets.vim` for markdown list editing
- **Telescope**: Add `telescope-live-grep-args` extension; add `<leader>gG` (grep excluding test files); add `<leader>fd` (grep in folder); add `<leader>gh` (live grep with args)
- **Input Method**: Add `im-select.nvim` to auto-switch to ABC layout on normal mode (macOS)
- **TypeScript**: Add `ts-error-translator.nvim`; switch from `tsserver` to `vtsls` LSP server
- **Treesitter**: Add textobject keymaps (`af/if` function, `ac/ic` class); add `heex`/`eex` parsers

### Changed
- **Keymaps**: Remove old tmux-navigator keymaps; add `gF` (go to enclosing function name); add `<leader>rl` (reload all lua modules)
- **Comment**: Migrate from `Comment.nvim` to `nvim-ts-context-commentstring` standalone shim (native Neovim commentstring hook)
- **Treesitter**: Migrate config to new nvim 0.10+ API (`require("nvim-treesitter").install()` + autocmd)
- **Gitlinker**: Switch to maintained fork `linrongbin16/gitlinker.nvim` with `:GitLink` command
- **Noice**: Fix cmdline popup position (40% row); add `nvim-notify`
- **Copilot**: Add shim for `client.is_stopped()` → `client:is_stopped()` API change in Nvim 0.13
- **nvim-autopairs**: Add markdown pair rules (`*`, `~`, `` ` ``, ```` ``` ````)
- **nvim-surround**: Add `~` surround for markdown strikethrough
- **nvim-tree**: Auto-open on startup without stealing focus; fix `<leader>ef` to use `NvimTreeFindFile`
- **Lualine**: Remove `encoding` and `fileformat` columns
- **auto-save**: Silence execution message
- **snacks**: Increase default window size to 99%
- **aerial**: Set default panel direction to right

### Removed
- `avante.nvim` — replaced by Claude Code in WezTerm
- `vim-tmux-navigator` — replaced by `smart-splits.nvim`
- Rainbow indent highlight groups from `indent-blankline` config