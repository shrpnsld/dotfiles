--
-- Utils

function get_highlight_value(name, component, cterm, default)
	assert(component == "fg" or component == "bg", "'component' parameter expected to be 'fg' or 'bg'")

	local mode = cterm and "cterm" or ""

	local highlight = vim.api.nvim_get_hl(0, { name = name })
	if highlight.reverse then
		if component == "fg" then
			component = "bg"
		else
			component = "fg"
		end
	end

	local value = highlight[mode .. component]
	if not value then
		return default or "none"
	end

	return value
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
	local fg = get_highlight_value("Normal", "fg")
	local bg = get_highlight_value("Normal", "bg")
	local ctermfg = get_highlight_value("Normal", "fg", true)
	local ctermbg = get_highlight_value("Normal", "bg", true)

	vim.api.nvim_set_hl(0, "TabLineFill", { fg = fg, ctermfg = ctermfg })
	vim.api.nvim_set_hl(0, "TabLine", { fg = fg, bg = bg, ctermfg = ctermfg, ctermbg = ctermbg })
	vim.api.nvim_set_hl(0, "TabLineSel", { fg = bg, bg = fg, bold = true, ctermfg = ctermbg, ctermbg = ctermfg, cterm = { bold = true } })
end

function add_status_line_highlights()
	local normal_fg = get_highlight_value("Normal", "fg")
	local normal_bg = get_highlight_value("Normal", "bg")
	local normal_ctermfg = get_highlight_value("Normal", "bg", true)
	local normal_ctermbg = get_highlight_value("Normal", "fg", true)
	local string_fg = get_highlight_value("String", "fg")
	local string_ctermfg = get_highlight_value("String", "fg", true)
	local function_fg = get_highlight_value("Function", "fg")
	local function_ctermfg = get_highlight_value("Function", "fg", true)
	local keyword_fg = get_highlight_value("Keyword", "fg")
	local keyword_ctermfg = get_highlight_value("Keyword", "fg", true)
	local number_fg = get_highlight_value("Number", "fg")
	local number_ctermfg = get_highlight_value("Number", "fg", true)

	vim.api.nvim_set_hl(0, "StatusLineDelimiter", { fg = normal_fg, ctermfg = normal_ctermfg })
	vim.api.nvim_set_hl(0, "StatusLineSpecialText", { fg = normal_bg, bg = string_fg, bold = true, ctermfg = normal_ctermbg, ctermbg = string_ctermfg, cterm = { bold = true } })
	vim.api.nvim_set_hl(0, "StatusLineSpecialSide", { fg = string_fg, bg = normal_bg, bold = true, ctermfg = string_ctermfg, ctermbg = normal_ctermbg, cterm = { bold = true } })
	vim.api.nvim_set_hl(0, "StatusLineBufferName", { fg = string_fg, ctermfg = string_ctermfg })
	vim.api.nvim_set_hl(0, "StatusLineFileType", { fg = function_fg, ctermfg = function_ctermfg })
	vim.api.nvim_set_hl(0, "StatusLineEncoding", { fg = keyword_fg, ctermfg = keyword_ctermfg })
	vim.api.nvim_set_hl(0, "StatusLineLEFormat", { fg = keyword_fg, ctermfg = keyword_ctermfg })
	vim.api.nvim_set_hl(0, "StatusLineLineCount", { fg = number_fg, ctermfg = number_ctermfg })
end

local augroup = vim.api.nvim_create_augroup("ColorSchemeCorrections", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", { pattern = "*", group = augroup, callback = correct_cursor_line_highlights })
vim.api.nvim_create_autocmd("ColorScheme", { pattern = "*", group = augroup, callback = correct_match_paren_highlights })
vim.api.nvim_create_autocmd("ColorScheme", { pattern = "*", group = augroup, callback = correct_window_highlights })
vim.api.nvim_create_autocmd("ColorScheme", { pattern = "*", group = augroup, callback = correct_status_line_highlights })
vim.api.nvim_create_autocmd("ColorScheme", { pattern = "*", group = augroup, callback = correct_tab_line_fill_highlights })
vim.api.nvim_create_autocmd("ColorScheme", { pattern = "*", group = augroup, callback = add_status_line_highlights })

--
-- Tabline and statusline

local ICON_FILE = vim.fn.nr2char(0xf0214)
local ICON_FILE_MODIFIED = vim.fn.nr2char(0xf0224)
local ICON_FILE_READONLY = vim.fn.nr2char(0xf033e)
local ICON_FILE_READONLY_MODIFIED = vim.fn.nr2char(0xf0341)
local ICON_HELP = vim.fn.nr2char(0xf02d6)
local ICON_DIRECTORY = vim.fn.nr2char(0xf0770)
local ICON_PLUGIN = vim.fn.nr2char(0xf40e)
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

function home_relative_or_absolute_path(path)
	local path = vim.fn.fnamemodify(path, ":~")
	return path == "/" and path or path .. "/"
end

function relative_or_absolute_dir_path(path, root)
	local where, how_much = path:find(root)
	if not where or where > 1 then
		return home_relative_or_absolute_path(path)
	end

	local path = "." .. path:sub(how_much + 1, #path)
	if path == "./" then
		return path
	end

	return path .. "/"
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
	elseif file_type == "lazy.nvim" or file_type == "vim-plug" then
		return ICON_PLUGIN
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

	local cwd = home_relative_or_absolute_path(vim.fn.getcwd())
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

	buffer_name = buffer_name:gsub(" ", "\u{00a0}")

	if buffer_name:sub(1, 1) == "/" then
		buffer_name = vim.fn.fnamemodify(buffer_name, ":~")
		return vim.fn.fnamemodify(buffer_name, ":.")
	end

	if buffer_name:sub(1, 2) ~= "./" then
		return "./" .. buffer_name
	end

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
		if buffer.filetype == "vim-plug" then
			return "%=" .. LINE_END .. STATUSLINE_SPECIAL_LEFT_SIDE .. ICON_PLUGIN .. " vim-plug" .. STATUSLINE_SPECIAL_RIGHT_SIDE .. STATUSLINE_END
		end

		if buffer.filetype == "lazy.nvim" then
			return "%=" .. LINE_END .. STATUSLINE_SPECIAL_LEFT_SIDE .. ICON_PLUGIN .. " lazy.nvim" .. STATUSLINE_SPECIAL_RIGHT_SIDE .. STATUSLINE_END
		end

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

