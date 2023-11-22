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
" Color scheme corrections

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

function! s:AddStatusDelimiterHighlights()
	let cterm_fg = s:GetHighlightValue('Normal', 'cterm', 'fg', 'bg', 'none')
	let gui_fg = s:GetHighlightValue('Normal', 'gui', 'fg', 'bg', 'none')
	execute 'highlight! StatusLineDelimiter ctermfg='..cterm_fg..' ctermbg=none cterm=bold guifg='..gui_fg..' guibg=none gui=bold'
endfunction

function! s:CorrectTabLineFillHighlights()
	let cterm_fg = s:GetHighlightValue('Normal', 'cterm', 'fg', 'bg', 'none')
	let gui_fg = s:GetHighlightValue('Normal', 'gui', 'fg', 'bg', 'none')
	execute 'highlight! TabLineFill ctermfg='..cterm_fg..' ctermbg=none cterm=bold guifg='..gui_fg..' guibg=none gui=bold'
endfunction

augroup ColorSchemeCorrections
	autocmd!
	autocmd ColorScheme * call s:CorrectCursorLine()
	autocmd ColorScheme * call s:CorrectMatchParenHighlights()
	autocmd ColorScheme * call s:CorrectWindowHighlights()
	autocmd ColorScheme * call s:CorrectStatusLineHighlights()
	autocmd ColorScheme * call s:CorrectTabLineFillHighlights()
	autocmd ColorScheme * call s:AddStatusDelimiterHighlights()
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
let s:ICON_PREVIEW = nr2char(0xeb28)

let STATUSLINE_ICON_QUICK_FIX = nr2char(0xf05b7)
let STATUSLINE_DELIMITER = nr2char(0xe216)
let STATUSLINE_END = '  '

function! s:HomeRelativeOrAbsoluteDirPath(path)
	let path = fnamemodify(a:path, ':~')
	if path ==# '/'
		return path
	endif

	return path..'/'
endfunction

function! s:BufferIcon(buffer_number)
	let buftype = getbufvar(a:buffer_number, '&buftype')
	if buftype ==# 'help'
		return s:ICON_HELP
	elsseif buftype ==# 'terminal'
		return s:ICON_TERMINAL
	endif

	let file_type = getbufvar(a:buffer_number, '&filetype')
	if file_type ==# 'netrw'
		return s:ICON_DIRECTORY
	elseif file_type ==# 'vim-plug'
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

	let icon = s:BufferIcon(buffer_number)

	if buffer_name ==# ''
		let label = '[No Name]'
	else
		let label = fnamemodify(buffer_name, ':t')
	endif

	return icon..' '..label
endfunction

function! TabLine()
	let tab_line = '%#TabLineFill#━━ '
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
	let liiine = repeat('━', &g:columns - 3 - printable_length - 4 - strlen(cwd) - 3)
	let tab_line ..= '%#TabLineFill# '..liiine..'%= '..s:ICON_DIRECTORY..' '..cwd..' ━━'

	return tab_line
endfunction

function! CurrentBufferIcon()
	return s:BufferIcon(bufnr())
endfunction

function! CurrentBufferName()
	if &buftype ==# 'acwrite' || &buftype ==# 'help' || &buftype ==# 'nofile' || &buftype ==# 'nowrite' || &buftype ==# 'quickfix' || &buftype ==# 'terminal' || &buftype ==# 'prompt'
		return '%F'
	endif

	let buffer_name = bufname()
	if buffer_name ==# ''
		return '%F'
	endif

	if buffer_name[0] ==# '/'
		let buffer_name = fnamemodify(buffer_name, ':~')
		return fnamemodify(buffer_name, ':.')
	endif

	if buffer_name[0:1] !=# './'
		return './'..buffer_name
	endif

	return buffer_name
endfunction

function! FileType()
	if &filetype ==# ''
		return nr2char(183)..nr2char(183)..nr2char(183)
	endif

	return &filetype
endfunction

set showtabline=2
set tabline=%!TabLine()

set fillchars=
set fillchars+=stl:━,stlnc:━,vert:┃,horizup:┻,horizdown:┳,vertleft:┫,vertright:┣,verthoriz:╋,wbr:═,msgsep:═

set statusline=
set statusline+=%#Normal#%=\ 
set statusline+=%#String#%{%CurrentBufferIcon()%}\ %{%CurrentBufferName()%}%#Normal#
set statusline+=\ %#StatusLineDelimiter#%{STATUSLINE_DELIMITER}%#Normal#\ 
set statusline+=%#Function#%{FileType()}%#Normal#
set statusline+=\ %#StatusLineDelimiter#%{STATUSLINE_DELIMITER}%#Normal#\ 
set statusline+=%#Keyword#%{&fileencoding?&fileencoding:&encoding}%#Normal#
set statusline+=\ %#StatusLineDelimiter#%{STATUSLINE_DELIMITER}%#Normal#\ 
set statusline+=%#Keyword#%{&fileformat}%#Normal#
set statusline+=\ %#StatusLineDelimiter#%{STATUSLINE_DELIMITER}%#Normal#\ 
set statusline+=%#Number#%L%#Normal#
set statusline+=\ %{STATUSLINE_END}
set statusline+=%w

augroup StatusLineCustomization
	autocmd!
	autocmd FileType qf setlocal statusline=%=\ %#String#%{STATUSLINE_ICON_QUICK_FIX}\ [Quickfix\ List]%#Normal#\ ━━
	autocmd FileType netrw setlocal statusline=%=\ %#String#%{%CurrentBufferIcon()%}\ netrw%#Normal#\ ━━
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
set noswapfile

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

let g:netrw_banner=0
let g:netrw_altv=1
let g:netrw_liststyle=3
let g:netrw_sort_options='i'

" preview on the right
let g:netrw_preview=1
let g:netrw_alto=0

"
" Coding and building

set makeprg=make-me

"
" Bindings

noremap <silent> <Tab> gt
noremap <silent> <S-Tab> gT
noremap <silent> <Leader><Tab> :call <SID>MoveTabRight()<CR>
noremap <silent> <Leader><S-Tab> :call <SID>MoveTabLeft()<CR>

noremap <silent> <Leader>a :make<CR>
noremap <silent> <Leader>q :copen<CR>
noremap <silent> <Leader>w :cclose<CR>

noremap <silent> <Leader>p :pclose<CR>

"
" Plugins

call plug#begin('~/.local/share/nvim/plugged')
" utility
Plug 'mhinz/vim-signify'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'shrpnsld/trailing-shade.vim'
Plug 'shrpnsld/ocd-save.vim'

" color schemes 'termguicolors'
Plug 'catppuccin/nvim', { 'as': 'catppuccin', 'branch': 'main' }
Plug 'rebelot/kanagawa.nvim'
Plug 'ghifarit53/tokyonight-vim'
Plug 'tiagovla/tokyodark.nvim'
Plug 'folke/tokyonight.nvim'
Plug 'shrikecode/kyotonight.vim'
Plug 'franbach/miramare'

" color schemes 'notermguicolors'
Plug 'dracula/vim', { 'as': 'dracula' }

" archive
"Plug 'godlygeek/csapprox'
call plug#end()

" catppuccin
set background=dark
colorscheme catppuccin-mocha

" signify
let g:signify_update_on_bufenter=1
let g:signify_update_on_focusgained=1
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

