return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
    },
    opts = {
      servers = {
        tailwindcss = require("plugins.lsp.tailwindcss").opts,
        autotag = require("plugins.lsp.autotag").opts,
        denols = require("plugins.lsp.denols").opts,
        vtsls = require("plugins.lsp.vtsls").opts,
      },
      setup = {
        autotag = require("plugins.lsp.autotag").setup,
        tailwindcss = require("plugins.lsp.tailwindcss").setup,
        vtsls = require("plugins.lsp.vtsls").setup,
      },
    },
  },

  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "tailwindcss-language-server",
        "emmet-ls",
      },
    },
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        typescript = function(bufnr)
          if vim.fs.find({ "deno.json", "deno.jsonc" }, { upward = true })[1] then
            return { "deno_fmt" }
          end
          return { "prettier" }
        end,
        typescriptreact = function(bufnr)
          if vim.fs.find({ "deno.json", "deno.jsonc" }, { upward = true })[1] then
            return { "deno_fmt" }
          end
          return { "prettier" }
        end,
        javascript = function(bufnr)
          if vim.fs.find({ "deno.json", "deno.jsonc" }, { upward = true })[1] then
            return { "deno_fmt" }
          end
          return { "prettier" }
        end,
        javascriptreact = function(bufnr)
          if vim.fs.find({ "deno.json", "deno.jsonc" }, { upward = true })[1] then
            return { "deno_fmt" }
          end
          return { "prettier" }
        end,
      },
      formatters = {
        deno_fmt = {
          command = "deno",
          args = { "fmt", "-" },
          stdin = true,
        },
      },
    },
  },

  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    opts = {},
  },

  {
    "hrsh7th/nvim-cmp",
    optional = true,
    dependencies = {
      { "roobert/tailwindcss-colorizer-cmp.nvim", opts = {} },
    },
    opts = function(_, opts)
      local format_kinds = opts.formatting.format
      opts.formatting.format = function(entry, item)
        format_kinds(entry, item)
        return require("tailwindcss-colorizer-cmp").formatter(entry, item)
      end
    end,
  },
}
