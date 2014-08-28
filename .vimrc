" VARIABLES

let s:guifonts = {"gui_macvim": "Source Code Pro for Powerline:h11", "rest": "DejaVu_Sans_mono_for_Powerline:h8"}
let s:hotkey_leaders = {"gui_macvim": "D", "rest": "A"}

let s:alternate_switch = "<Tab>h"

let s:unite_file_rec = "<Tab>f"
let s:unite_buffer = "<Tab>b"
let s:unite_file_mru = "<Tab>m"
let s:unite_grep = "<Tab>p"
let s:unite_gtags = "<Tab>t"
let s:unite_open_in_split = "s"
let s:unite_open_in_vsplit = "v"
let s:unite_open_in_tab = "t"

let s:visual_block = "<L-v>"
let s:redo = "<L-r>"
let s:screen_down = "<L-f>"
let s:screen_up = "<L-b>"
let s:page_down = "<L-d>"
let s:page_up = "<L-u>"
let s:scroll_down = "<L-e>"
let s:scroll_up = "<L-y>"
let s:window_cmd = "<L-w>"
let s:redraw = "<L-l>"

let s:jump_to_definition = "<CR>"
let s:jump_back = "<Backspace>"

let s:turn_off_current_search_highlight = "<L-8>"
let s:update_file = "<L-p>"
let s:force_update_file = "<L-P>"

let s:tab_new = "<L-t>"
let s:tab_next = "<L-}>"
let s:tab_prev = "<L-{>"
let s:tab_close = "<L-w>"


" BASIC FUNCTIONS

function! s:PlatformValue(dictionary)
	for platform in ["gui_macvim", "gui_win32"]
		if has(platform)
			if has_key(a:dictionary, platform)
				return a:dictionary[platform]
			else
				return a:dictionary["rest"]
			endif
		endif
	endfor

	echoerr "no key for current platform in ".string(a:dictionary)
endfunction


function! s:HotkeyWithLeader(hotkey)
	return substitute(a:hotkey, "<L-", "<".s:hotkey_leader."-", "")
endfunction

function! s:NoReMap(mapArguments, hotkey, command)
	execute "noremap ".a:mapArguments." ".s:HotkeyWithLeader(a:hotkey)." ".a:command
endfunction

function! s:NNoReMap(mapArguments, hotkey, command)
	execute "nnoremap ".a:mapArguments." ".s:HotkeyWithLeader(a:hotkey)." ".a:command
endfunction

function! s:VNoReMap(mapArguments, hotkey, command)
	execute "vnoremap ".a:mapArguments." ".s:HotkeyWithLeader(a:hotkey)." ".a:command
endfunction


" SPLITS

function! s:MapKeys()
	" More convinient key maps, than standard one's
	call s:NNoReMap("<silent>", s:visual_block, "<C-v>")
	call s:VNoReMap("<silent>", s:visual_block, "<C-v>")
	call s:NNoReMap("<silent>", s:redo, ":redo <CR>")
	call s:NoReMap("<silent>", s:screen_down, "<C-f>")
	call s:NoReMap("<silent>", s:screen_up, "<C-b>")
	call s:NoReMap("<silent>", s:page_down, "<C-d>")
	call s:NoReMap("<silent>", s:page_up, "<C-u>")
	call s:NoReMap("<silent>", s:scroll_down, "<C-e>")
	call s:NoReMap("<silent>", s:scroll_up, "<C-y>")
	call s:NoReMap("<silent>", s:window_cmd, "<C-w>")
	call s:NoReMap("<silent>", s:redraw, "<C-l>")

	call s:NNoReMap("<silent>", s:jump_to_definition, "<C-]>")
	call s:NNoReMap("<silent>", s:jump_back, "<C-t>")

	" User Hotkeys
	call s:NNoReMap("<silent>", s:turn_off_current_search_highlight, ":nohlsearch <CR>")
	call s:NNoReMap("<silent>", s:update_file, ":e <CR>")
	call s:NNoReMap("<silent>", s:force_update_file, ":e! <CR>")

	" Tab hotkeys
	if !has("gui_macvim")
		call s:NNoReMap("<silent>", s:tab_new, ":tabnew <CR>")
		call s:NNoReMap("<silent>", s:tab_next, ":tabnext <CR>")
		call s:NNoReMap("<silent>", s:tab_prev, ":tabprev <CR>")
		call s:NNoReMap("<silent>", s:tab_close, ":tabclose <CR>")
	endif
endfunction


" PLUGINS

function! s:SetUniteForCurrentBuffer()
	call s:NNoReMap("<silent><buffer><expr>", s:unite_open_in_split, "unite#do_action('split')")
	call s:NNoReMap("<silent><buffer><expr>", s:unite_open_in_vsplit, "unite#do_action('vsplit')")
	call s:NNoReMap("<silent><buffer><expr>", s:unite_open_in_tab, "unite#do_action('tabopen')")
endfunction

function! s:SetPluginsGVim()
	if has('vim_starting')
		set runtimepath+=~/.vim/bundle/neobundle.vim/
		call neobundle#begin(expand("~/.vim/bundle/"))

		NeoBundleFetch "Shougo/neobundle.vim"
		NeoBundle "Shougo/vimproc.vim", {"build" : {
				\ "windows" : "tools\\update-dll-mingw",
				\ "cygwin" : "make -f make_cygwin.mak",
				\ "mac" : "make -f make_mac.mak",
				\ "unix" : "make -f make_unix.mak",
			\ },
		\ }
		NeoBundle "Shougo/unite.vim"
		NeoBundle "Shougo/neomru.vim"
		NeoBundle "hewes/unite-gtags"
		NeoBundle "vim-scripts/gtags.vim"
		NeoBundle "Shougo/neocomplcache"
		NeoBundle "dantler/vim-alternate"
		NeoBundle "bling/vim-airline"
		NeoBundle "altercation/vim-colors-solarized"

		call neobundle#end()
		filetype plugin indent on
	endif

	" alternate
	call s:NNoReMap("<silent>", s:alternate_switch, ":A <CR>")

	let g:alternateNoDefaultAlternate = 1

	" alternate: C/C++/Objective-C
	let g:alternateExtensions_h = "c,C,cpp,CPP,cxx,CXX,cc,CC,m,M,mm,MM"
	let g:alternateExtensions_H = "c,C,cpp,CPP,cxx,CXX,cc,CC,m,M,mm,MM"
	let g:alternateExtensions_hpp = "c,C,cpp,CPP"
	let g:alternateExtensions_HPP = "c,C,cpp,CPP"
	let g:alternateExtensions_c = "h,H"
	let g:alternateExtensions_C = "h,H"
	let g:alternateExtensions_cpp = "h,H,hpp,HPP"
	let g:alternateExtensions_CPP = "h,H,hpp,HPP"
	let g:alternateExtensions_cc = "h,H"
	let g:alternateExtensions_CC = "h,H"
	let g:alternateExtensions_cxx = "h,H"
	let g:alternateExtensions_CXX = "h,H"
	let g:alternateExtensions_m = "h,H"
	let g:alternateExtensions_M = "h,H"
	let g:alternateExtensions_mm = "h,H"
	let g:alternateExtensions_MM = "h,H"

	" alternate: Erlang
	let g:alternateExtensions_hrl = "erl,ERL"
	let g:alternateExtensions_HRL = "erl,ERL"
	let g:alternateExtensions_erl = "hrl,HRL"
	let g:alternateExtensions_ERL = "hrl,HRL"

	" vim-airline
	let g:airline_powerline_fonts = 1
	let g:airline_section_y = ""

	" Unite
	call unite#filters#matcher_default#use(["matcher_fuzzy"])
	call unite#filters#sorter_default#use(["sorter_rank"])
	let g:unite_source_grep_recursive_opt = "-R"

	if has("gui_macvim")
		call s:NNoReMap("<silent>", s:unite_file_rec, ":Unite -buffer-name=Files -start-insert file_rec/async <CR>")
	elseif has("gui_win32")
		call s:NNoReMap("<silent>", s:unite_file_rec, ":Unite -buffer-name=Files -start-insert file_rec <CR>")
	endif
	call s:NNoReMap("<silent>", s:unite_buffer, ":Unite -buffer-name=Recent buffer <CR>")
	call s:NNoReMap("<silent>", s:unite_file_mru, ":Unite -buffer-name=Recent file_mru <CR>")
	call s:NNoReMap("<silent>", s:unite_grep, ":Unite -buffer-name=Grep grep:. <CR>")
	call s:VNoReMap("<silent>", s:unite_grep, ":<C-U>call <SID>UniteGrepSelection() <CR>")
	call s:NNoReMap("<silent>", s:unite_gtags, ":Unite -buffer-name=Tags -start-insert -default-action=jump gtags/completion <CR>")

	augroup AuGroupUnite
		autocmd FileType unite call s:SetUniteForCurrentBuffer()
	augroup END

	let g:neocomplcache_enable_at_startup = 1
endfunction


" OTHER

function! s:GentleSave()
	if @% != "" && !&readonly
		update
	endif
endfunction

function! s:SelectedText()
	let [lnum1, col1] = getpos("'<")[1:2]
	let [lnum2, col2] = getpos("'>")[1:2]
	let lines = getline(lnum1, lnum2)
	let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
	let lines[0] = lines[0][col1 - 1:]
	return join(lines, "")
endfunction

function! s:UniteGrepSelection()
	execute ":Unite -buffer-name=Grep -input=".s:SelectedText()." grep:."
endfunction

function! s:SetTerminalVim()
	set showmode
endfunction

function! s:BufWinEnterHandler()
	if strpart(@%, 0, 9) != "[unite] -"
		match TrailingWhitespace /\s\+$/
	endif
endfunction

function! s:InsertEnterHandler()
	if strpart(@%, 0, 9) != "[unite] -"
		match TrailingWhitespace /\s\+\%#\@<!$/
	endif
endfunction

function! s:InsertLeaveHandler()
	if strpart(@%, 0, 9) != "[unite] -"
		match TrailingWhitespace /\s\+$/
	endif
endfunction

function! s:SetGVim()
	" common
	set encoding=utf-8 " should be set before any 'map' commands (hotkeys stored in strings were not set after first load of vimrc)

	let &guifont = s:PlatformValue(s:guifonts)

	let s:hotkey_leader = s:PlatformValue(s:hotkey_leaders)

	set guioptions-=T
	set guioptions-=m

	set noshowmode

	set nobackup
	set nowritebackup
	set noswapfile
	set autoread
	augroup AuGroupAutoSave
		autocmd TextChanged * call s:GentleSave()
	augroup END

	color inksplash
	set transparency=5

"	" solarized
"	color solarized
"	set background=dark
"	let g:solarized_contrast = "high"

	match TrailingWhitespace /\s\+$/
	augroup AuGroupTrailingWhitespace
		autocmd BufWinEnter * call s:BufWinEnterHandler()
		autocmd InsertEnter * call s:InsertEnterHandler()
		autocmd InsertLeave * call s:InsertLeaveHandler()
		autocmd BufWinLeave * call clearmatches()
	augroup END
endfunction


" SETTINGS

set nocompatible

set laststatus=2
set showcmd
set wildmenu
set number

set tabstop=4
set shiftwidth=4
set smartindent
set wrap
set scrolloff=5
set backspace=indent,eol,start

set hidden
set clipboard=unnamed

set ignorecase
set smartcase
set hlsearch

syntax on

if has("gui_running")
	call s:SetGVim()
	call s:MapKeys()
	call s:SetPluginsGVim()
else
	call s:SetTerminalVim()
endif

