return {
    "jay-babu/mason-nvim-dap.nvim",
    optional = true,
    opts = {
        handlers = {
            ensure_installed = { "python", "delve" },

            python = function() end,
        },
    },
}
