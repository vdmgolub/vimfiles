return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "antosha417/nvim-lsp-file-operations", config = true },
      "saghen/blink.cmp",
    },
    config = function()
      local lsp = require("vdmgolub.lsp")
      local on_attach = lsp.on_attach
      local capabilities = lsp.capabilities()

      vim.keymap.set("n", "<leader>lr", "<cmd>LspRestart<cr>", { desc = "Restart LSP" })
      vim.keymap.set("n", "<leader>lc", function()
        vim.cmd("Copilot restart")
        vim.notify("Copilot restarted", vim.log.levels.INFO)
      end, { desc = "Restart Copilot" })

      vim.api.nvim_create_user_command("LspRestart", function()
        for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
          client:stop()
        end
        vim.defer_fn(function()
          vim.cmd("edit")
        end, 500)
      end, { desc = "Restart LSP clients for current buffer" })

      vim.api.nvim_create_user_command("LspStop", function(opts)
        local clients = opts.args ~= ""
          and vim.lsp.get_clients({ name = opts.args, bufnr = 0 })
          or vim.lsp.get_clients({ bufnr = 0 })
        for _, client in ipairs(clients) do
          client:stop()
        end
      end, { nargs = "?", complete = function()
        return vim.tbl_map(function(c) return c.name end, vim.lsp.get_clients({ bufnr = 0 }))
      end, desc = "Stop LSP client(s) for current buffer" })

      -- Change the Diagnostic symbols in the sign column (gutter)
      local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      -- Set default root markers for all clients
      vim.lsp.config("*", {
        root_markers = { ".git" },
      })

      -- configure vtsls (replaces tsserver)
      vim.lsp.config("vtsls", {
        filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          vtsls = {
            autoUseWorkspaceTsdk = true,
          },
        },
      })
      vim.lsp.enable("vtsls")

      vim.lsp.config("html", {
        filetypes = { "html", "eex", "eelixir", "heex" },
        capabilities = capabilities,
        on_attach = on_attach,
      })
      vim.lsp.enable("html")

      vim.lsp.config("eslint", {
        capabilities = capabilities,
        on_attach = on_attach,
      })
      vim.lsp.enable("eslint")

      -- configure prisma orm server
      vim.lsp.config("prismals", {
        capabilities = capabilities,
        on_attach = on_attach,
      })
      vim.lsp.enable("prismals")

      -- configure graphql language server
      vim.lsp.config("graphql", {
        filetypes = { "graphql", "gql", "typescriptreact", "javascriptreact" },
        capabilities = capabilities,
        on_attach = on_attach,
      })
      vim.lsp.enable("graphql")

      -- configure lua server (with special settings)
      vim.lsp.config("lua_ls", {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
          },
        },
      })
      vim.lsp.enable("lua_ls")

      -- configure elixir-ls server
      vim.lsp.config("elixirls", {
        cmd = { "elixir-ls" },
        capabilities = capabilities,
        on_attach = on_attach,
      })
      vim.lsp.enable("elixirls")

      -- configure gopls server
      vim.lsp.config("gopls", {
        capabilities = capabilities,
        on_attach = on_attach,
      })
      vim.lsp.enable("gopls")

      vim.lsp.config("postgres_lsp", {
        capabilities = capabilities,
        on_attach = on_attach,
      })
      vim.lsp.enable("postgres_lsp")

      -- harper_ls: disabled auto-start (too noisy); enable manually with :LspStart harper_ls
      vim.lsp.config("harper_ls", {
        capabilities = capabilities,
        on_attach = on_attach,
      })

      -- configure sqlls server
      vim.lsp.config("sqls", {
        capabilities = capabilities,
        on_attach = on_attach,
      })
      vim.lsp.enable("sqls")
    end,
  },
  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    event = "LspAttach",
    config = true,
  },
}