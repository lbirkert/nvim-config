return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        rust_analyzer = { mason = false, enabled = false },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    lazy = false,
    opts = {
      formatters_by_ft = {
        rust = { "cargo_fmt" },
      },
      formatters = {
        cargo_fmt = {
          command = "cargo",
          args = { "fmt", "--", "$FILENAME" },
          stdin = false,
          require_cwd = true,
          cwd = function(_, ctx)
            return vim.fs.root(ctx.filename, { "Cargo.toml" })
          end,
          condition = function()
            return not require("config.rust").is_enabled()
          end,
        },
      },
    },
  },
}
