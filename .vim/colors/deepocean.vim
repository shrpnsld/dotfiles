""" Init
set background=dark
highlight clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name = "deepocean"

"""" GUI

highlight Cursor        gui=none guibg=white guifg=bg
highlight CursorIM      gui=bold guifg=white guibg=PaleTurquoise3
highlight CursorLine    gui=none guibg=#003853
highlight CursorColumn  gui=none guibg=#003853
highlight Directory     guifg=LightSeaGreen guibg=bg
highlight DiffAdd       gui=none guifg=fg guibg=DarkCyan
highlight DiffChange    gui=none guifg=fg guibg=Green4
highlight DiffDelete    gui=none guifg=fg guibg=black
highlight DiffText      gui=bold guifg=fg guibg=bg
highlight ErrorMsg      guifg=LightYellow  guibg=FireBrick
highlight VertSplit     gui=none guifg=grey60 guibg=grey60
highlight Folded        gui=bold guibg=#305060 guifg=#b0d0e0
highlight FoldColumn    gui=bold guibg=#305060 guifg=#b0d0e0
highlight IncSearch     gui=reverse guifg=fg guibg=bg
highlight LineNr        gui=bold guibg=grey6 guifg=LightSkyBlue3
highlight ModeMsg       guibg=DarkGreen guifg=LightGreen
highlight MoreMsg       gui=bold guifg=SeaGreen4 guibg=bg
highlight TrailingWhitespace gui=none guibg=#204050 guifg=bg
if version < 600
    " same as SpecialKey
    highlight NonText   guibg=#123A4A guifg=#3D5D6D
else
    " Bottom fill (use e.g. same as LineNr)
    highlight NonText   gui=none guibg=#103040 guifg=LightSkyBlue
endif
highlight Normal        gui=none guibg=#103040 guifg=honeydew2
highlight Question      gui=bold guifg=SeaGreen2 guibg=bg
highlight Search        gui=none guibg=LightSkyBlue3 guifg=bg
highlight SpecialKey    guibg=#103040 guifg=#324262
highlight StatusLine    gui=bold guibg=grey60 guifg=black
highlight StatusLineNC  gui=none guibg=grey60 guifg=grey10
highlight Title         gui=bold guifg=MediumOrchid1 guibg=bg
highlight Visual        gui=reverse guibg=WHITE guifg=LightSkyBlue4
highlight VisualNOS     gui=bold,underline guifg=fg guibg=bg
highlight WarningMsg    gui=bold guifg=FireBrick1 guibg=bg
highlight WildMenu      gui=bold guibg=Chartreuse guifg=Black

highlight Comment       gui=none guifg=#507080
highlight Constant      guifg=cyan3 guibg=bg
highlight String        gui=none guifg=turquoise2 guibg=bg
highlight Number        gui=none guifg=Cyan guibg=bg
highlight Boolean       gui=bold guifg=Cyan guibg=bg
highlight Identifier    guifg=LightSkyBlue3
highlight Function      gui=none guifg=DarkSeaGreen3 guibg=bg

highlight Statement     gui=none guifg=LightGreen
highlight Conditional   gui=none guifg=LightGreen guibg=bg
highlight Repeat        gui=none guifg=LightGreen guibg=bg
highlight Operator      gui=none guifg=LightGreen guibg=bg
highlight Keyword       gui=bold guifg=LightGreen guibg=bg
highlight Exception     gui=bold guifg=LightGreen guibg=bg

highlight PreProc       guifg=SkyBlue1
highlight Include       gui=none guifg=LightSteelBlue3 guibg=bg
highlight Define        gui=none guifg=LightSteelBlue2 guibg=bg
highlight Macro         gui=none guifg=LightSkyBlue3 guibg=bg
highlight PreCondit     gui=none guifg=LightSkyBlue2 guibg=bg

highlight Type          gui=none guifg=LightBlue
highlight StorageClass  gui=none guifg=LightBlue guibg=bg
highlight Structure     gui=none guifg=LightBlue guibg=bg
highlight Typedef       gui=none guifg=LightBlue guibg=bg

highlight Special       gui=bold guifg=aquamarine3
highlight Underlined    gui=underline guifg=honeydew4 guibg=bg
highlight Ignore        guifg=#204050
highlight Error         guifg=LightYellow  guibg=FireBrick
highlight Todo          guifg=Cyan guibg=#507080
if v:version >= 700
    highlight PMenu      gui=bold guibg=LightSkyBlue4 guifg=honeydew2
    highlight PMenuSel   gui=none guibg=LightSeaGreen guifg=bg
    highlight PMenuSbar  gui=bold guibg=LightSkyBlue4
    highlight PMenuThumb gui=bold guibg=DarkGreen
    highlight SpellBad   gui=undercurl guisp=Red
    highlight SpellRare  gui=undercurl guisp=Orange
    highlight SpellLocal gui=undercurl guisp=Orange
    highlight SpellCap   gui=undercurl guisp=Yellow
endif

""" Console
if v:version >= 700
    highlight PMenu      cterm=bold ctermbg=DarkGreen ctermfg=Gray
    highlight PMenuSel   cterm=bold ctermbg=Yellow ctermfg=Gray
    highlight PMenuSbar  cterm=bold ctermbg=DarkGreen
    highlight PMenuThumb cterm=bold ctermbg=Yellow
    highlight SpellBad   ctermbg=Red
    highlight SpellRare  ctermbg=Red
    highlight SpellLocal ctermbg=Red
    highlight SpellCap   ctermbg=Yellow
endif

highlight Normal        ctermfg=Gray ctermbg=none
highlight Search        ctermfg=Black ctermbg=Red cterm=none
highlight Visual        cterm=reverse
highlight Cursor        ctermfg=Black ctermbg=Green cterm=bold
highlight Special       ctermfg=Brown
highlight Comment       ctermfg=DarkGray
highlight StatusLine    ctermfg=Blue ctermbg=White
highlight Statement     ctermfg=Yellow cterm=none
highlight Type          cterm=none
highlight Macro         ctermfg=DarkRed
highlight Identifier    ctermfg=DarkYellow
highlight Structure     ctermfg=DarkGreen
highlight String        ctermfg=DarkCyan

" vim: sw=4 ts=4 et
