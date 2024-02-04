function next_tab()
	local count = vim.api.nvim_get_vvar('count')
	if count == 0 then
		vim.cmd "tabnext"
	else
		vim.cmd("tabnext " .. tostring(count))
	end
end

function previous_tab()
	local count = vim.api.nvim_get_vvar('count')
	if count == 0 then
		vim.cmd "tabprevious"
	else
		vim.cmd("tabprevious " .. tostring(count))
	end
end

function move_tab_left()
	if vim.fn.tabpagenr() > 1 then
		vim.cmd [[ tabmove - ]]
	else
		vim.cmd [[ execute "tabmove" .. tabpagenr("$") ]]
	end
end

function move_tab_right()
	if vim.fn.tabpagenr() < vim.fn.tabpagenr("$") then
		vim.cmd [[ tabmove + ]]
	else
		vim.cmd [[ tabmove 0 ]]
	end
end

function toggle_quickfix_list()
	for _, info in ipairs(vim.fn.getwininfo()) do
		for key, value in pairs(info) do
			if key == "quickfix" and value == 1 then
				vim.cmd [[ cclose ]]
				return
			end
		end
	end

	vim.cmd [[ copen 20 ]]
end

function telescope_find_files_in_project()
	require("telescope.builtin").find_files {
		file_ignore_patterns = { "build/*", "external/*" }
	}
end

function telescope_find_files_any()
	require("telescope.builtin").find_files {
		no_ignore = true,
		hidden = true,
		file_ignore_patterns = { ".git/*" }
	}
end

vim.g.mapleader = " "

-- Tabs
vim.keymap.set("", "<Tab>", next_tab, { silent = true, desc = "Next tab" })
vim.keymap.set("", "<S-Tab>", previous_tab, { silent = true, desc = "Previous tab" })
vim.keymap.set("", "<Leader><Tab>", move_tab_right, { silent = true, desc = "Move tab right" })
vim.keymap.set("", "<Leader><S-Tab>", move_tab_left, { silent = true, desc = "Move tab left" })
vim.keymap.set("", "<Leader>`", "<Cmd>tabnew<CR>", { silent = true, desc = "New tab" })

-- Quickfix List
vim.keymap.set("", "<Leader>x", toggle_quickfix_list, { silent = true, desc = "Toggle Quickfix List" })
vim.keymap.set("", "<Leader>c", "<Cmd>cnext<CR>", { silent = true, desc = "Next in Quickfix List" })
vim.keymap.set("", "<Leader>z", "<Cmd>cprevious<CR>", { silent = true, desc = "Previous in Quickfix List" })

-- Buffers
vim.keymap.set("", "<Leader>w", "<Cmd>bwipeout<CR>", { silent = true, desc = "Buffer wipeout" })
vim.keymap.set("", "<Leader>q", "<Cmd>quit<CR>", { silent = true, desc = "Quit buffer" })
vim.keymap.set("", "<Leader>p", "<Cmd>pclose<CR>", { silent = true, desc = "Close preview" })

-- Netrw
vim.keymap.set("", "<Leader>.", "<Cmd>Explore<CR>", { silent = true, desc = "Netrw explore in current buffer" })
vim.keymap.set("", "<Leader>>", "<Cmd>Texplore<CR>", { silent = true, desc = "Netrw explore in a new tab" })

-- Other Stuff
vim.keymap.set("", "<Leader>/", "<Cmd>nohlsearch<CR>", { silent = true, desc = "Stop highlighting search" })
vim.keymap.set("", "<Leader>m", "<Cmd>make!<CR>", { silent = true, desc = "Build project" })

-- Telescope
vim.keymap.set("", "<Leader>f", telescope_find_files_in_project, { silent = true, desc = "Fuzzy find files" })
vim.keymap.set("", "<Leader>F", telescope_find_files_any, { silent = true, desc = "Fuzzy find files, including 'build/' and 'external/' directories" })
vim.keymap.set("", "<Leader>b", require("telescope.builtin").buffers, { silent = true, desc = "Live grep files" })
vim.keymap.set("", "<Leader>g", require("telescope.builtin").live_grep, { silent = true, desc = "Live grep files" })
vim.keymap.set("", "<Leader>t", require("telescope.builtin").current_buffer_fuzzy_find, { silent = true, desc = "Fuzzy find in current buffer" })

vim.keymap.set("", "<Leader>?", require("telescope.builtin").keymaps, { silent = true, desc = "Fuzzy find in keymaps" })
vim.keymap.set("", "<Leader><Leader>", require("telescope.builtin").resume, { silent = true, desc = "Reopen last Telescope find" })

