-- Formatter configuration
-- Uses prettierd for faster prettier formatting
return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    formatters = {
      prettier = {
        command = "prettierd",
      },
    },
  },
}
