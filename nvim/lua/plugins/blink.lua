	vim.pack.add({
		"https://github.com/rafamadriz/friendly-snippets",
		"https://github.com/saghen/blink.cmp",
	})

	require("blink.cmp").setup({
		snippets = {
			preset = "default",
		},
		appearance = {
			use_nvim_cmp_as_default = false,
			nerd_font_variant = "mono",
		},
		fuzzy = {
			implementation = "prefer_rust",
			prebuilt_binaries = {
				force_version = "v*",
			},
		},
		completion = {
			accept = {
				auto_brackets = { enabled = true },
			},
			menu = {
				draw = {
					treesitter = { "lsp" },
				},
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 200,
			},
			ghost_text = { enabled = false },
		},
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},
		cmdline = {
			enabled = true,
			keymap = {
				preset = "cmdline",
				["<Right>"] = false,
				["<Left>"] = false,
			},
			completion = {
				list = { selection = { preselect = false } },
				menu = {
					auto_show = function(ctx)
						return vim.fn.getcmdtype() == ":"
					end,
				},
				ghost_text = { enabled = true },
			},
		},
		keymap = {
			preset = "enter",
			["<C-y>"] = { "select_and_accept" },
			["<Tab>"] = {
				"snippet_forward",
				function() -- sidekick next edit suggestion
					return require("sidekick").nes_jump_or_apply()
				end,
				function() -- neovim native inline completions
					return vim.lsp.inline_completion.get()
				end,
				"fallback",
			},
			["<S-Tab>"] = { "snippet_backward", "fallback" },
		},
	})
