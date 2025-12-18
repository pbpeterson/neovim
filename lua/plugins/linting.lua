-- Linting Configuration
-- Customizes linter behavior to reduce noise

return {
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      -- Linters by filetype
      linters_by_ft = {
        markdown = {}, -- Disable markdownlint warnings
      },
      linters = {
        -- Configure markdownlint to ignore line length
        markdownlint = {
          args = {
            "--disable",
            "MD013", -- Line length rule
            "MD041", -- First line in file should be a top level header
            "--",
          },
        },
      },
    },
  },

  -- Configure ESLint to ignore .env files
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      -- Ensure opts.servers exists
      opts.servers = opts.servers or {}

      -- Configure ESLint
      if not opts.servers.eslint then
        opts.servers.eslint = {}
      end

      opts.servers.eslint.settings = vim.tbl_deep_extend("force", opts.servers.eslint.settings or {}, {
        -- Disable ESLint for .env files
        workingDirectories = { mode = "auto" },
      })

      -- Add autocommand to disable diagnostics for .env files
      vim.api.nvim_create_autocmd("BufRead", {
        pattern = { "*.env", ".env*" },
        callback = function()
          vim.diagnostic.disable(0)
        end,
        desc = "Disable diagnostics for .env files",
      })

      return opts
    end,
  },
}
