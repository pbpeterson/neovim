return {
  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        denols = {
          filetypes = {
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescriptreact",
            "typescript.tsx",
          },
          root_dir = function(...)
            return require("lspconfig.util").root_pattern("deno.json", "deno.jsonc")(...)
          end,
          single_file_support = false,
          settings = {
            deno = {
              enable = true,
              unstable = true,
              cache = true,
              suggest = {
                autoImports = true,
                completeFunctionCalls = true,
                names = true,
                paths = true,
                imports = {
                  autoDiscover = true,
                  hosts = {
                    ["https://deno.land"] = true,
                    ["https://cdn.nest.land"] = true,
                    ["https://crux.land"] = true,
                    ["https://esm.sh"] = true,
                  },
                },
              },
              inlayHints = {
                parameterNames = { enabled = "all" },
                parameterTypes = { enabled = true },
                variableTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                enumMemberValues = { enabled = true },
              },
              lint = true,
              codeLens = {
                implementations = true,
                references = true,
                referencesAllFunctions = true,
              },
            },
          },
          keys = {
            {
              "gD",
              function()
                vim.lsp.buf.definition()
              end,
              desc = "Goto Definition",
            },
            {
              "gR",
              function()
                vim.lsp.buf.references()
              end,
              desc = "References",
            },
            {
              "<leader>co",
              function()
                vim.lsp.buf.code_action({
                  apply = true,
                  context = {
                    only = { "source.organizeImports" },
                    diagnostics = {},
                  },
                })
              end,
              desc = "Organize Imports",
            },
            {
              "<leader>cD",
              function()
                vim.lsp.buf.code_action({
                  apply = true,
                  context = {
                    only = { "source.fixAll" },
                    diagnostics = {},
                  },
                })
              end,
              desc = "Fix all diagnostics",
            },
            {
              "<leader>dc",
              function()
                vim.lsp.buf.code_action({
                  apply = true,
                  context = {
                    only = { "source.cache" },
                    diagnostics = {},
                  },
                })
              end,
              desc = "Cache Dependencies",
            },
          },
        },
      },
      setup = {
        denols = function(_, opts)
          -- Stop denols from attaching to non-Deno buffers
          vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
              local client = vim.lsp.get_client_by_id(args.data.client_id)
              if client and client.name == "denols" then
                local is_deno = vim.fs.find(
                  { "deno.json", "deno.jsonc" },
                  { path = vim.api.nvim_buf_get_name(args.buf), upward = true }
                )[1] ~= nil
                if not is_deno then
                  vim.lsp.stop_client(client.id)
                end
              end
            end,
          })
        end,
      },
    },
  },

  -- Mason Configuration
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, "deno")
    end,
  },

  -- File Icons
  {
    "echasnovski/mini.icons",
    opts = {
      file = {
        ["deno.json"] = { glyph = "🦕", hl = "MiniIconsGreen" },
        ["deno.jsonc"] = { glyph = "🦕", hl = "MiniIconsGreen" },
        ["deno.lock"] = { glyph = "🦕", hl = "MiniIconsGreen" },
      },
    },
  },

  -- DAP Configuration for Deno
  {
    "mfussenegger/nvim-dap",
    optional = true,
    opts = function()
      local dap = require("dap")

      if not dap.adapters["deno"] then
        dap.adapters["deno"] = {
          type = "executable",
          command = "deno",
          args = { "run", "--inspect-wait", "--allow-all" },
        }
      end

      local deno_filetypes = { "typescript", "javascript", "typescriptreact", "javascriptreact" }

      for _, language in ipairs(deno_filetypes) do
        -- Only add deno configurations if in a deno project
        if not dap.configurations[language] then
          dap.configurations[language] = {}
        end

        table.insert(dap.configurations[language], {
          type = "deno",
          request = "launch",
          name = "Launch Deno",
          program = "${file}",
          cwd = "${workspaceFolder}",
          runtimeExecutable = "deno",
          runtimeArgs = { "run", "--inspect-wait", "--allow-all" },
          attachSimplePort = 9229,
        })

        table.insert(dap.configurations[language], {
          type = "deno",
          request = "attach",
          name = "Attach Deno",
          cwd = "${workspaceFolder}",
          attachSimplePort = 9229,
        })
      end
    end,
  },
}
