vim.pack.add({
		"https://github.com/nvim-tree/nvim-web-devicons",
		"https://github.com/nvim-lualine/lualine.nvim",
	})
        local icons = require('config.icons')

require('lualine').setup{
            options = {
                theme = "auto",
                globalstatus = true,
                disabled_filetypes = { statusline = { "dashboard", "alpha" } },
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { { "branch" },
                    {
                        "diagnostics",
                        symbols = {
                            error = icons.diagnostics.Error,
                            warn = icons.diagnostics.Warn,
                            info = icons.diagnostics.Info,
                            hint = icons.diagnostics.Hint,
                        },
                    },
                    { "filename", path = 1, symbols = { modified = "  ", readonly = "", unnamed = "" } },
                },
                lualine_x = {
                    {
                        function() return "  " .. require("dap").status() end,
                        cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
                    },
                    {
                        "diff",
                        symbols = {
                            added = icons.git.added,
                            modified = icons.git.modified,
                            removed = icons.git.removed,
                        },
                    },
                },
                lualine_y = {
                    { "location", padding = { left = 0, right = 1 } },
                    {
                        'lsp_status',
                        icon = '', -- f013
                        symbols = {
                            -- Standard unicode symbols to cycle through for LSP progress:
                            spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' },
                            -- Standard unicode symbol for when LSP is done:
                            done = '✓',
                            -- Delimiter inserted between LSP names:
                            separator = ' ',
                        },
                        -- List of LSP names to ignore (e.g., `null-ls`):
                        ignore_lsp = {'harper_ls'},
                    },
                    { "filetype", icon_only = false,                separator = "", padding = { left = 1, right = 0 } },
                },
                lualine_z = {
                    function()
                        return " " .. os.date("%R")
                    end,
                },
            },
        }
