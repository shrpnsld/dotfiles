"
" Utils

function! s:GetFilesFromSearchString(search_string)
	let l:semicolon_index = stridx(a:search_string, ';')
	let l:files = strpart(a:search_string, 0, l:semicolon_index)
	return split(l:files, ',')
endfunction


function! s:GetStopDirsFromSearchString(search_string)
	let l:semicolon_index = stridx(a:search_string, ';')
	return strpart(a:search_string, l:semicolon_index, strlen(a:search_string))
endfunction


function! s:ParentPath(path)
	return strpart(a:path, 0, strridx(a:path, '/'))
endfunction


function! s:FindTagsFile()
	let l:tags_file_list = s:GetFilesFromSearchString(&tags)
	let l:stop_directories = s:GetStopDirsFromSearchString(&tags)

	for l:tags_file_name in l:tags_file_list
		let l:tags_file_path = findfile(l:tags_file_name, l:stop_directories)
		if l:tags_file_path != ''
			return l:tags_file_path
		endif
	endfor

	return ''
endfunction


function! s:DetectProjectRoot()
	let l:git_dir = finddir('.git', ';')
	if l:git_dir != ''
		return s:ParentPath(l:git_dir)
	endif

	let l:cmake_lists_file = findfile('CMakeLists.txt', ';')
	if l:cmake_lists_file != ''
		return s:ParentPath(l:cmake_lists_file)
	endif

	return ''
endfunction


function! s:FindPathForTags()
	let l:tags_file_path = s:FindTagsFile()
	if l:tags_file_path != ''
		return s:ParentPath(l:tags_file_path)
	endif

	let l:project_root_path = s:DetectProjectRoot()
	if l:project_root_path != ''
		return l:project_root_path
	endif

	return getcwd()
endfunction


"
" Autosave

function! s:GentleSave()
	if @% != "" && !&readonly && @% != ".git/COMMIT_EDITMSG" && @% != ".git/MERGE_MSG" && @% != "[Command Line]" && stridx(@%, "bash-fc-") == -1
		update
		call sy#start()
	endif
endfunction


augroup AuGroupAutoSave
	autocmd TextChanged * call s:GentleSave()
	autocmd InsertLeave * call s:GentleSave()
augroup END


"
" Color corrections

function! s:MatchTrailingWhitespaceOnBufWinEnterHandler()
	match TrailingWhitespace /\s\+$/
endfunction


function! s:MatchTrailingWhitespaceOnInsertEnterHandler()
	match TrailingWhitespace /\s\+\%#\@<!$/
endfunction


function! s:MatchTrailingWhitespaceOnInsertLeaveHandler()
	match TrailingWhitespace /\s\+$/
endfunction


function! s:UpdateTrailingWhitespaceColor()
	let l:normal_bg = synIDattr(hlID("Normal"), "bg")

	if l:normal_bg =~ '^\d\+$'
		let l:color_offset = 10
		let l:white_color = 255

		if l:normal_bg + l:color_offset <= l:white_color
			let l:another_color = l:normal_bg + l:color_offset
		else
			let l:another_color = l:normal_bg - l:color_offset
		endif

		exe "highlight TrailingWhitespace ctermfg=NONE ctermbg=".l:another_color." guifg=NONE guibg=NONE"
	else
		let l:color_offset = 0x242424
		let l:color_white = 0xFFFFFF

		let l:hex_value = "0x".strpart(l:normal_bg, 1)
		if l:hex_value + l:color_offset < l:color_white
			let l:another_color = printf("#%x", l:hex_value + l:color_offset)
		else
			let l:another_color = printf("#%x", l:hex_value - l:color_offset)
		endif

		exe "highlight TrailingWhitespace ctermfg=NONE ctermbg=NONE guifg=NONE guibg=".l:another_color
	endif
endfunction


function! s:UpdateMatchParenColor()
	highlight MatchParen cterm=NONE,bold,underline ctermfg=NONE ctermbg=NONE gui=NONE,bold,underline guifg=NONE guibg=NONE"
endfunction


augroup ColorSchemeRelativeCorrections
	autocmd ColorScheme * call s:UpdateTrailingWhitespaceColor()
	autocmd ColorScheme * call s:UpdateMatchParenColor()
augroup END


augroup TrailingWhitespaceHightlight
	autocmd BufWinenter * call s:MatchTrailingWhitespaceOnBufWinEnterHandler()
	autocmd InsertEnter * call s:MatchTrailingWhitespaceOnInsertEnterHandler()
	autocmd InsertLeave * call s:MatchTrailingWhitespaceOnInsertLeaveHandler()
	autocmd BufWinLeave * call clearmatches()
augroup END


"
" Tags

function! GenerateCTagsFile(...)
	if a:0 > 0
		let l:tags_dir_path = a:1
	else
		let l:tags_dir_path = s:FindPathForTags()
	endif

	execute "!cd ".l:tags_dir_path."; ctags -R"
endfunction


command! -nargs=? Ctags :call GenerateCTagsFile(<f-args>)


"
" Standard settings

set nocompatible

syntax enable
filetype plugin on

set path+=**
set tags=./tags;
set wildmenu

set clipboard+=unnamedplus

set number
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

call s:UpdateTrailingWhitespaceColor()
colorscheme moody
set guicursor=n-v-c-sm:block-blinkwait0-blinkon100-blinkoff100,i-ci-ve:ver25-blinkwait0-blinkon100-blinkoff100,r-cr-o:hor20


"
" File manager

let g:netrw_banner=0
let g:netrw_altv=1


"
" Coding and building

set makeprg=cd\ $(find\ .\ -type\ f\ -name\ Makefile\ -printf\ '\\%h\\n'\ -quit);\ make


"
" Plugins

call plug#begin('~/.local/share/nvim/plugged')
Plug 'https://github.com/mhinz/vim-signify'
call plug#end()

let g:signify_update_on_focusgained=1


"
" Themes

" https://github.com/rakr/vim-two-firewatch
" https://github.com/marcopaganini/termschool-vim-theme
" https://github.com/sts10/vim-pink-moon
" https://github.com/joshdick/onedark.vim
" https://github.com/rakr/vim-one
" https://github.com/mhartington/oceanic-next
" https://github.com/arcticicestudio/nord-vim
" https://github.com/nanotech/jellybeans.vim
" https://github.com/gregsexton/Atom
" https://github.com/romainl/Apprentice
" https://github.com/cocopon/iceberg.vim
" https://github.com/tyrannicaltoucan/vim-deep-space
" https://github.com/nightsense/carbonized

