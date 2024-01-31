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

vim.keymap.set("", "<Tab>", "<cmd>tabnext<cr>", { silent = true, desc = "Next tab" })
vim.keymap.set("", "<S-Tab>", "<cmd>tabprevious<cr>", { silent = true, desc = "Previous tab" })
vim.keymap.set("", "<Leader><Tab>", move_tab_right, { silent = true, desc = "Move tab right" })
vim.keymap.set("", "<Leader><S-Tab>", move_tab_left, { silent = true, desc = "Move tab left" })
vim.keymap.set("", "<Leader>f", toggle_quickfix_list, { silent = true, desc = "Toggle Quickfix list" })
vim.keymap.set("", "<Leader>a", "<Cmd>make!<CR>", { silent = true, desc = "Build project" })
vim.keymap.set("", "<Leader>p", "<Cmd>pclose<CR>", { silent = true, desc = "Close preview" })
vim.keymap.set("", "<Leader>w", "<Cmd>bwipeout<CR>", { silent = true, desc = "Buffer wipeout" })
vim.keymap.set("", "<Leader>t", "<Cmd>Texplore<CR>", { silent = true, desc = "Netrw explore in a new tab" })
vim.keymap.set("", "<Leader>e", "<Cmd>Explore<CR>", { silent = true, desc = "Netrw explore in current buffer" })
vim.keymap.set("", "<Leader>q", "<Cmd>quit<CR>", { silent = true, desc = "Quit buffer" })
vim.keymap.set("", "<Leader>/", "<Cmd>nohlsearch<CR>", { silent = true, desc = "Stop highlighting search" })
