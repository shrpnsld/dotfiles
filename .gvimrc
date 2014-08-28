" FUNCTIONS

function! GVimMac()
	" <D-w> - window command
	macmenu File.Close key=<nop>

	" <D-p> - update file
	macmenu File.Print key=<nop>

	" <D-v> - visual block
	macmenu Edit.Paste key=<nop>

	" <D-f> - down full screen
	macmenu Edit.Find.Find\.\.\. key=<nop>

	" <D-b> - up full screen
	macmenu Tools.Make key=<nop>

	" <D-l> - redraw screen
	macmenu Tools.List\ Errors key=<nop>
endfunction


function! GVimWindows()
endfunction


" SETTINGS

if has("gui_macvim")
	call GVimMac()
elseif has("gui_win32")
	call GVimWindows()
endif
