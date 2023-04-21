return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.colorscheme.gruvbox", enabled = true },
  {
    "gruvbox.nvim",
    as = "gruvbox",
    opts = {
      contrast = "soft",
    }
  },
  { import = "astrocommunity.bars-and-lines.bufferline-nvim" },
  { import = "astrocommunity.bars-and-lines.lualine-nvim" },
  {
    "lualine.nvim",
    as = "lualine",
    opts = {
      theme = "gruvbox",
    }
  }
  -- { import = "astrocommunity.bars-and-lines.feline-nvim" },
}
