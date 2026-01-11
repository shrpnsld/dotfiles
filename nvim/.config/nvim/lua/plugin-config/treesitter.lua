local treesitter = require("nvim-treesitter.configs")

treesitter.setup {
	ensure_installed = {
		"bash",
		"c",
		"cpp",
		"haskell",
		"ini",
		"json",
		"lua",
		"markdown",
		"python",
		"query",
		"swift",
		"vim",
		"vimdoc",
		"xml",
		"yaml"
	},

	highlight = {
		enable = true
	},

	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
				-- ["i="] = "@assignment.inner", -- kinda useless
				["a="] = "@assignment.outer",
				["=l"] = "@assignment.lhs",
				["=r"] = "@assignment.rhs",
				["iR"] = "@return.inner",
				["aR"] = "@return.outer",
				["is"] = "@block.inner",
				["as"] = "@block.outer",
				["ir"] = "@parameter.inner",
				["ar"] = "@parameter.outer",
				["ii"] = "@conditional.inner",
				["ai"] = "@conditional.outer"
			},

			include_surrounding_whitespace = false,
		},

		move = {
			enable = true,
			set_jumps = true,
			goto_next_start = {
				["]f"] = "@function.outer",
				["]F"] = "@function.inner",
				["]b"] = "@block.outer",
			},
			goto_next_end = {
				["]B"] = "@block.outer",
			},
			goto_previous_start = {
				["[f"] = "@function.outer",
				["[F"] = "@function.inner",
				["[b"] = "@block.outer"
			},
			goto_previous_end = {
				["[B"] = "@block.outer",
			}
		},

		swap = {
			enable = true,
			swap_next = {
				["<Leader>l"] = "@parameter.inner",
			},
			swap_previous = {
				["<Leader>h"] = "@parameter.inner",
			},
		},

	}
}

--local repeatable_move = require("nvim-treesitter.textobjects.repeatable_move")
--
--vim.keymap.set({ "n", "x", "o"}, ";", repeatable_move.repeat_last_move)
--vim.keymap.set({ "n", "x", "o"}, ",", repeatable_move.repeat_last_move_opposite)

--vim.keymap.set({ "n", "x", "o"}, "f", repeatable_move.builtin_f)
--vim.keymap.set({ "n", "x", "o"}, "F", repeatable_move.builtin_F)
--vim.keymap.set({ "n", "x", "o"}, "t", repeatable_move.builtin_t)
--vim.keymap.set({ "n", "x", "o"}, "T", repeatable_move.builtin_T)

