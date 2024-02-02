require("telescope").setup {
	defaults = {
		sorting_strategy = "ascending",
		layout_config = {
			prompt_position = "top"
		}
	},

	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case"
		}
	}
}

require('telescope').load_extension("fzf")

