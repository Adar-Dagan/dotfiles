vim.keymap.set('n', '<leader>tn', function() vim.fn['jukit#convert#notebook_convert']("jupyter-notebook") end)
vim.keymap.set('n', '<leader>so', function() vim.fn['jukit#splits#output']() end)

vim.keymap.set('n', '<leader>rl', function() vim.fn['jukit#send#line']() end)
vim.keymap.set('v', '<leader>r', function() vim.fn['jukit#send#selection']() end)
vim.keymap.set('n', '<leader>rc', function() vim.fn['jukit#send#section'](0) end)
vim.keymap.set('n', '<leader>ra', function() vim.fn['jukit#send#all']() end)
vim.keymap.set('n', '<leader>ruc', function() vim.fn['jukit#send#until_current_section']() end)

vim.keymap.set('n', '<leader>cn', function() vim.fn['jukit#cells#jump_to_next_cell']() end)
vim.keymap.set('n', '<leader>cp', function() vim.fn['jukit#cells#jump_to_previous_cell']() end)
