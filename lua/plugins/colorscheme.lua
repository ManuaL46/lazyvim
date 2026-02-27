return {
  -- add gruvbox
  { "ellisonleao/gruvbox.nvim" },
  { "tanvirtin/monokai.nvim" },
  {
    "navarasu/onedark.nvim",
    config = function()
      require("onedark").setup({
        style = "darker",
      })
    end,
  },
  {
    "Shatur/neovim-ayu",
    config = function()
      require("ayu").setup({ mirage = true, terminal = true, overrides = {} })
    end,
  },
  {
    "Mofiqul/vscode.nvim",
  },
  {
    "Mofiqul/adwaita.nvim",
  },
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "gruvbox",
      -- colorscheme = "catppuccin-mocha",
      -- colorscheme = "monokai_pro",
      -- colorscheme = "monokai_ristretto",
      -- colorscheme = "onedark",
      -- colorscheme = "vscode",
      -- colorscheme = "tokyonight-night",
      -- colorscheme = "tokyonight-moon",
      colorscheme = "ayu-dark",
      -- colorscheme = "lunaperche",
      -- colorscheme = "adwaita",
    },
  },
}
