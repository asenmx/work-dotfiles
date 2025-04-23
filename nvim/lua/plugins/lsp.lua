return
{
    "neovim/nvim-lspconfig",
    dependencies = {
        {
            "folke/lazydev.nvim",
            ft = "lua",
            opts = {
                library = {
                    { path = "luvit-meta/library", words = { "vim%.uv" } },
                },
            }
        },
        "williamboman/mason.nvim",
        { "williamboman/mason-lspconfig.nvim",           config = function() end },

        "WhoIsSethDaniel/mason-tool-installer.nvim",
        "towolf/vim-helm",
        ft = "helm",

        { "j-hui/fidget.nvim",                           opts = {} },
        { "https://git.sr.ht/~whynothugo/lsp_lines.nvim" },


        "b0o/SchemaStore.nvim",
    },
    config = function()
        -- local capabilities = require('blink.cmp').get_lsp_capabilities()

        local lspconfig = require("lspconfig")

        local servers = {
            bashls = true,
            gopls = {
                settings = {
                    gopls = {
                        hints = {
                            assignVariableTypes = true,
                            compositeLiteralFields = true,
                            compositeLiteralTypes = true,
                            constantValues = true,
                            functionTypeParameters = true,
                            parameterNames = true,
                            rangeVariableTypes = true,
                        },
                    },
                },
            },
            lua_ls = {
                server_capabilities = {
                    semanticTokensProvider = vim.NIL,
                },
            },
            rust_analyzer = true,
            templ = true,

            pyright = true,
            terraformls = true,
            biome = true,
            jsonls = {
                server_capabilities = {
                    documentFormattingProvider = false,
                },
                settings = {
                    json = {
                        -- schemas = require("schemastore").json.schemas(),
                        schemas = {
                            ["https://json.schemastore.org/chart.json"] = "/*.chart/values.yaml",
                            ["https://raw.githubusercontent.com/bitnami-labs/helm-json-schema/master/helm-schema.json"] =
                            "values.yaml",
                        },
                        validate = { enable = true },
                    },
                },
            },
            yamlls = {
                settings = {
                    yaml = {
                        schemaStore = {
                            enable = false,
                            url = "",
                        },
                        schemas = require("schemastore").yaml.schemas(),
                    },
                },
                on_attach = function(client, bufnr)
                    if vim.bo[bufnr].filetype == "helm" then
                        vim.schedule(function()
                            vim.cmd("LspStop ++force yamlls")
                        end)
                    end
                end,
            },
            ansiblels = true,
            cssls = true,
            dockerls = true,
            clangd = true,
            helm_ls = {
                filetypes = { "helm" },
            },
            ruff = true,
        }

        local servers_to_install = vim.tbl_filter(function(key)
            local t = servers[key]
            if type(t) == "table" then
                return not t.manual_install
            else
                return t
            end
        end, vim.tbl_keys(servers))

        require("mason").setup()
        local ensure_installed = {
            "stylua",
            "lua_ls",
            "delve",
            "lua_ls",
            "delve",
            "rust_analyzer",
            "gopls",
            "ansiblels",
            "bashls",
            "clangd",
            "lua_ls",
            "cssls",
            "dockerls",
            "jsonls",
            "yamlls",
            "pyright",
            "terraformls",
            "helm-ls",
            "ruff",
        }

        vim.list_extend(ensure_installed, servers_to_install)
        require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

        for name, config in pairs(servers) do
            if config == true then
                config = {}
            end
            config = vim.tbl_deep_extend("force", {}, {
                capabilities = capabilities,
            }, config)

            lspconfig[name].setup(config)
        end

        local disable_semantic_tokens = {
            lua = true,
        }

        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
                local bufnr = args.buf
                local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

                local settings = servers[client.name]
                if type(settings) ~= "table" then
                    settings = {}
                end


                vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"

                local filetype = vim.bo[bufnr].filetype
                if disable_semantic_tokens[filetype] then
                    client.server_capabilities.semanticTokensProvider = nil
                end

                -- Override server capabilities
                if settings.server_capabilities then
                    for k, v in pairs(settings.server_capabilities) do
                        if v == vim.NIL then
                            ---@diagnostic disable-next-line: cast-local-type
                            v = nil
                        end

                        client.server_capabilities[k] = v
                    end
                end
            end,
        })


        require("lsp_lines").setup()
        vim.diagnostic.config({ virtual_text = true, virtual_lines = false })

        vim.keymap.set("", "<leader>l", function()
            local config = vim.diagnostic.config() or {}
            if config.virtual_text then
                vim.diagnostic.config({ virtual_text = false, virtual_lines = true })
            else
                vim.diagnostic.config({ virtual_text = false, virtual_lines = false })
            end
        end, { desc = "Toggle lsp_lines" })
    end,
}
