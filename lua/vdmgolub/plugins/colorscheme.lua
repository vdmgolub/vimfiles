-- return {
-- 	"bluz71/vim-nightfly-guicolors",
-- 	priority = 1000,
-- 	-- make sure to load this before all the other start plugin
-- 	config = function()
-- 		-- load the colorscheme here
-- 		vim.cmd([[colorscheme nightfly]])
-- 	end,
-- }

return {
  "folke/tokyonight.nvim",
  priority = 1000,
  -- make sure to load this before all the other start plugin
  config = function()
    -- load the colorscheme here
    vim.cmd([[colorscheme tokyonight]])
  end,
}

-- lazy.lua references the colorscheme
