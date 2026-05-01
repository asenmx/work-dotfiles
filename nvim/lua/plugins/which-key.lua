vim.schedule(function()
	vim.pack.add({ "https://github.com/folke/which-key.nvim" })

	local wk = require("which-key")

	wk.setup({
		preset = "helix",
	})

	wk.add({
		{ "<leader>w", group = "Window" },
		{ "<leader>c", group = "Code" },
		{ "<leader>f", group = "Find" },
		{ "<leader>g", group = "Git" },
		{ "<leader>s", group = "Search" },
		{ "gs", group = "Surround" },
	})
end)

