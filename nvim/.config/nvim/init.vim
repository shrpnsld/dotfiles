"
" Utils

function! s:GetHighlightValue(name, mode, component, reverse_component, default)
	let is_reverse = synIDattr(hlID(a:name), 'reverse', a:mode)
	if ! is_reverse
		let component = a:component
	else
		let component = a:reverse_component
	endif

	let value = synIDattr(hlID(a:name), component, a:mode)
	if value ==# ''
		return a:default
	endif

	return value
endfunction

function! s:MoveTabLeft()
	if tabpagenr() > 1
		tabm -1
	else
		execute 'tabm '..tabpagenr('$')
	endif
endfunction

function! s:MoveTabRight()
	if tabpagenr() < tabpagenr('$')
		tabm +1
	else
		tabm 0
	endif
endfunction

"
" Color scheme additions and corrections

function! s:CorrectCursorLine()
	highlight! clear CursorLine
endfunction

function! s:CorrectMatchParenHighlights()
	highlight! MatchParen cterm=none,bold,underline ctermfg=none ctermbg=none gui=none,bold,underline guifg=none guibg=none
endfunction

function! s:CorrectWindowHighlights()
	highlight! link WinSeparator Normal
	highlight! link VertSplit Normal
endfunction

function! s:CorrectStatusLineHighlights()
	highlight! link StatusLine Normal

	" single character under split line, when right-side window is active
	highlight! StatusLineNC ctermfg=none ctermbg=none guifg=none guibg=none cterm=none
endfunction

function! s:AddStatusLineHighlights()
	let cterm_fg = s:GetHighlightValue('Normal', 'cterm', 'fg', 'bg', 'none')
	let gui_fg = s:GetHighlightValue('Normal', 'gui', 'fg', 'bg', 'none')
	execute 'highlight! StatusLineDelimiter ctermfg='..cterm_fg..' ctermbg=none cterm=none guifg='..gui_fg..' guibg=none gui=none'

	let cterm_fg = s:GetHighlightValue('String', 'cterm', 'fg', 'bg', 'none')
	let gui_fg = s:GetHighlightValue('String', 'gui', 'fg', 'bg', 'none')
	let cterm_bg = s:GetHighlightValue('Normal', 'cterm', 'bg', 'fg', 'none')
	let gui_bg = s:GetHighlightValue('Normal', 'gui', 'bg', 'fg', 'none')
	execute 'highlight! StatusLineSpecialText ctermfg='..cterm_bg..' ctermbg='..cterm_fg..' cterm=bold guifg='..gui_bg..' guibg='..gui_fg..' gui=bold'
	execute 'highlight! StatusLineSpecialSide ctermfg='..cterm_fg..' ctermbg='..cterm_bg..' cterm=bold guifg='..gui_fg..' guibg='..gui_bg..' gui=none'

	let cterm_fg = s:GetHighlightValue('String', 'cterm', 'fg', 'bg', 'none')
	let gui_fg = s:GetHighlightValue('String', 'gui', 'fg', 'bg', 'none')
	execute 'highlight! StatusLineBufferName ctermfg='..cterm_fg..' ctermbg=none cterm=none guifg='..gui_fg..' guibg=none gui=none'

	let cterm_fg = s:GetHighlightValue('Function', 'cterm', 'fg', 'bg', 'none')
	let gui_fg = s:GetHighlightValue('Function', 'gui', 'fg', 'bg', 'none')

	execute 'highlight! StatusLineFileType ctermfg='..cterm_fg..' ctermbg=none cterm=none guifg='..gui_fg..' guibg=none gui=none'

	let cterm_fg = s:GetHighlightValue('Keyword', 'cterm', 'fg', 'bg', 'none')
	let gui_fg = s:GetHighlightValue('Keyword', 'gui', 'fg', 'bg', 'none')

	execute 'highlight! StatusLineEncoding ctermfg='..cterm_fg..' ctermbg=none cterm=none guifg='..gui_fg..' guibg=none gui=none'
	execute 'highlight! StatusLineLEFormat ctermfg='..cterm_fg..' ctermbg=none cterm=none guifg='..gui_fg..' guibg=none gui=none'

	let cterm_fg = s:GetHighlightValue('Number', 'cterm', 'fg', 'bg', 'none')
	let gui_fg = s:GetHighlightValue('Number', 'gui', 'fg', 'bg', 'none')

	execute 'highlight! StatusLineLineCount ctermfg='..cterm_fg..' ctermbg=none cterm=none guifg='..gui_fg..' guibg=none gui=none'
endfunction

function! s:CorrectTabLineFillHighlights()
	let cterm_fg = s:GetHighlightValue('Normal', 'cterm', 'fg', 'bg', 'none')
	let cterm_bg = s:GetHighlightValue('Normal', 'cterm', 'bg', 'fg', 'none')
	let gui_fg = s:GetHighlightValue('Normal', 'gui', 'fg', 'bg', 'none')
	let gui_bg = s:GetHighlightValue('Normal', 'gui', 'bg', 'fg', 'none')

	execute 'highlight! TabLineFill ctermfg='..cterm_fg..' ctermbg=none cterm=none guifg='..gui_fg..' guibg=none gui=none'
	execute 'highlight! TabLine ctermfg='..cterm_fg..' ctermbg='..cterm_bg..' cterm=none guifg='..gui_fg..' guibg='..gui_bg..' gui=none'
	execute 'highlight! TabLineSel ctermfg='..cterm_bg..' ctermbg='..cterm_fg..' cterm=bold guifg='..gui_bg..' guibg='..gui_fg..' gui=bold'
endfunction

augroup ColorSchemeCorrections
	autocmd!
	autocmd ColorScheme * call s:CorrectCursorLine()
	autocmd ColorScheme * call s:CorrectMatchParenHighlights()
	autocmd ColorScheme * call s:CorrectWindowHighlights()
	autocmd ColorScheme * call s:CorrectStatusLineHighlights()
	autocmd ColorScheme * call s:CorrectTabLineFillHighlights()
	autocmd ColorScheme * call s:AddStatusLineHighlights()
augroup END

"
" Tabline and statusline

let s:ICON_FILE = nr2char(0xf0214)
let s:ICON_FILE_MODIFIED = nr2char(0xf0224)
let s:ICON_FILE_READONLY = nr2char(0xf033e)
let s:ICON_FILE_READONLY_MODIFIED = nr2char(0xf0341)
let s:ICON_HELP = nr2char(0xf02d6)
let s:ICON_DIRECTORY = nr2char(0xf0770)
let s:ICON_PLUGIN = nr2char(0xf40e)
let s:ICON_TERMINAL = nr2char(0xf489)
let s:ICON_PREVIEW = nr2char(0xf0c7d)
let s:ICON_QUICKFIX = nr2char(0xf05b7)

let s:LINE_START = '%#StatusLine#╺'
let s:LINE_END = '╸'

" Rectangle
"let s:LEFT_BUMP = ''
"let s:RIGHT_BUMP = ''

" Pill
let s:LEFT_BUMP = nr2char(0xe0b6)
let s:RIGHT_BUMP = nr2char(0xe0b4)

" Skewed
"let s:LEFT_BUMP = nr2char(0xe0ba)
"let s:RIGHT_BUMP = nr2char(0xe0bc)

" Hexagon
"let s:LEFT_BUMP = nr2char(0xe0b2)
"let s:RIGHT_BUMP = nr2char(0xe0b0)

" Hexagon 2
"let s:LEFT_BUMP = nr2char(0xf053)..nr2char(0xe0b2)
"let s:RIGHT_BUMP = nr2char(0xe0b0)..nr2char(0xf054)

" Hexagon 3
"let s:LEFT_BUMP = nr2char(0xe0b3)..nr2char(0xe0b2)
"let s:RIGHT_BUMP = nr2char(0xe0b0)..nr2char(0xe0b1)

let s:STATUSLINE_SPECIAL_LEFT_SIDE = '%#StatusLineSpecialSide#'..s:LEFT_BUMP..'%#StatusLineSpecialText# '
let s:STATUSLINE_SPECIAL_RIGHT_SIDE = ' %#StatusLineSpecialSide#'..s:RIGHT_BUMP..'%#StatusLine#'
let s:STATUSLINE_DELIMITER = '%#StatusLineDelimiter# '..nr2char(0xe216)..' %#StatusLine#'
let s:STATUSLINE_END = s:LINE_START..'%{" "}'

function! s:HomeRelativeOrAbsoluteDirPath(path)
	let path = fnamemodify(a:path, ':~')
	return path ==# '/' ? path : path..'/'
endfunction

function! s:RelativeOrAbsoluteDirPath(path, root)
	if stridx(a:path, a:root) != 0
		return s:HomeRelativeOrAbsoluteDirPath(a:path)
	endif

	let path = './'..a:path[strlen(a:root) + 1:strlen(a:path) - 1]
	if path ==# './'
		return path
	endif

	return path..'/'
endfunction

function! s:BufferIcon(buffer_number, buffer_type, file_type)
	if a:buffer_type ==# 'help'
		return s:ICON_HELP
	elseif a:buffer_type ==# 'terminal'
		return s:ICON_TERMINAL
	elseif a:buffer_type ==# 'quickfix'
		return s:ICON_QUICKFIX
	endif

	if a:file_type ==# 'netrw'
		return s:ICON_DIRECTORY
	elseif a:file_type ==# 'vim-plug'
		return s:ICON_PLUGIN
	endif

	let is_readonly = getbufvar(a:buffer_number, '&readonly')
	let is_modified = getbufvar(a:buffer_number, '&modified')

	if is_readonly
		if is_modified
			return s:ICON_FILE_READONLY_MODIFIED
		else
			return s:ICON_FILE_READONLY
		endif
	endif

	if is_modified
		return s:ICON_FILE_MODIFIED
	else
		return s:ICON_FILE
	endif
endfunction

function! s:TabLabel(tab_number)
	let buffer_list = tabpagebuflist(a:tab_number)
	let window_number = tabpagewinnr(a:tab_number)
	let buffer_number = buffer_list[window_number - 1]
	let buffer_name = bufname(buffer_number)
	let buffer_type = getbufvar(buffer_number, '&buftype')
	let file_type = getbufvar(buffer_number, '&filetype')

	let icon = s:BufferIcon(buffer_number, buffer_type, file_type)

	if file_type ==# 'netrw'
		let netrw_current_dir = expand(getbufvar(buffer_number, 'netrw_curdir'))
		let label = fnamemodify(netrw_current_dir, ':t')..'/'
	elseif buffer_type ==# 'quickfix'
		let label = 'Quickfix List'
	elseif buffer_name ==# ''
		let label = '[No Name]'
	else
		let label = fnamemodify(buffer_name, ':t')
	endif

	return icon..' '..label
endfunction

function! TabLine()
	let tab_line = '%#TabLineFill#━'..s:LINE_END
	let printable_length = 0

	for index in range(1, tabpagenr('$'))
		if index == tabpagenr()
			let tab_color = '%#TabLineSel#'
		else
			let tab_color = '%#TabLine#'
		endif

		let label = s:TabLabel(index)
		let tab_line ..= tab_color..' '..label..' '
		let printable_length += 1 + strdisplaywidth(label) + 1
	endfor

	let cwd = s:HomeRelativeOrAbsoluteDirPath(getcwd())
	let liiine = repeat('━', &g:columns - 2 - printable_length - 4 - strlen(cwd) - 2)
	let tab_line ..= '%#TabLineFill#╺'..liiine..'%='..s:LINE_END..s:ICON_DIRECTORY..' '..cwd..'╺━'

	return tab_line
endfunction

function! CurrentBufferIcon()
	let buffer_number = bufnr()
	let buffer_type = getbufvar(buffer_number, '&buftype')
	let file_type = getbufvar(buffer_number, '&filetype')
	return s:BufferIcon(buffer_number, buffer_type, file_type)
endfunction

function! CurrentBufferName()
	if &buftype ==# 'acwrite' || &buftype ==# 'help' || &buftype ==# 'nofile' || &buftype ==# 'nowrite' || &buftype ==# 'quickfix' || &buftype ==# 'terminal' || &buftype ==# 'prompt'
		return '%F'
	endif

	let buffer_name = bufname()
	if buffer_name ==# ''
		return '%F'
	endif

	let buffer_name = substitute(buffer_name, ' ', "\u00a0", 'g')

	if buffer_name[0] ==# '/'
		let buffer_name = fnamemodify(buffer_name, ':~')
		return fnamemodify(buffer_name, ':.')
	endif

	if buffer_name[0:1] !=# './'
		return './'..buffer_name
	endif

	return buffer_name
endfunction

function! s:FileType()
	if &filetype ==# ''
		return nr2char(183)..nr2char(183)..nr2char(183)
	else
		return &filetype
	endif
endfunction

function! StatusLine()
	if &filetype ==# 'netrw'
		let netrw_current_dir = expand(getbufvar(bufnr(), 'netrw_curdir'))
		let path = s:RelativeOrAbsoluteDirPath(netrw_current_dir, getcwd())
		return '%='..s:LINE_END..s:STATUSLINE_SPECIAL_LEFT_SIDE..CurrentBufferIcon()..' netrw'..s:STATUSLINE_SPECIAL_RIGHT_SIDE..' %#StatusLineBufferName#'..path..s:STATUSLINE_END
	endif

	if &buftype ==# ''
		return
			\ '%#StatusLine#%='..s:LINE_END
			\ ..(&previewwindow?s:STATUSLINE_SPECIAL_LEFT_SIDE..s:ICON_PREVIEW..' Preview'..s:STATUSLINE_SPECIAL_RIGHT_SIDE..' ':'')
			\ ..'%#StatusLineBufferName#'..CurrentBufferIcon()..' '..CurrentBufferName()
			\ ..s:STATUSLINE_DELIMITER..'%#StatusLineFileType#'..s:FileType()
			\ ..s:STATUSLINE_DELIMITER..'%#StatusLineEncoding#'..(&fileencoding?&fileencoding:&encoding)
			\ ..s:STATUSLINE_DELIMITER..'%#StatusLineLEFormat#'..&fileformat
			\ ..s:STATUSLINE_DELIMITER..'%#StatusLineLineCount#'..nr2char(0xf0bc3)..' %L'
			\ ..s:STATUSLINE_END
	endif

	if &buftype ==# 'nofile'
		if &filetype ==# 'vim-plug'
			return '%='..s:LINE_END..s:STATUSLINE_SPECIAL_LEFT_SIDE..s:ICON_PLUGIN..' vim-plug'..s:STATUSLINE_SPECIAL_RIGHT_SIDE..s:STATUSLINE_END
		endif

		"and other plugins, I guess...
	endif

	if &buftype ==# 'help'
		return '%='..s:LINE_END..s:STATUSLINE_SPECIAL_LEFT_SIDE..s:ICON_HELP..' Help'..s:STATUSLINE_SPECIAL_RIGHT_SIDE..' %#StatusLineBufferName#'..fnamemodify(bufname(), ':t')..s:STATUSLINE_END
	endif

	if &buftype ==# 'terminal'
		return '%='..s:LINE_END..s:STATUSLINE_SPECIAL_LEFT_SIDE..s:ICON_TERMINAL..' Terminal'..s:STATUSLINE_SPECIAL_RIGHT_SIDE..' %#StatusLineBufferName#%F'..s:STATUSLINE_END
	endif

	return '%='..s:LINE_END..'%#StatusLineBufferName#%F'..s:STATUSLINE_END
endfunction

function! QuickFixStatusLine()
	return '%='..s:LINE_END..s:STATUSLINE_SPECIAL_LEFT_SIDE..s:ICON_QUICKFIX..' Quickfix List'..s:STATUSLINE_SPECIAL_RIGHT_SIDE..s:STATUSLINE_END
endfunction

set showtabline=2
set tabline=%!TabLine()

set fillchars=
set fillchars+=stl:━,stlnc:━,vert:┃,horizup:┻,horizdown:┳,vertleft:┫,vertright:┣,verthoriz:╋,wbr:═,msgsep:═

set statusline=%{%StatusLine()%}

augroup StatusLineCustomization
	autocmd!

	"NOTE: setting 'statusline' for 'Quickfix List' is not working inside 'StatusLine()' function. but it works this way
	autocmd FileType qf setlocal statusline=%{%QuickFixStatusLine()%}
augroup END

"
" Standard settings

set nocompatible

syntax enable
filetype plugin on

set path+=**
set wildmenu
set laststatus=2
set showcmd
set showcmdloc=last

set clipboard^=unnamed,unnamedplus

set number
set cursorline
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab
set autoindent
set smartindent
set wrap
set scrolloff=5
set backspace=indent,eol,start
set matchpairs+=<:>

set ignorecase
set smartcase
set incsearch

set splitbelow
set splitright

set ttimeoutlen=0

set guicursor=n-v-c-sm:block-blinkwait0-blinkon100-blinkoff100,i-ci-ve:ver25-blinkwait0-blinkon100-blinkoff100,r-cr-o:hor20
set mouse=a

"
" File manager

let g:netrw_banner = 0
let g:netrw_altv = 1
let g:netrw_liststyle = 3
let g:netrw_sort_options = 'i'
let g:netrw_keepdir = 1

" preview on the right
let g:netrw_preview = 1
let g:netrw_alto = 0

"
" Coding and building

set makeprg=make-me

"
" Mappings

noremap <silent> <Tab> gt
noremap <silent> <S-Tab> gT
noremap <silent> <Leader><Tab> :call <SID>MoveTabRight()<CR>
noremap <silent> <Leader><S-Tab> :call <SID>MoveTabLeft()<CR>

noremap <silent> <Leader>a :make!<CR>
noremap <silent> <expr> <Leader>f empty(filter(getwininfo(), 'v:val.quickfix')) ? ':copen 20<CR>' : ':cclose<CR>'
noremap <silent> <Leader>p :pclose<CR>
noremap <silent> <Leader>w :bwipeout<CR>
noremap <silent> <Leader>t :Texplore<CR>
noremap <silent> <Leader>e :Explore<CR>
noremap <silent> <Leader>q :quit<CR>
noremap <silent> <Leader>/ :nohlsearch<CR>

"
" Plugins

call plug#begin('~/.local/share/nvim/plugged')
" Utility
	Plug 'mhinz/vim-signify'
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
	Plug 'shrpnsld/trailing-shade.vim'
	Plug 'shrpnsld/ocd-save.vim'

" Color schemes
	" 'termguicolors'
	Plug 'catppuccin/nvim', { 'as': 'catppuccin', 'branch': 'main' }
	Plug 'rebelot/kanagawa.nvim'
	Plug 'ghifarit53/tokyonight-vim'
	Plug 'tiagovla/tokyodark.nvim'
	Plug 'folke/tokyonight.nvim'
	Plug 'shrikecode/kyotonight.vim'
	Plug 'franbach/miramare'

	" giving a try
	Plug 'EdenEast/nightfox.nvim' " duskfox flavor
	Plug 'bluz71/vim-moonfly-colors'

	" color schemes 'notermguicolors'
	Plug 'dracula/vim', { 'as': 'dracula' }

" Archive
	"Plug 'godlygeek/csapprox'
call plug#end()

" catppuccin
set background=dark
colorscheme catppuccin-mocha

" signify
let g:signify_update_on_bufenter = 1
let g:signify_update_on_focusgained = 1
let g:signify_sign_add               = '┃'
let g:signify_sign_delete            = '┃'
let g:signify_sign_delete_first_line = '┃'
let g:signify_sign_change            = '┃'
let g:signify_sign_change_delete     = '┃'

augroup RefreshSignify
	autocmd!
	autocmd TextChanged * call sy#start()
	autocmd InsertLeave * call sy#start()
augroup END

" ocd-save
set noswapfile

" treesitter
lua <<EOF
require'nvim-treesitter.configs'.setup {
	ensure_installed = {
		"bash",
		"c",
		"cpp",
		"haskell",
		"ini",
		"json",
		"lua",
		"markdown",
		"vim",
		"vimdoc",
		"xml",
		"yaml"
	},

	highlight = {
		enable = true
	},
}
EOF

