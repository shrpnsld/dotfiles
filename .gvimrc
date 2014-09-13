if !has("gui_macvim")
	finish
endif

" <D-o> - jump list
macmenu File.Open\.\.\. key=<nop>

" <D-w> - window command
macmenu File.Close key=<nop>

" <D-p> - update file
macmenu File.Print key=<nop>

" <D-c> - autocomplete
macmenu Edit.Copy key=<nop>

" <D-v> - visual block
macmenu Edit.Paste key=<nop>

" <D-f> - down full screen
macmenu Edit.Find.Find\.\.\. key=<nop>

" <D-b> - up full screen
macmenu Tools.Make key=<nop>

" <D-l> - redraw screen
macmenu Tools.List\ Errors key=<nop>

