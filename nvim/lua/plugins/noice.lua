return {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
        lsp = {
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
        },
        routes = {
            {
                filter = {
                    event = "msg_show",
                    any = {
                        { find = "%d+L, %d+B" },
                        { find = "; after #%d+" },
                        { find = "; before #%d+" },
                    },
                },
                view = "mini",
            },
        },
        presets = {
            bottom_search = true,
            command_palette = true,
            long_message_to_split = true,
        },
    }, -- stylua: ignore
    keys = {
        {
            "<leader>znl",
            function()
                require("noice").cmd("last")
            end,
            desc = "Noice Last Message",
        },
        {
            "<leader>znh",
            function()
                require("noice").cmd("history")
            end,
            desc = "Noice History",
        },
        {
            "<leader>zna",
            function()
                require("noice").cmd("all")
            end,
            desc = "Noice All",
        },
        {
            "<leader>znz",
            function()
                require("noice").cmd("dismiss")
            end,
            desc = "Dismiss All",
        },
        {
            "<leader>znt",
            function()
                require("noice").cmd("pick")
            end,
            desc = "Noice Picker (Telescope/FzfLua)",
        },
    },
    config = function(_, opts)
        if vim.o.filetype == "lazy" then
            vim.cmd([[messages clear]])
        end
        require("noice").setup(opts)
    end,

    dependencies = {
        "MunifTanjim/nui.nvim",
        "echasnovski/mini.nvim",
        "nvim-tree/nvim-web-devicons",
    },
}
