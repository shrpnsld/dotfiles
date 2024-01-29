vim.g.signify_update_on_bufenter = 1
vim.g.signify_update_on_focusgained = 1
vim.g.signify_sign_add               = '┃'
vim.g.signify_sign_delete            = '┃'
vim.g.signify_sign_delete_first_line = '┃'
vim.g.signify_sign_change            = '┃'
vim.g.signify_sign_change_delete     = '┃'

local augroup = vim.api.nvim_create_augroup('refresh_signify', { clear = true })
vim.api.nvim_create_autocmd('TextChanged', { pattern = '*', group = augroup, callback = vim.fn['sy#start'] } )
vim.api.nvim_create_autocmd('InsertLeave', { pattern = '*', group = augroup, callback = vim.fn['sy#start'] } )

