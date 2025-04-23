return {
    'stevearc/conform.nvim',
    config = function()
        require("conform").setup({
            default_format_opts = {
                timeout_ms = 3000,
                async = false,           -- not recommended to change
                quiet = false,           -- not recommended to change
                lsp_format = "fallback", -- not recommended to change
            },
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "black" },
                rust = { "rustfmt", lsp_format = "fallback" },
                javascript = { "prettier", stop_after_first = true },
                terraform = { "terraform_fmt" },
                json = { "jq" },
                yaml = { "yamlfmt" },
                go = { "gofmt" }
            },
            formatters = {
                injected = { options = { ignore_errors = true } },
            },
        })
    end
}
