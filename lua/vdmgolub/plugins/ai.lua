return {
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    opts = {
      terminal_cmd = "~/.local/bin/claude", -- Point to local installation
      terminal = {
        provider = "external",
        provider_opts = {
          external_terminal_cmd = function(cmd, env)
            if vim.fn.executable("wezterm") == 0 then
              vim.notify("wezterm not found in PATH — cannot open Claude terminal", vim.log.levels.ERROR)
              return
            end

            local env_str = ""
            if env then
              for k, v in pairs(env) do
                env_str = env_str .. k .. "=" .. v .. " "
              end
            end
            local full_cmd = env_str .. cmd

            local current_pane_id = tonumber(os.getenv("WEZTERM_PANE"))

            -- Try to reuse an existing sibling pane in the same tab
            if current_pane_id then
              local json = vim.fn.system("wezterm cli list --format json 2>/dev/null")
              local ok, panes = pcall(vim.json.decode, json)

              if ok and panes then
                local current_tab_id
                for _, p in ipairs(panes) do
                  if p.pane_id == current_pane_id then
                    current_tab_id = p.tab_id
                    break
                  end
                end

                if current_tab_id then
                  for _, p in ipairs(panes) do
                    if p.tab_id == current_tab_id and p.pane_id ~= current_pane_id then
                      vim.fn.system(
                        string.format(
                          "wezterm cli send-text --pane-id %d %s",
                          p.pane_id,
                          vim.fn.shellescape(full_cmd .. "\n")
                        )
                      )
                      return "echo"
                    end
                  end
                end
              end
            end

            -- No sibling pane found: create a vertical split to the right
            vim.fn.system(
              string.format("wezterm cli split-pane --right --percent 35 -- sh -c %s", vim.fn.shellescape(full_cmd))
            )

            -- Keep focus on the nvim pane
            if current_pane_id then
              vim.fn.system(string.format("wezterm cli activate-pane --pane-id %d", current_pane_id))
            end
            return "echo"
          end,
        },
      },
    },
    config = true,
    keys = {
      { "<leader>a", nil, desc = "AI/Claude Code" },
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
      {
        "<leader>as",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
      },
      -- Diff management
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    },
  },
  {
    "pablopunk/pi.nvim",
    config = function()
      -- Ask pi with the current buffer as context
      vim.keymap.set("n", "<leader>ai", ":PiAsk<CR>", { desc = "Ask pi" })

      -- Ask pi with visual selection as context
      vim.keymap.set("v", "<leader>ai", ":PiAskSelection<CR>", { desc = "Ask pi (selection)" })
    end,
  },
}