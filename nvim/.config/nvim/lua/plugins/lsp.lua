return {
  {
    "folke/lazydev.nvim",
    ft = "lua",
    cmd = "LazyDev",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "LazyVim",            words = { "LazyVim" } },
        { path = "snacks.nvim",        words = { "Snacks" } },
        { path = "lazy.nvim",          words = { "LazyVim" } },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "SmiteshP/nvim-navic",
      "SmiteshP/nvim-navbuddy",
    },
    config = function()
      if _G.lsp_config_loaded then
        return
      end
      _G.lsp_config_loaded = true

      require("mason").setup()
      local masonlsp = require("mason-lspconfig")
      local navic = require("nvim-navic")
      local navbuddy = require("nvim-navbuddy")

      if _G.deno_lsp_active == nil then
        _G.deno_lsp_active = nil
      end

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then return end

          if client.name ~= "denols" and client.name ~= "vtsls" then
            return
          end

          local bufnr = args.buf
          local fname = vim.api.nvim_buf_get_name(bufnr)
          local util = require("lspconfig.util")

          -- Don't manage vtsls/denols conflict for Vue files - vtsls is needed by vue_ls
          local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
          if filetype == "vue" then
            return
          end

          local all_clients = vim.lsp.get_clients({ bufnr = bufnr })
          local same_name_clients = {}
          for _, c in pairs(all_clients) do
            if c.name == client.name then
              table.insert(same_name_clients, c)
            end
          end

          if #same_name_clients > 1 then
            table.sort(same_name_clients, function(a, b) return a.id < b.id end)
            for i = 2, #same_name_clients do
              vim.lsp.stop_client(same_name_clients[i].id, true)
            end
            if client.id ~= same_name_clients[1].id then
              return
            end
          end

          local has_deno_json = util.root_pattern("deno.json", "deno.jsonc")(fname)
          local is_supabase_fn = util.root_pattern("supabase")(fname) and fname:match("supabase/functions")
          local is_deno = has_deno_json or is_supabase_fn

          local has_package_json = util.root_pattern("package.json")(fname)
          local is_node = has_package_json and not has_deno_json

          if _G.deno_lsp_active == true then
            if client.name == "vtsls" then
              vim.lsp.stop_client(client.id, true)
            end
          elseif _G.deno_lsp_active == false then
            if client.name == "denols" then
              vim.lsp.stop_client(client.id, true)
            end
          else
            if is_deno and client.name == "vtsls" then
              vim.lsp.stop_client(client.id, true)
            elseif is_node and client.name == "denols" then
              vim.lsp.stop_client(client.id, true)
            end
          end
        end,
      })

      local on_attach = function(client, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }
        local map = vim.keymap.set

        if client.server_capabilities.documentSymbolProvider then
          local filetype = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
          
          -- For Vue files, only attach navic/navbuddy to vue_ls, not vtsls
          if filetype == "vue" and client.name == "vtsls" then
            -- Skip attaching navic/navbuddy to vtsls in Vue files
          elseif client.name == "denols" or client.name == "vtsls" then
            -- Para denols/vtsls, esperar un poco para que el autocmd LspAttach haga su trabajo primero
            vim.defer_fn(function()
              -- Verificar si el cliente sigue activo después de que LspAttach lo procese
              local is_still_active = false
              local current_clients = vim.lsp.get_clients({ bufnr = bufnr })
              for _, c in ipairs(current_clients) do
                if c.id == client.id then
                  is_still_active = true
                  break
                end
              end
              
              if is_still_active then
                navic.attach(client, bufnr)
                navbuddy.attach(client, bufnr)
              end
            end, 100)
          else
            navic.attach(client, bufnr)
            navbuddy.attach(client, bufnr)
          end
        end

        -- Go to Declaration
        map("n", "gD", vim.lsp.buf.declaration, opts)
        -- Rename
        map("n", "<leader>rn", vim.lsp.buf.rename, opts)
        -- Hover documentation
        map("n", "K", vim.lsp.buf.hover, opts)
        -- Go to definition
        map("n", "gd", vim.lsp.buf.definition, opts)
        -- Go to implementation
        map("n", "gi", vim.lsp.buf.implementation, opts)
        -- Show signature help
        map("n", "<C-k>", vim.lsp.buf.signature_help, opts)
        -- Go to references
        map("n", "gr", vim.lsp.buf.references, opts)
        -- Note: <leader>ca is handled by tiny-code-action plugin

        if client.name == "denols" then
          map("n", "<leader>dc", function()
            vim.lsp.buf_request(bufnr, "workspace/executeCommand", {
              command = "deno.cache",
              arguments = { vim.fn.expand("%:p") },
            })
          end, { buffer = bufnr, desc = "Deno: Cache dependencies" })
        end
      end

      local function stop_tsserver()
        for _, client in pairs(vim.lsp.get_clients()) do
          if client.name == "vtsls" or client.name == "tsserver" then
            vim.lsp.stop_client(client.id)
          end
        end
      end

      local function stop_deno()
        for _, client in pairs(vim.lsp.get_clients()) do
          if client.name == "denols" then
            vim.lsp.stop_client(client.id)
          end
        end
      end

      vim.api.nvim_create_user_command("DenoEnable", function()
        stop_tsserver()
        _G.deno_lsp_active = true
        vim.notify("Deno LSP activado - TypeScript LSP desactivado", vim.log.levels.INFO)
        vim.cmd("edit")
      end, {})

      vim.api.nvim_create_user_command("DenoDisable", function()
        stop_deno()
        _G.deno_lsp_active = false
        vim.notify("TypeScript LSP activado - Deno LSP desactivado", vim.log.levels.INFO)
        vim.cmd("edit")
      end, {})

      vim.api.nvim_create_user_command("DenoToggle", function()
        if _G.deno_lsp_active then
          stop_deno()
          _G.deno_lsp_active = false
          vim.notify("TypeScript LSP activado", vim.log.levels.INFO)
        else
          stop_tsserver()
          _G.deno_lsp_active = true
          vim.notify("Deno LSP activado", vim.log.levels.INFO)
        end
        vim.cmd("edit")
      end, {})

      masonlsp.setup({
        automatic_installation = true,
        automatic_enable = true,
        ensure_installed = {
          "sqls",
          "lua_ls",
          "prismals",
          "yamlls",
          "marksman",
          "eslint",
          "jsonls",
          "dockerls",
          "docker_compose_language_service",
          "tailwindcss",
          "vtsls",
          "bashls",
          "denols",
          "vue_ls",
        },
        handlers = {
          function(server_name)
            if server_name == "denols" or server_name == "vtsls" or server_name == "vue_ls" then
              return
            end
            vim.lsp.config(server_name, {
              on_attach = on_attach,
            })
            vim.lsp.enable(server_name)
          end,
          ["lua_ls"] = function()
            vim.lsp.config("lua_ls", {
              on_attach = on_attach,
              settings = {
                Lua = {
                  runtime = { version = "LuaJIT" },
                  diagnostics = { globals = { "vim" } },
                  workspace = {
                    library = vim.api.nvim_get_runtime_file("", true),
                    checkThirdParty = false,
                  },
                  telemetry = { enable = false },
                },
              },
            })
            vim.lsp.enable("lua_ls")
          end,
        },
      })

      vim.lsp.config("vtsls", {
        cmd = { "vtsls", "--stdio" },
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
        root_markers = { "package.json", "tsconfig.json", "jsconfig.json" },
        on_attach = function(client, bufnr)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
          on_attach(client, bufnr)
        end,
      })

      vim.lsp.config("denols", {
        cmd = { "deno", "lsp" },
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
        root_markers = { "deno.json", "deno.jsonc" },
        on_attach = on_attach,
        settings = {
          deno = {
            enable = true,
            lint = true,
            unstable = true,
            codeLens = {
              implementations = true,
              references = true,
              referencesAllFunctions = true,
            },
            suggest = {
              completeFunctionCalls = true,
              names = true,
              paths = true,
              autoImports = true,
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
          },
        },
        init_options = {
          lint = true,
          unstable = true,
          suggest = {
            imports = {
              hosts = {
                ["https://deno.land"] = true,
                ["https://cdn.nest.land"] = true,
                ["https://crux.land"] = true,
                ["https://esm.sh"] = true,
              },
            },
          },
        },
      })

      vim.lsp.config("vue_ls", {
        filetypes = { "vue" },
        on_attach = on_attach,
        init_options = {
          typescript = {
            tsdk = vim.fn.stdpath("data") .. "/mason/packages/typescript-language-server/node_modules/typescript/lib"
          },
        },
      })

      vim.lsp.enable("vtsls")
      vim.lsp.enable("denols")
      vim.lsp.enable("vue_ls")
    end,
  },
}
