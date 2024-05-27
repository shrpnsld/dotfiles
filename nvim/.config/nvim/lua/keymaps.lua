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

-- Preventing these mappings to move between tabs
vim.keymap.set("", "<Leader><Tab>", "", { silent = true })
vim.keymap.set("", "<Leader><S-Tab>", "", { silent = true })

-- Tabs
vim.keymap.set("", "<Tab>", next_tab, { silent = true, desc = "Next tab" })
vim.keymap.set("", "<S-Tab>", previous_tab, { silent = true, desc = "Previous tab" })
vim.keymap.set("", "<Leader><Tab>`", "<Cmd>tabnext #<CR>", { silent = true, desc = "Last opened tab" })
vim.keymap.set("", "<Leader><Tab>l", move_tab_right, { silent = true, desc = "Move tab right" })
vim.keymap.set("", "<Leader><Tab>h", move_tab_left, { silent = true, desc = "Move tab left" })
vim.keymap.set("", "<Leader><Tab><Tab>", "<Cmd>tabnew<CR>", { silent = true, desc = "New tab behind current one" })
vim.keymap.set("", "<Leader><Tab><S-Tab>", "<Cmd>-tabnew<CR>", { silent = true, desc = "New tab before current one" })

-- Quickfix List
vim.keymap.set("", "<Leader>x", toggle_quickfix_list, { silent = true, desc = "Toggle Quickfix List" })
vim.keymap.set("", "<Leader>c", "<Cmd>cnext<CR>", { silent = true, desc = "Next in Quickfix List" })
vim.keymap.set("", "<Leader>z", "<Cmd>cprevious<CR>", { silent = true, desc = "Previous in Quickfix List" })
vim.keymap.set("", "<Leader>Z", "<Cmd>cfirst<CR>", { silent = true, desc = "First in Quickfix List" })
vim.keymap.set("", "<Leader>C", "<Cmd>clast<CR>", { silent = true, desc = "Last in Quickfix List" })

-- Buffers
vim.keymap.set("", "<Leader>w", "<Cmd>bwipeout<CR>", { silent = true, desc = "Buffer wipeout" })
vim.keymap.set("", "<Leader>q", "<Cmd>quit<CR>", { silent = true, desc = "Quit buffer" })
vim.keymap.set("", "<Leader>p", "<Cmd>pclose<CR>", { silent = true, desc = "Close preview" })

-- neo-tree
vim.keymap.set("", "<Leader>,", "<Cmd>Neotree toggle position=left action=show<CR>", { silent = true, desc = "Toggle file tree on the left" })
vim.keymap.set("", "<Leader><", "<Cmd>Neotree position=left action=focus<CR>", { silent = true, desc = "Show file tree on the left and switch focus to it" })
vim.keymap.set("", "<Leader>.", "<Cmd>Neotree position=float<CR>", { silent = true, desc = "Show file tree in the floating window" })
vim.keymap.set("", "<Leader><Tab>.", "<Cmd>tabnew | Neotree position=float<CR>", { silent = true, desc = "Open file tree in the floating window in a tab behind current one" })
vim.keymap.set("", "<Leader><S-Tab>.", "<Cmd>-tabnew | Neotree position=float<CR>", { silent = true, desc = "Open file tree in the floating window in a tab before current one" })

-- Other Stuff
vim.keymap.set("", "<Leader>/", "<Cmd>nohlsearch<CR>", { silent = true, desc = "Stop highlighting search" })
vim.keymap.set("", "<Leader>m", "<Cmd>make!<CR>", { silent = true, desc = "Build project" })
vim.keymap.set("", "<S-BS>", "<Cmd>pop<CR>", { silent = true, desc = "Jump to previous entry in tag stack" })
vim.keymap.set("", "<S-Enter>", "<Cmd>tag<CR>", { silent = true, desc = "Jump to next entry in tag stack" })
vim.keymap.set("", "<Leader>Q", "<Cmd>qa!<CR>", { silent = true, desc = "Just quit!" })

-- Telescope
vim.keymap.set("", "<Leader>f", telescope_find_files_in_project, { silent = true, desc = "Fuzzy find files" })
vim.keymap.set("", "<Leader>F", telescope_find_files_any, { silent = true, desc = "Fuzzy find files, including 'build/' and 'external/' directories" })
vim.keymap.set("", "<Leader>b", require("telescope.builtin").buffers, { silent = true, desc = "Fuzzy find buffers" })
vim.keymap.set("", "<Leader>g", require("telescope.builtin").current_buffer_fuzzy_find, { silent = true, desc = "Fuzzy find in current buffer" })
vim.keymap.set("", "<Leader>G", require("telescope.builtin").live_grep, { silent = true, desc = "Live grep files" })
vim.keymap.set("", "<Leader>!", require("telescope.builtin").diagnostics, { silent = true, desc = "Fuzzy find in diagnostics" })

vim.keymap.set("", "<Leader><Tab>f", "<Cmd>tabnew | lua telescope_find_files_in_project()<CR>", { silent = true, desc = "Fuzzy find files in a tab behind current one" })
vim.keymap.set("", "<Leader><Tab>F", "<Cmd>tabnew | lua telescope_find_files_any()<CR>", { silent = true, desc = "Fuzzy find files, including 'build/' and 'external/' directories in a tab behind current one" })
vim.keymap.set("", "<Leader><Tab>b", "<Cmd>tabnew | lua require('telescope.builtin').buffers()<CR>", { silent = true, desc = "Live grep files in a tab behind current one" })
vim.keymap.set("", "<Leader><Tab>G", "<Cmd>tabnew | lua require('telescope.builtin').live_grep()<CR>", { silent = true, desc = "Live grep files in a tab behind current one" })

vim.keymap.set("", "<Leader><S-Tab>f", "<Cmd>-tabnew | lua telescope_find_files_in_project()<CR>", { silent = true, desc = "Fuzzy find files in a new tab before current one" })
vim.keymap.set("", "<Leader><S-Tab>F", "<Cmd>-tabnew | lua telescope_find_files_any()<CR>", { silent = true, desc = "Fuzzy find files, including 'build/' and 'external/' directories in a new tab before current one" })
vim.keymap.set("", "<Leader><S-Tab>b", "<Cmd>-tabnew | lua require('telescope.builtin').buffers()<CR>", { silent = true, desc = "Live grep files in a new tab before current one" })
vim.keymap.set("", "<Leader><S-Tab>G", "<Cmd>-tabnew | lua require('telescope.builtin').live_grep()<CR>", { silent = true, desc = "Live grep files in a new tab before current one" })

vim.keymap.set("", "<Leader>d", require("telescope.builtin").lsp_definitions, { silent = true, desc = "Fuzzy find in symbol definitions" })
vim.keymap.set("", "<Leader>r", require("telescope.builtin").lsp_references, { silent = true, desc = "Fuzzy find in symbol references" })
vim.keymap.set("", "<Leader>t", require("telescope.builtin").lsp_type_definitions, { silent = true, desc = "Fuzzy find in symbol's type definitions" })
vim.keymap.set("", "<Leader>T", require("telescope.builtin").lsp_implementations, { silent = true, desc = "Fuzzy find in symbol's implementations" })
vim.keymap.set("", "<Leader>u", require("telescope.builtin").lsp_incoming_calls, { silent = true, desc = "Fuzzy find in symbol's incomming calls" })
vim.keymap.set("", "<Leader>U", require("telescope.builtin").lsp_outgoing_calls, { silent = true, desc = "Fuzzy find in symbol's outgoing calls" })
vim.keymap.set("", "<Leader>s", require("telescope.builtin").lsp_document_symbols, { silent = true, desc = "Fuzzy find in document symbols" })
vim.keymap.set("", "<Leader>S", require("telescope.builtin").lsp_workspace_symbols, { silent = true, desc = "Fuzzy find in workspace symbols" })

vim.keymap.set("", "<Leader>?", require("telescope.builtin").keymaps, { silent = true, desc = "Fuzzy find in keymaps" })
vim.keymap.set("", "<Leader><Leader>", require("telescope.builtin").resume, { silent = true, desc = "Reopen last Telescope find" })

-- LSP
vim.keymap.set("", "K", vim.lsp.buf.hover, { silent = true, desc = "LSP hover" })
vim.keymap.set("", "gD", vim.lsp.buf.declaration, { silent = true, desc = "Go to declaration" })
vim.keymap.set("", "gd", vim.lsp.buf.definition, { silent = true, desc = "Go to definition" })
vim.keymap.set("", "gr", vim.lsp.buf.references, { silent = true, desc = "Show references" })
vim.keymap.set("", "gt", vim.lsp.buf.type_definition, { silent = true, desc = "Go to type definition" })
vim.keymap.set("", "gT", vim.lsp.buf.implementation, { silent = true, desc = "Show implementations" })
vim.keymap.set("", "gu", vim.lsp.buf.incoming_calls, { silent = true, desc = "Show incomming calls" })
vim.keymap.set("", "gU", vim.lsp.buf.outgoing_calls, { silent = true, desc = "Show outgoing calls" })
vim.keymap.set("", "g\\", "<Cmd>ClangdSwitchSourceHeader<CR>", { silent = true, desc = "Switch between header and source file" })
vim.keymap.set("", "<Leader>'", vim.lsp.buf.rename, { silent = true, desc = "Rename symbol" })

