return {
  {
    dir = vim.fn.expand("~/.config/nvim/i-love-volvo"),
    name = "i-love-volvo",
    lazy = false,
    priority = 1000,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "i-love-volvo",
    },
  },
}
