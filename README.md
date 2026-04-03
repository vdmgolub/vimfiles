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

Switches input method back to ABC on leaving insert mode (useful when typing in non-Latin scripts).

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

`harper_ls` is enabled by default. Install via Mason (`:MasonInstall harper-ls`) or it will be auto-installed.