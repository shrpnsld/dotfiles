vim.cmd [[
syntax enable
filetype plugin on
]]

vim.opt.compatible = false
vim.opt.path:append('**')
vim.opt.wildmenu = true
vim.opt.laststatus = 2
vim.opt.showcmd = true
vim.opt.showcmdloc = 'last'

vim.opt.clipboard:prepend {'unnamed', 'unnamedplus'}

vim.opt.number = true
vim.opt.cursorline = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.wrap = true
vim.opt.scrolloff = 5
vim.opt.backspace = 'indent,eol,start'
vim.opt.showmatch = true
vim.opt.matchpairs:append('<:>')

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.ttimeoutlen = 0

vim.opt.guicursor = 'n-v-c-sm:block-blinkwait0-blinkon100-blinkoff100,i-ci-ve:ver25-blinkwait0-blinkon100-blinkoff100,r-cr-o:hor20'
vim.opt.mouse = 'a'

--
-- File manager

vim.g.netrw_banner = 0
vim.g.netrw_altv = 1
vim.g.netrw_liststyle = 3
vim.g.netrw_sort_options = 'i'
vim.g.netrw_keepdir = 1

-- preview on the right
vim.g.netrw_preview = 1
vim.g.netrw_alto = 0

--
-- Coding and building

vim.opt.makeprg='make-me'

