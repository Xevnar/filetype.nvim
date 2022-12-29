if vim.g.did_load_filetypes then
  return
end
vim.g.did_load_filetypes = 1

-- Re export specific properties
local re_export = {}
re_export.add = require('filetype.resolve').add
re_export.resolve = require('filetype.resolve').resolve

-- Create filetypedetect augroup
vim.api.nvim_create_augroup('filetypedetect', { clear = false })

-- General autocmd for filetype detection
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
	group = 'filetypedetect',
	callback = re_export.resolve,
})

-- ftdetect auto-commands should be sourced after our auto command
if vim.g.source_ftdetect and not vim.g.did_load_ftdetect then
	vim.cmd([[
		augroup filetypedetect
		runtime! ftdetect/*.vim
		runtime! ftdetect/*.lua
		augroup END
	]])
	vim.g.did_load_ftdetect = 1
end

-- If no filetype is set, then use the user's default filetype
if vim.g.default_filetype then
	vim.api.nvim_create_autocmd('BufEnter', {
		group = 'filetypedetect',
		command = [[setf ']] .. vim.g.default_filetype .. [[']],
	})
end

return re_export
