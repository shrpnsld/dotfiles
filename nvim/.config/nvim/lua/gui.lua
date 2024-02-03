--
-- Utils

function get_highlight(name)
	local highlight = vim.api.nvim_get_hl(0, { name = name })

	if highlight.reverse then
		highlight.fg, highlight.bg, highlight.ctermfg, highlight.ctermbg = highlight.bg, highlight.fg, highlight.ctermbg, highlight.ctermfg
	end

	return highlight
end

--
-- Color scheme additions and corrections

function correct_cursor_line_highlights()
	vim.api.nvim_set_hl(0, "CursorLine", {})
end

function correct_match_paren_highlights()
	vim.api.nvim_set_hl(0, "MatchParen", { bold = true, underline = true, cterm = { bold = true, underline = true } })
end

function correct_window_highlights()
	vim.api.nvim_set_hl(0, "WinSeparator", { link = "Normal" })
	vim.api.nvim_set_hl(0, "VertSplit", { link = "Normal" })
end

function correct_status_line_highlights()
	vim.api.nvim_set_hl(0, "StatusLine", { link = "Normal" })
	vim.api.nvim_set_hl(0, "StatusLineNC", {}) -- single character under split line, when right-side window is active
end

function correct_tab_line_fill_highlights()
	local Normal = get_highlight('Normal')
	vim.api.nvim_set_hl(0, "TabLineFill", { fg = Normal.fg, ctermfg = Normal.ctermfg })
	vim.api.nvim_set_hl(0, "TabLine", { fg = Normal.fg, bg = Normal.bg, ctermfg = Normal.ctermfg, ctermbg = Normal.ctermbg })
	vim.api.nvim_set_hl(0, "TabLineSel", { fg = Normal.bg, bg = Normal.fg, bold = true, ctermfg = Normal.ctermbg, ctermbg = Normal.ctermfg, cterm = { bold = true } })
end

function add_status_line_highlights()
	local Normal = get_highlight('Normal')
	local String = get_highlight('String')
	local Function = get_highlight('Function')
	local Keyword = get_highlight('Keyword')
	local Number = get_highlight('Number')

	vim.api.nvim_set_hl(0, "StatusLineDelimiter", { fg = Normal.fg, ctermfg = Normal.ctermfg })
	vim.api.nvim_set_hl(0, "StatusLineSpecialText", { fg = Normal.bg, bg = String.fg, bold = true, ctermfg = Normal.ctermbg, ctermbg = String.ctermfg, cterm = { bold = true } })
	vim.api.nvim_set_hl(0, "StatusLineSpecialSide", { fg = String.fg, bg = Normal.bg, bold = true, ctermfg = String.ctermfg, ctermbg = Normal.ctermbg, cterm = { bold = true } })
	vim.api.nvim_set_hl(0, "StatusLineBufferName", { fg = String.fg, ctermfg = String.ctermfg })
	vim.api.nvim_set_hl(0, "StatusLineFileType", { fg = Function.fg, ctermfg = Function.ctermfg })
	vim.api.nvim_set_hl(0, "StatusLineEncoding", { fg = Keyword.fg, ctermfg = Keyword.ctermfg })
	vim.api.nvim_set_hl(0, "StatusLineLEFormat", { fg = Keyword.fg, ctermfg = Keyword.ctermfg })
	vim.api.nvim_set_hl(0, "StatusLineLineCount", { fg = Number.fg, ctermfg = Number.ctermfg })
end

function correct_diff_highlights(links)
	return function()
		for target, source in pairs(links) do
			local highlight = get_highlight(source)
			vim.api.nvim_set_hl(0, target, { fg = highlight.fg, ctermfg = highlight.ctermfg })
		end
	end
end

local augroup = vim.api.nvim_create_augroup("ColorSchemeCorrections", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", { pattern = "*", group = augroup, callback = correct_cursor_line_highlights })
vim.api.nvim_create_autocmd("ColorScheme", { pattern = "*", group = augroup, callback = correct_match_paren_highlights })
vim.api.nvim_create_autocmd("ColorScheme", { pattern = "*", group = augroup, callback = correct_window_highlights })
vim.api.nvim_create_autocmd("ColorScheme", { pattern = "*", group = augroup, callback = correct_status_line_highlights })
vim.api.nvim_create_autocmd("ColorScheme", { pattern = "*", group = augroup, callback = correct_tab_line_fill_highlights })
vim.api.nvim_create_autocmd("ColorScheme", { pattern = "*", group = augroup, callback = add_status_line_highlights })
vim.api.nvim_create_autocmd("ColorScheme", { pattern = "*", group = augroup, callback = correct_diff_highlights({ DiffAdd = 'String', DiffChange = 'Function', DiffDelete = 'Error' }) })

--
-- Tabline and statusline

local ICON_FILE = vim.fn.nr2char(0xf0214)
local ICON_FILE_MODIFIED = vim.fn.nr2char(0xf0224)
local ICON_FILE_READONLY = vim.fn.nr2char(0xf033e)
local ICON_FILE_READONLY_MODIFIED = vim.fn.nr2char(0xf0341)
local ICON_HELP = vim.fn.nr2char(0xf02d6)
local ICON_DIRECTORY = vim.fn.nr2char(0xf0770)
local ICON_TERMINAL = vim.fn.nr2char(0xf489)
local ICON_PREVIEW = vim.fn.nr2char(0xf0c7d)
local ICON_QUICKFIX = vim.fn.nr2char(0xf05b7)
local ICON_CHECK_HEALTH = vim.fn.nr2char(0xf08d0)

local LINE_START = "%#StatusLine#╺"
local LINE_END = "╸"

-- Rectangle
-- local LEFT_BUMP = ""
-- local RIGHT_BUMP = ""

-- Pill
local LEFT_BUMP = vim.fn.nr2char(0xe0b6)
local RIGHT_BUMP = vim.fn.nr2char(0xe0b4)

-- Skewed
-- local LEFT_BUMP = vim.fn.nr2char(0xe0ba)
-- local RIGHT_BUMP = vim.fn.nr2char(0xe0bc)

-- Hexagon
-- local LEFT_BUMP = vim.fn.nr2char(0xe0b2)
-- local RIGHT_BUMP = vim.fn.nr2char(0xe0b0)

-- Hexagon 2
-- local LEFT_BUMP = vim.fn.nr2char(0xf053) .. vim.fn.nr2char(0xe0b2)
-- local RIGHT_BUMP = vim.fn.nr2char(0xe0b0) .. vim.fn.nr2char(0xf054)

-- Hexagon 3
-- local LEFT_BUMP = vim.fn.nr2char(0xe0b3) .. vim.fn.nr2char(0xe0b2)
-- local RIGHT_BUMP = vim.fn.nr2char(0xe0b0) .. vim.fn.nr2char(0xe0b1)

local STATUSLINE_SPECIAL_LEFT_SIDE = "%#StatusLineSpecialSide#" .. LEFT_BUMP .. "%#StatusLineSpecialText# "
local STATUSLINE_SPECIAL_RIGHT_SIDE = " %#StatusLineSpecialSide#" .. RIGHT_BUMP .. "%#StatusLine#"
local STATUSLINE_DELIMITER = "%#StatusLineDelimiter# " .. vim.fn.nr2char(0xe216) .. " %#StatusLine#"
local STATUSLINE_END = LINE_START .. '%{" "}'

function ensure_trailing_slash(path)
	if path ~= "/" then
		path = path .. "/"
	end

	return path
end

function home_relative_or_absolute_dir_path(path)
	local path = vim.fn.fnamemodify(path, ":~")
	return ensure_trailing_slash(path)
end

function relative_or_home_relative_or_absolute_path(path, root)
	local where, how_much = path:find(root, 1, true)
	if not where or where > 1 then
		return vim.fn.fnamemodify(path, ":~")
	end

	local prefix = root == "/" and "/" or "."
	return prefix .. path:sub(how_much + 1, #path)
end

function relative_or_absolute_dir_path(path, root)
	local path = relative_or_home_relative_or_absolute_path(path, root)
	return ensure_trailing_slash(path)
end

function buffer_icon(buffer_number, buffer_type, file_type)
	if buffer_type == "help" then
		return ICON_HELP
	elseif buffer_type == "terminal" then
		return ICON_TERMINAL
	elseif buffer_type == "quickfix" then
		return ICON_QUICKFIX
	end

	if file_type == "netrw" then
		return ICON_DIRECTORY
	elseif file_type == "checkhealth" then
		return ICON_CHECK_HEALTH
	end

	if vim.bo[buffer_number].readonly then
		if vim.bo[buffer_number].modified then
			return ICON_FILE_READONLY_MODIFIED
		else
			return ICON_FILE_READONLY
		end
	end

	if vim.bo[buffer_number].modified then
		return ICON_FILE_MODIFIED
	else
		return ICON_FILE
	end
end

function tab_label(tab_number)
	local buffer_list = vim.fn.tabpagebuflist(tab_number)
	local window_number = vim.fn.tabpagewinnr(tab_number) -- vim.api.nvim_tabpage_get_win()
	local buffer_number = buffer_list[window_number]
	local buffer_name = vim.fn.bufname(buffer_number)
	local buffer = vim.bo[buffer_number]

	local icon = buffer_icon(buffer_number, buffer.buftype, buffer.filetype)

	local label = nil
	if buffer.filetype == "netrw" then
		local netrw_current_dir = vim.fn.expand(vim.api.nvim_buf_get_var(buffer_number, "netrw_curdir"))
		label = vim.fn.fnamemodify(netrw_current_dir, ":t") .. "/"
	elseif buffer.filetype == "checkhealth" then
		label = "Healthcheck"
	elseif buffer.buftype == "quickfix" then
		label = "Quickfix List"
	elseif buffer_name == '' then
		label = "[No Name]"
	else
		label = vim.fn.fnamemodify(buffer_name, ":t")
	end

	return icon .. ' ' .. label
end

function tab_line()
	local line = "%#TabLineFill#━" .. LINE_END
	local printable_length = 0

	for index = 1, vim.fn.tabpagenr("$") do
		local tab_color = nil
		if index == vim.api.nvim_tabpage_get_number(0) then
			tab_color = "%#TabLineSel#"
		else
			tab_color = "%#TabLine#"
		end

		local label = tab_label(index)
		line = line .. tab_color .. " " .. label .. " "
		printable_length = printable_length + (1 + vim.fn.strdisplaywidth(label) + 1)
	end

	local cwd = home_relative_or_absolute_dir_path(vim.fn.getcwd())
	local liiine = string.rep("━", vim.o.columns - 2 - printable_length - 4 - #cwd - 2)
	line = line .. "%#TabLineFill#╺" .. liiine .. "%=" .. LINE_END .. ICON_DIRECTORY .. " " .. cwd .. "╺━"

	return line
end

function current_buffer_icon()
	local buffer_number = vim.api.nvim_win_get_buf(0)
	local buffer = vim.bo[buffer_number]
	return buffer_icon(buffer_number, buffer.buftype, buffer.filetype)
end

function current_buffer_name()
	local buffer_number = vim.api.nvim_win_get_buf(0)
	local buffer = vim.bo[buffer_number]

	if buffer.buftype == "acwrite" or buffer.buftype == "help" or buffer.buftype == "nofile" or buffer.buftype == "nowrite" or buffer.buftype == "quickfix" or buffer.buftype == "terminal" or buffer.buftype == "prompt" then
		return "%F"
	end

	local buffer_name = vim.api.nvim_buf_get_name(buffer_number)
	if buffer_name == "" then
		return "%F"
	end

	buffer_name = relative_or_home_relative_or_absolute_path(buffer_name, vim.fn.getcwd())
	buffer_name = buffer_name:gsub(" ", "\u{00a0}")

	return buffer_name
end

function current_buffer_file_type()
	local buffer_number = vim.api.nvim_win_get_buf(0)
	local buffer = vim.bo[buffer_number]
	return buffer.filetype == "" and string.rep(vim.fn.nr2char(183), 3) or buffer.filetype
end

function status_line()
	local buffer_number = vim.api.nvim_win_get_buf(0)
	local buffer = vim.bo[buffer_number]

	if buffer.filetype == "netrw" then
		local netrw_current_dir = vim.fn.expand(vim.api.nvim_buf_get_var(0, "netrw_curdir"))
		local path = relative_or_absolute_dir_path(netrw_current_dir, vim.fn.getcwd())
		return "%=" .. LINE_END .. STATUSLINE_SPECIAL_LEFT_SIDE .. current_buffer_icon() .. " netrw" .. STATUSLINE_SPECIAL_RIGHT_SIDE .. " %#StatusLineBufferName#" .. path .. STATUSLINE_END
	end

	if buffer.buftype == "" then
		return
			"%#StatusLine#%=" .. LINE_END
			.. (vim.wo.previewwindow and STATUSLINE_SPECIAL_LEFT_SIDE .. ICON_PREVIEW .. " Preview" .. STATUSLINE_SPECIAL_RIGHT_SIDE .. " " or "")
			.. "%#StatusLineBufferName#" .. current_buffer_icon() .. " " .. current_buffer_name()
			.. STATUSLINE_DELIMITER .. "%#StatusLineFileType#" .. current_buffer_file_type()
			.. STATUSLINE_DELIMITER .. "%#StatusLineEncoding#" .. (buffer.fileencoding ~= "" and buffer.fileencoding or vim.o.encoding)
			.. STATUSLINE_DELIMITER .. "%#StatusLineLEFormat#" .. buffer.fileformat
			.. STATUSLINE_DELIMITER .. "%#StatusLineLineCount#" .. vim.fn.nr2char(0xf0bc3) .. " %L"
			.. STATUSLINE_END
	end

	if buffer.buftype == "nofile" then
		if buffer.filetype == "checkhealth" then
			return "%=" .. LINE_END .. STATUSLINE_SPECIAL_LEFT_SIDE .. ICON_CHECK_HEALTH .. " Healthcheck" .. STATUSLINE_SPECIAL_RIGHT_SIDE .. STATUSLINE_END
		end

		-- and other plugin managers, I guess...
	end

	if buffer.buftype == "help" then
		return "%=" .. LINE_END .. STATUSLINE_SPECIAL_LEFT_SIDE .. ICON_HELP .. " Help" .. STATUSLINE_SPECIAL_RIGHT_SIDE .. " %#StatusLineBufferName#" .. vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buffer_number), ":t") .. STATUSLINE_END
	end

	if buffer.buftype == "terminal" then
		return "%=" .. LINE_END .. STATUSLINE_SPECIAL_LEFT_SIDE .. ICON_TERMINAL .. " Terminal" .. STATUSLINE_SPECIAL_RIGHT_SIDE .. " %#StatusLineBufferName#%F" .. STATUSLINE_END
	end

	return "%=" .. LINE_END .. "%#StatusLineBufferName#%F" .. STATUSLINE_END
end

function quickfix_list_status_line()
	return "%=" .. LINE_END .. STATUSLINE_SPECIAL_LEFT_SIDE .. ICON_QUICKFIX .. " Quickfix List" .. STATUSLINE_SPECIAL_RIGHT_SIDE .. STATUSLINE_END
end

vim.opt.fillchars:append {stl = "━", stlnc = "━", vert = "┃", horizup = "┻", horizdown = "┳", vertleft = "┫", vertright = "┣", verthoriz = "╋", wbr = "═", msgsep = "═"}

vim.opt.showtabline = 2
vim.opt.tabline = "%!v:lua.tab_line()"
vim.opt.statusline = "%{%v:lua.status_line()%}"

local augroup = vim.api.nvim_create_augroup("status_line_customization", { clear = true })
vim.api.nvim_create_autocmd("FileType", { pattern = "qf", group = augroup, callback = function() vim.wo.statusline = "%!v:lua.quickfix_list_status_line()" end } )

