return {
  {
    "zenbones-theme/zenbones.nvim",
    dir = vim.fn.expand("~/.config/nvim/zenbones-theme"),
    dependencies = { "rktjmp/lush.nvim" },
    lazy = false,
    priority = 1000,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "zenbones",
    },
  },
}
