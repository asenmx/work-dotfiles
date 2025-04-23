vim.o.timeout = true
vim.o.timeoutlen = 300

return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        preset = "helix",
        defaults = {},
        spec = {
            {
                mode = { "n", "v" },
                { "<leader>c", group = "code", icon = { icon = "󰈔 ", color = "blue" } },
                { "<leader>d", group = "debug", icon = { icon = "󰇓 ", color = "red" } },
                { "<leader>dp", group = "profiler", icon = { icon = "󱞨 ", color = "purple" } },
                { "<leader>f", group = "file/find", icon = { icon = "󰈢 ", color = "orange" } },
                { "<leader>g", group = "git", icon = { icon = "󰊢 ", color = "yellow" } },
                { "<leader>gh", group = "hunks", icon = { icon = "󰅁 ", color = "yellow" } },
                { "<leader>q", group = "quit/session", icon = { icon = "󰩈 ", color = "red" } },
                { "<leader>s", group = "search", icon = { icon = "󰍉 ", color = "green" } },
                { "<leader>u", group = "ui", icon = { icon = "󰥨 ", color = "cyan" } },
                { "[", group = "prev", icon = { icon = "󰑓 ", color = "blue" } },
                { "]", group = "next", icon = { icon = "󰑗 ", color = "blue" } },
                { "g", group = "goto", icon = { icon = "󰊠 ", color = "cyan" } },
                { "gs", group = "surround", icon = { icon = "󱞪 ", color = "magenta" } },
                { "z", group = "fold", icon = { icon = "󰅀 ", color = "gray" } },
                {
                    "<leader>b",
                    group = "buffer",
                    icon = { icon = "󰉒 ", color = "blue" },
                    expand = function()
                        return require("which-key.extras").expand.buf()
                    end,
                },
                {
                    "<leader>w",
                    group = "windows",
                    icon = { icon = "󰍺 ", color = "cyan" },
                    proxy = "<c-w>",
                    expand = function()
                        return require("which-key.extras").expand.win()
                    end,
                },
                { "<leader>t", group = "toggles", icon = { icon = "󰪓 ", color = "purple" } },
                { "<leader>z", group = "noice", icon = { icon = "󰩆 ", color = "green" } },
                { "<leader>qp", group = "projects", icon = { icon = "󰋜 ", color = "orange" } },
                { "gx", desc = "Open with system app", icon = { icon = "󰤼 ", color = "green" } },
            },
        },
    }
}

