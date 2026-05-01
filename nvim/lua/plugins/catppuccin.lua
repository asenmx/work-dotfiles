vim.pack.add({
	{ src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
})

require("catppuccin").setup({
	default_integrations = true,
	flavour = "macchiato", -- latte, frappe, macchiato, mocha
})

vim.cmd.colorscheme("catppuccin")

