return {
    "tpope/vim-fugitive",
    config = function()
        local wk = require("which-key")

        vim.keymap.set("n", "<leader>G", vim.cmd.Git)
        vim.keymap.set("n", "gu", "<cmd>diffget //2<CR>")
        vim.keymap.set("n", "<leader>gba", "<cmd>G blame<CR>")

        wk.add({
            { "<leader>G", desc = "Open Git" },
            { "<leader>gba", desc = "Git Blame Fugitive" },
            { "gu", desc = "Git Diff Get //2" },
        })
    end
}

