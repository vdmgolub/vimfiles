# Vimfiles (for Neovim)

## Installation

Clone this repo:

```bash
git clone https://github.com/vdmgolub/vimfiles.git ~/.config/nvim/
```

Open nvim and plugins will auto-install:

```bash
nvim
```

## External dependencies

These tools must be installed separately — Mason handles LSP servers, but the items below are not managed by it.

### Claude Code (`claudecode.nvim`)

Install the Claude Code CLI to `~/.local/bin/claude`:

```bash
npm install -g @anthropic-ai/claude-code
ln -s $(which claude) ~/.local/bin/claude
```

Requires **WezTerm** — Claude opens in a sibling pane or a new 35% right split.

### Input method switching (`im-select.nvim`)

Requires `macism` on macOS:

```bash
brew install macism
```

Switches input method back to ABC on leaving insert mode (useful when typing in non-Latin scripts, I use it for German QWERTZ).

### Go debugging (`nvim-dap`)

Requires `delve`:

```bash
go install github.com/go-delve/delve/cmd/dlv@latest
```

### Elixir debugging (`nvim-dap`)

Requires `elixir-ls-debugger` binary on PATH. Install ElixirLS and ensure `elixir-ls-debugger` is available.

### SQL formatting (`conform.nvim`)

Requires `sqlfluff`:

```bash
pip install sqlfluff
# or
brew install sqlfluff
```

### Copilot

Authenticate after first launch:

```
:Copilot auth
```

### Harper (grammar LSP)

`harper_ls` is configured but **not auto-started** (too noisy). Start it manually when needed:

```
:LspStart harper_ls
```

---

## Features

### AI

| Plugin | Description |
|--------|-------------|
| `claudecode.nvim` | Claude Code in a WezTerm pane. `<leader>ac` toggle, `<leader>af` focus, `<leader>ar` resume, `<leader>as` send selection |
| `pi.nvim` | Inline AI asks. `<leader>ai` in normal/visual mode |
| `copilot.lua` + `copilot-cmp` | GitHub Copilot completions via blink.cmp |

### LSP

Managed by Mason. Active servers: `vtsls` (TypeScript), `html`, `eslint`, `lua_ls`, `graphql`, `prismals`, `gopls`, `elixirls`, `postgres_lsp`, `harper_ls`, `sqls`.

Key mappings (buffer-local, set on attach):

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | References |
| `gi` | Implementations |
| `gt` | Type definition |
| `gD` | Declaration |
| `K` | Hover docs |
| `L` | Line diagnostics |
| `<leader>L` | Buffer diagnostics |
| `<leader>ca` | Code actions |
| `<leader>rn` | Rename |
| `<leader>rs` | Restart LSP |

### Debugging (`nvim-dap`)

Adapters: Go (via `nvim-dap-go`), Elixir (via `elixir-ls-debugger`).

| Key | Action |
|-----|--------|
| `<Space>b` | Toggle breakpoint |
| `<Space>gb` | Run to cursor |
| `<Space>?` | Eval var under cursor |
| `F1` | Continue |
| `F2` | Step into |
| `F3` | Step over |
| `F4` | Step out |
| `F5` | Step back |
| `F13` | Restart |

DAP UI opens/closes automatically on session start/end.

### Debug logging

| Plugin | Description |
|--------|-------------|
| `timber.nvim` | Smart debug print insertion |
| `logsitter.nvim` | Treesitter-based log statement generation (prefix: `[VG] ->`) |

### Navigation

| Key | Action |
|-----|--------|
| `<C-h/j/k/l>` | Move between splits (WezTerm-aware via `smart-splits.nvim`) |
| `<leader>f` | Switch between two recent buffers |
| `gF` | Jump to enclosing function name (treesitter) |

### Telescope

| Key | Action |
|-----|--------|
| `<leader>t` | Find files |
| `<leader>gg` | Live grep |
| `<leader>gG` | Live grep (excluding test files) |
| `<leader>gh` | Live grep with args |
| `<leader>fd` | Grep in a specific folder |
| `<leader><space>` | Open buffers (sorted by MRU) |

### Git

| Key | Action |
|-----|--------|
| `<leader>hb` | Yank git link for current line/selection |
| `<leader>hB` | Open git link in browser |
| `<leader>hh` | Create GitHub gist from buffer/selection |

### File explorer (`nvim-tree`)

Auto-opens on startup without stealing focus. `<leader>ee` toggle, `<leader>ef` focus current file, `<leader>ec` collapse, `<leader>er` refresh.

### Elixir

| Plugin | Description |
|--------|-------------|
| `elixir-tools.nvim` | ElixirLS + credo integration |
| `conform.nvim` | `mix format` for `.ex`, `.exs`, `.heex`, `.eex` |

Buffer-local: `<Space>fp` from-pipe, `<Space>tp` to-pipe, `<Space>em` expand macro (visual).

### Markdown

| Plugin | Description |
|--------|-------------|
| `render-markdown.nvim` | In-editor markdown rendering |
| `bullets.vim` | Smart list continuation |

### Misc

| Key | Action |
|-----|--------|
| `<leader>rl` | Reload all `vdmgolub` lua modules + re-source init.lua |
| `<leader>lu` | Update plugins (Lazy) |
| `<leader>cl` | Toggle Aerial (code outline) |
| `<leader>I` | Toggle indent guides |
