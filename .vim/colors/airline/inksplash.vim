" Each theme is contained in its own file and declares variables scoped to the
" file.  These variables represent the possible "modes" that airline can
" detect.  The mode is the return value of mode(), which gets converted to a
" readable string.  The following is a list currently supported modes: normal,
" insert, replace, visual, and inactive.
"
" Each mode can also have overrides.  These are small changes to the mode that
" don't require a completely different look.  "modified" and "paste" are two
" such supported overrides.  These are simply suffixed to the major mode,
" separated by an underscore.  For example, "normal_modified" would be normal
" mode where the current buffer is modified.
"
" The theming algorithm is a 2-pass system where the mode will draw over all
" parts of the statusline, and then the override is applied after.  This means
" it is possible to specify a subset of the theme in overrides, as it will
" simply overwrite the previous colors.  If you want simultaneous overrides,
" then they will need to change different parts of the statusline so they do
" not conflict with each other.
"
" First, let's define an empty dictionary and assign it to the "palette"
" variable. The # is a separator that maps with the directory structure. If
" you get this wrong, Vim will complain loudly.
let g:airline#themes#inksplash#palette = {}

" First let's define some arrays. The s: is just a VimL thing for scoping the
" variables to the current script. Without this, these variables would be
" declared globally. Now let's declare some colors for normal mode and add it
" to the dictionary.  The array is in the format:
" [ guifg, guibg, ctermfg, ctermbg, opts ]. See "help attr-list" for valid
" values for the "opt" value.
"let s:N1 = ['#1e1e27', '#606bcd', 17, 190]
"let s:N2 = [s:N1[0], '#828def', 255, 238]
let s:N1 = ['#1e1e27', '#ceced7', 17, 190]
let s:N2 = [s:N1[0], '#aeaeb7', 255, 238]
let s:N3 = ['#cfbfad', '#36363f', 85, 234]
let g:airline#themes#inksplash#palette.normal = airline#themes#generate_color_map(s:N1, s:N2, s:N3)

" Here we define overrides for when the buffer is modified.  This will be
" applied after g:airline#themes#inksplash#palette.normal, hence why only certain keys are
" declared.
let s:M = ['#cfbfad', '#56363f', 85, 234]
let g:airline#themes#inksplash#palette.normal_modified = airline#themes#generate_color_map(s:N1, s:N2, s:M)


let s:I1 = ['#103040', '#ffcd8b', 17, 45]
let s:I2 = [s:I1[0], '#dfad6b', 255, 27]
let s:I3 = s:N3
let g:airline#themes#inksplash#palette.insert = airline#themes#generate_color_map(s:I1, s:I2, s:I3)


let s:R1 = ['#1e1e27', '#ee6e6e', 17, 45]
let s:R2 = ['#1e1e27', '#ce4e4e', 17, 45]
let s:R3 = s:N3
let g:airline#themes#inksplash#palette.replace = airline#themes#generate_color_map(s:R1, s:R2, s:R3)
let g:airline#themes#inksplash#palette.replace_modified = airline#themes#generate_color_map(s:R1, s:R2, s:M)


let s:V1 = ['#1e1e27', '#ff8bff', 232, 214]
let s:V2 = [s:V1[0], '#df6bdf', 232, 202]
let s:V3 = s:N3
let g:airline#themes#inksplash#palette.visual = airline#themes#generate_color_map(s:V1, s:V2, s:V3)
let g:airline#themes#inksplash#palette.visual_modified = airline#themes#generate_color_map(s:V1, s:V2, s:M)


let s:IA1 = ['#1e1e27', '#6e6e77', 17, 190]
let s:IA2 = [s:N1[0], '#4e4e57', 255, 238]
let s:IA3 = ['#8f7f6d', '#36363f', 239, 236, '']
let g:airline#themes#inksplash#palette.inactive = airline#themes#generate_color_map(s:IA1, s:IA2, s:IA3)


" Accents are used to give parts within a section a slightly different look or
" color. Here we are defining a "red" accent, which is used by the 'readonly'
" part by default. Only the foreground colors are specified, so the background
" colors are automatically extracted from the underlying section colors. What
" this means is that regardless of which section the part is defined in, it
" will be red instead of the section's foreground color. You can also have
" multiple parts with accents within a section.
let g:airline#themes#inksplash#palette.accents = {'red': ['#ce4e4e', '', 160, '']}


" Here we define the color map for ctrlp.  We check for the g:loaded_ctrlp
" variable so that related functionality is loaded iff the user is using
" ctrlp. Note that this is optional, and if you do not define ctrlp colors
" they will be chosen automatically from the existing palette.
"if !get(g:, 'loaded_ctrlp', 0)
"  finish
"endif
"let g:airline#themes#inksplash#palette.ctrlp = airline#extensions#ctrlp#generate_color_map(
"      \ [ '#d7d7ff' , '#5f00af' , 189 , 55  , ''     ],
"      \ [ '#ffffff' , '#875fd7' , 231 , 98  , ''     ],
"      \ [ '#5f00af' , '#ffffff' , 55  , 231 , 'bold' ])

