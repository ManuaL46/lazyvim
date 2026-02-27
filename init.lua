-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- neovide configuration only needed for neovide
if vim.g.neovide then
  vim.o.guifont = "JetBrainsMono Nerd Font Mono:h12"

  -- Make the window transparent and blurry
  -- vim.g.neovide_transparency = 0.8
  -- vim.g.neovide_window_blurred = true

  -- Disable cursor trailing
  vim.g.neovide_cursor_trail_size = 0
end
