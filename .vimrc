" VARIABLES

let s:guifonts = {"gui_macvim": "Source Code Pro for Powerline:h11", "rest": "DejaVu_Sans_mono_for_Powerline:h8"}
let s:thumb_keys = {"gui_macvim": "D", "rest": "A"}

let s:alternate_switch = "<T-/>h"
let s:alternate_switch_to_split = "<T-/>sh"
let s:alternate_switch_to_vsplit = "<T-/>vh"

let s:unite_file_rec = "<T-/>f"
let s:unite_buffer = "<T-/>b"
let s:unite_file_mru = "<T-/>m"
let s:unite_grep = "<T-/>p"
let s:unite_gtags = "<T-/>t"
let s:unite_open_in_split = "s"
let s:unite_open_in_vsplit = "v"
let s:unite_open_in_tab = "t"

let s:neocomplcache_manual_complete = "<T-c>"

let s:camelcasemotion_w = "<Leader>w"
let s:camelcasemotion_b = "<Leader>b"
let s:camelcasemotion_e = "<Leader>e"
let s:camelcasemotion_iw = "i<Leader>w"
let s:camelcasemotion_ib = "i<Leader>b"
let s:camelcasemotion_ie = "i<Leader>e"

let s:visual_block = "<T-v>"
let s:redo = "<T-r>"
let s:screen_down = "<T-f>"
let s:screen_up = "<T-b>"
let s:page_down = "<T-d>"
let s:page_up = "<T-u>"
let s:scroll_down = "<T-e>"
let s:scroll_up = "<T-y>"
let s:window_cmd = "<T-w>"
let s:redraw = "<T-l>"
let s:next_in_jump_list = "<T-o>"

let s:jump_to_definition = "<CR>"
let s:jump_back = "<Backspace>"

let s:turn_off_current_search_highlight = "<T-8>"
let s:update_file = "<T-p>"
let s:force_update_file = "<T-P>"

let s:tab_new = "<T-t>"
let s:tab_next = "<T-}>"
let s:tab_prev = "<T-{>"


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


function! s:HotkeyWithThumbKey(hotkey)
	return substitute(a:hotkey, "<T-", "<".s:thumb_key."-", "")
endfunction

function! s:Map(mapArguments, hotkey, command)
	execute "map <silent>".a:mapArguments." ".s:HotkeyWithThumbKey(a:hotkey)." ".a:command
endfunction

function! s:NoReMap(mapArguments, hotkey, command)
	execute "noremap <silent>".a:mapArguments." ".s:HotkeyWithThumbKey(a:hotkey)." ".a:command
endfunction

function! s:NNoReMap(mapArguments, hotkey, command)
	execute "nnoremap <silent>".a:mapArguments." ".s:HotkeyWithThumbKey(a:hotkey)." ".a:command
endfunction

function! s:INoReMap(mapArguments, hotkey, command)
	execute "inoremap <silent>".a:mapArguments." ".s:HotkeyWithThumbKey(a:hotkey)." ".a:command
endfunction

function! s:VNoReMap(mapArguments, hotkey, command)
	execute "vnoremap <silent>".a:mapArguments." ".s:HotkeyWithThumbKey(a:hotkey)." ".a:command
endfunction

function! s:OMap(mapArguments, hotkey, command)
	execute "omap <silent>".a:mapArguments." ".s:HotkeyWithThumbKey(a:hotkey)." ".a:command
endfunction

function! s:XMap(mapArguments, hotkey, command)
	execute "xmap <silent>".a:mapArguments." ".s:HotkeyWithThumbKey(a:hotkey)." ".a:command
endfunction


" MAPPINGS

function! s:SetMappings()
	" More convinient key maps, than standard one's
	call s:NNoReMap("", s:visual_block, "<C-v>")
	call s:VNoReMap("", s:visual_block, "<C-v>")
	call s:NNoReMap("", s:redo, ":redo <CR>")
	call s:NoReMap("", s:screen_down, "<C-f>")
	call s:NoReMap("", s:screen_up, "<C-b>")
	call s:NoReMap("", s:page_down, "<C-d>")
	call s:NoReMap("", s:page_up, "<C-u>")
	call s:NoReMap("", s:scroll_down, "<C-e>")
	call s:NoReMap("", s:scroll_up, "<C-y>")
	call s:NoReMap("", s:window_cmd, "<C-w>")
	call s:NoReMap("", s:redraw, "<C-l>")
	call s:NoReMap("", s:next_in_jump_list, "<C-o>")

	call s:NNoReMap("", s:jump_to_definition, "<C-]>")
	call s:NNoReMap("", s:jump_back, "<C-t>")

	" My hotkeys
	call s:NNoReMap("", s:turn_off_current_search_highlight, ":nohlsearch <CR>")
	call s:NNoReMap("", s:update_file, ":e <CR>")
	call s:NNoReMap("", s:force_update_file, ":e! <CR>")

	" Tab hotkeys for gvim
	if !has("gui_macvim")
		call s:NNoReMap("", s:tab_new, ":tabnew <CR>")
		call s:NNoReMap("", s:tab_next, ":tabnext <CR>")
		call s:NNoReMap("", s:tab_prev, ":tabprev <CR>")
	endif

	" unite
	if has("gui_macvim")
		call s:NNoReMap("", s:unite_file_rec, ":Unite -buffer-name=Files -start-insert file_rec/async <CR>")
	elseif has("gui_win32")
		call s:NNoReMap("", s:unite_file_rec, ":Unite -buffer-name=Files -start-insert file_rec <CR>")
	endif
	call s:NNoReMap("", s:unite_buffer, ":Unite -buffer-name=Recent buffer <CR>")
	call s:NNoReMap("", s:unite_file_mru, ":Unite -buffer-name=Recent file_mru <CR>")
	call s:NNoReMap("", s:unite_grep, ":Unite -buffer-name=Grep grep:. <CR>")
	call s:VNoReMap("", s:unite_grep, ":<C-U>call <SID>UniteGrepSelection() <CR>")
	call s:NNoReMap("", s:unite_gtags, ":Unite -buffer-name=Tags -start-insert -default-action=jump gtags/completion <CR>")

	" neocomplcache
	call s:INoReMap("<expr>", s:neocomplcache_manual_complete, "neocomplcache#start_manual_complete(['tags_complete', 'buffer_complete', 'vim_complete'])")

	" alternate
	call s:NNoReMap("", s:alternate_switch, ":A <CR>")
	call s:NNoReMap("", s:alternate_switch_to_split, ":AS <CR>")
	call s:NNoReMap("", s:alternate_switch_to_vsplit, ":AV <CR>")

	" CamelCaseMotion
	call s:Map("", s:camelcasemotion_w, "<Plug>CamelCaseMotion_w")
	call s:Map("", s:camelcasemotion_b, "<Plug>CamelCaseMotion_b")
	call s:Map("", s:camelcasemotion_e, "<Plug>CamelCaseMotion_e")
	call s:OMap("", s:camelcasemotion_iw, "<Plug>CamelCaseMotion_iw")
	call s:OMap("", s:camelcasemotion_ib, "<Plug>CamelCaseMotion_ib")
	call s:OMap("", s:camelcasemotion_ie, "<Plug>CamelCaseMotion_ie")
	call s:XMap("", s:camelcasemotion_iw, "<Plug>CamelCaseMotion_iw")
	call s:XMap("", s:camelcasemotion_ib, "<Plug>CamelCaseMotion_ib")
	call s:XMap("", s:camelcasemotion_ie, "<Plug>CamelCaseMotion_ie")
endfunction


function! s:SetupUniteMappings()
	call s:NNoReMap("<buffer><expr>", s:unite_open_in_split, "unite#do_action('split')")
	call s:NNoReMap("<buffer><expr>", s:unite_open_in_vsplit, "unite#do_action('vsplit')")
	call s:NNoReMap("<buffer><expr>", s:unite_open_in_tab, "unite#do_action('tabopen')")
endfunction


" PLUGINS

function! s:SetPluginsGVim()
	" neobundle
	if has('vim_starting')
		set runtimepath+=~/.vim/bundle/neobundle.vim/
		call neobundle#begin(expand("~/.vim/bundle/"))

		NeoBundleFetch "Shougo/neobundle.vim"
		NeoBundle "Shougo/vimproc.vim", {"build" : {
					\ "windows": "tools\\update-dll-mingw",
					\ "cygwin": "make -f make_cygwin.mak",
					\ "mac": "make -f make_mac.mak",
					\ "unix": "make -f make_unix.mak",
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
		NeoBundle "bkad/CamelCaseMotion"

		call neobundle#end()
		filetype plugin indent on
	endif

	" alternate
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

	" neocomplcache
	let g:neocomplcache_enable_at_startup = 1
	let g:neocomplcache_disable_auto_complete = 1
	let g:neocomplcache_use_vimproc = 1
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

function! s:AuCmdBufWinEnterHandler()
	if strpart(@%, 0, 9) != "[unite] -"
		match TrailingWhitespace /\s\+$/
	endif
endfunction

function! s:AuCmdInsertEnterHandler()
	if strpart(@%, 0, 9) != "[unite] -"
		match TrailingWhitespace /\s\+\%#\@<!$/
	endif
endfunction

function! s:AuCmdInsertLeaveHandler()
	if strpart(@%, 0, 9) != "[unite] -"
		match TrailingWhitespace /\s\+$/
	endif
endfunction

function! s:SetGVim()
	" common
	set encoding=utf-8 " should be set before any 'map' commands (hotkeys stored in strings were not set after first load of vimrc)

	let &guifont = s:PlatformValue(s:guifonts)

	let s:thumb_key = s:PlatformValue(s:thumb_keys)

	set guioptions-=T
	set guioptions-=m

	set noshowmode

	set nobackup
	set nowritebackup
	set noswapfile
	set autoread
	augroup AuGroupAutoSave
		autocmd TextChanged * call s:GentleSave()
		autocmd TextChangedI * call s:GentleSave()
	augroup END

	color inksplash
	if has("transparency")
		set transparency=5
	endif

"	" solarized
"	color solarized
"	set background=dark
"	let g:solarized_contrast = "high"

	match TrailingWhitespace /\s\+$/
	augroup AuGroupTrailingWhitespace
		autocmd BufWinEnter * call s:AuCmdBufWinEnterHandler()
		autocmd InsertEnter * call s:AuCmdInsertEnterHandler()
		autocmd InsertLeave * call s:AuCmdInsertLeaveHandler()
		autocmd BufWinLeave * call clearmatches()
	augroup END

	augroup AuGroupUnite
		autocmd FileType unite call s:SetupUniteMappings()
	augroup END
endfunction


" SETTINGS

set runtimepath+=~/.vim

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
	call s:SetMappings()
	call s:SetPluginsGVim()
else
	call s:SetTerminalVim()
endif

