vim.g.did_load_filetypes = 1

-- Create filetypedetect augroup
vim.api.nvim_create_augroup('filetypedetect', { clear = false })

-- General autocmd for filetype detection
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
	group = 'filetypedetect',
	callback = require('filetype').resolve,
})


-- Initialize global logger for the files in 'lua/'
logger = require("vlog").new {
	plugin = 'filetype.nvim',

	-- Should print the output to neovim while running
	use_console = true,

	-- Should highlighting be used in console (using echohl)
	highlights = true,

	-- Should write to a file
	use_file = true,

	-- Any messages above this level will be logged.
	level = 'debug',

	-- Level configuration
	modes = {
		{ name = 'trace', hl = 'Comment', },
		{ name = 'debug', hl = 'Comment', },
		{ name = 'info',  hl = 'None', },
		{ name = 'warn',  hl = 'WarningMsg', },
		{ name = 'error', hl = 'ErrorMsg', },
		{ name = 'fatal', hl = 'ErrorMsg', },
	},

	-- Can limit the number of decimals displayed for floats
	float_precision = 0.01,
}
