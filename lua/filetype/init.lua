if vim.g.did_load_filetypes then
  return
end
vim.g.did_load_filetypes = 1

-- Create filetypedetect augroup
vim.api.nvim_create_augroup('filetypedetect', { clear = false })

-- General autocmd for filetype detection
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
	group = 'filetypedetect',
	callback = require('filetype.resolve').resolve,
})
