--- @module 'filetype.util'
local util = require('filetype.util')

--- @module 'filetype.detect'
local detect = require('filetype.detect')

--- Lua implementation of the setfiletype builtin function.
--- @see :help setf
---
--- @param filetype string the filetype to set
--- @return true
local function setf(filetype)
	if vim.fn.did_filetype() == 0 then
		vim.bo.filetype = filetype
	end

	return true
end

--- Arguments to pass to function callbacks. The argements should be set when the resolve function is called
---
--- @class filetype_mapping_argument
--- @field file_path string The file's aboslute path (includes filename)
--- @field file_name string The file's name (includes extension)
--- @field file_ext string The file's extension
---
--- @type filetype_mapping_argument
local callback_args = {
	file_path = '',
	file_name = '',
	file_ext = '',
}

--- Set the buffer's filetype
---
--- @param filetype? filetype_mapping The filetype to set for the buffer it can
---                                   either be a string or a function that
---                                   returns a string
--- @return boolean # Whether the filetype was set or not
local function set_filetype(filetype)
	if type(filetype) == 'string' then
		return setf(filetype)
	end

	if type(filetype) == 'function' then
		local ft = filetype(callback_args)
		return type(ft) == 'string' and setf(ft)
	end

	return false
end

--- Look up a query in the map
---
--- @param query string The pattern to lookup in  `map`
--- @param map { [string]: filetype_mapping } A table of literal mappings
--- @return boolean # Whether the the filetype was set or not
local function try_lookup(query, map)
	if not query or not map then
		return false
	end

	return set_filetype(map[query])
end

--- Loop through the pattern-filetype pairs in the map table and check if the absolute_path matches any of them
---
--- @param absolute_path string the path of the file
--- @param map { [string]: filetype_mapping } A table of lua pattern mappings
--- @return boolean # Whether the the filetype was set or not
local function try_pattern(absolute_path, map)
	if not map then
		return false
	end

	for pattern, ft in pairs(map) do
		if absolute_path:find(pattern) then
			return set_filetype(ft)
		end
	end

	return false
end

--- Loop through the regex-filetype pairs in the map table and check if the absolute_path matches any of them
---
--- @param absolute_path string the path of the file
--- @param map { [string]: filetype_mapping } A table of vim regex mappings
--- @return boolean # Whether the the filetype was set or not
local function try_regex(absolute_path, map)
	if not map then
		return false
	end

	for pattern, ft in pairs(map) do
		if util.match_vim_regex(absolute_path, pattern) then
			return set_filetype(ft)
		end
	end

	return false
end

local M = {}

--- The default mappings
--- @alias filetype_mapping string|fun(args: filetype_mapping_argument): string?

--- @type { [string]: filetype_mapping }
local extension_map = require('filetype.mappings.extensions')

--- @type { [string]: filetype_mapping }
local literal_map = require('filetype.mappings.literal')

--- @type table<string, { [string]: filetype_mapping }>
local complex_maps = require('filetype.mappings.complex')

--- Fallback filetype
---
--- @type string
local fallback

--- Setup function
---
--- @class filetype_opts
--- @field overrides filetype_overrides Overiddes for the default filetype mappings
--- @field detection_settings filetype_detect_opts Options to override the behaviour of detection functions
--- @field source_ftdetect boolean Whether to source runtime ftdetect files or not
---
--- @class filetype_overrides
--- @field extensions { [string]: filetype_mapping } Lookup table that maps file extensions to filetypes
--- @field literal { [string]: filetype_mapping } Lookup table that maps file names to filetypes
--- @field complex { [string]: filetype_mapping } Table of lua patterns that are tested against the full file path
--- @field vim_regex { [string]: filetype_mapping } Table of vim regexes that are tested against the full file path
--- @field default_filetype string The default filetype if no filetype is detected
---
--- @param opts filetype_opts
function M.setup(opts)
	if opts.overrides then
		-- Extend the shebang_map with users map and override already existing values
		if opts.overrides.extensions then
			for ext, ft in pairs(opts.overrides.extensions) do
				extension_map[ext] = ft
			end
		end

		if opts.overrides.literal then
			for literal, ft in pairs(opts.overrides.literal) do
				literal_map[literal] = ft
			end
		end

		-- Add the user's complex maps
		complex_maps.custom_complex = opts.overrides.complex
		complex_maps.custom_vcomplex = opts.overrides.vim_regex

		fallback = opts.overrides.default_filetype

		if opts.overrides.shebang then
			util.deprecated_option_warning('overrides.shebang', 'detection_settings.shebang_map')
		end

		if opts.overrides.force_shebang_check then
			util.deprecated_option_warning('overrides.force_shebang_check')
		end

		if opts.overrides.function_extensions then
			util.deprecated_option_warning('overrides.function_extensions', 'overrides.extensions')
		end

		if opts.overrides.function_literal then
			util.deprecated_option_warning('overrides.function_literal', 'overrides.literal')
		end

		if opts.overrides.function_complex then
			util.deprecated_option_warning(
				'overrides.function_complex',
				{ 'overrides.complex', 'overrides.complex_ft_ignore' }
			)
		end
	end

	detect.setup(opts.detection_settings)

	-- Source runtime ftdetect files if the user so wishes
	if opts.source_ftdetect then
		vim.cmd([[
			augroup filetypedetect
			runtime! ftdetect/*.vim
			runtime! ftdetect/*.lua
			augroup END
		]])
	end
end

--- The function tries to resolve the filetype of the current buffer, either from the file name or through the file's
--- contents
---
function M.resolve()
	-- Just in case
	vim.g.did_load_filetypes = 1

	callback_args.file_path = vim.api.nvim_buf_get_name(0)

	if vim.bo.filetype == 'bqfpreview' then
		callback_args.file_path = vim.fn.expand('<amatch>')
	end

	-- Special exception for *.orig files. We remove the .orig extensions to get the original filename
	if callback_args.file_path:find('%.orig$') then
		callback_args.file_path = callback_args.file_path:match('(.*)%.orig')
	end

	if vim.g.ft_ignore_pat == nil then
		vim.g.ft_ignore_pat = [[\.\(Z\|gz\|bz2\|zip\|tgz\)$]]
	end

	if util.match_vim_regex(callback_args.file_path, vim.g.ft_ignore_pat) then
		return -- Don't set the files filetype
	end

	-- If this an empty buffer, skip to detecting from file contents
	if #callback_args.file_path == 0 then
		goto detect_from_contents
	end

	callback_args.file_name = callback_args.file_path:match('.*[\\/](.*)')
	callback_args.file_ext = callback_args.file_name:match('.+%.(%w+)')

	if try_lookup(callback_args.file_path, literal_map) then
		return
	end

	if try_lookup(callback_args.file_name, literal_map) then
		return
	end

	if try_lookup(callback_args.file_ext, extension_map) then
		return
	end

	if try_pattern(callback_args.file_path, complex_maps.custom_complex) then
		return
	end

	if try_regex(callback_args.file_path, complex_maps.custom_vcomplex) then
		return
	end

	if try_pattern(callback_args.file_path, complex_maps.endswith) then
		return
	end

	if try_pattern(callback_args.file_path, complex_maps.complex) then
		return
	end

	if try_pattern(callback_args.file_path, complex_maps.star_sets) then
		return
	end

	-- At this point, no filetype has been detected so let's just default to the extension, if it has one
	if callback_args.file_ext and set_filetype(callback_args.file_ext) then
		return
	end

	-- If this is an empty buffer, or there is no filetype extention then try and detect from the file's contents
	::detect_from_contents::

	-- Detect filetype from shebang
	set_filetype(detect.from_content() or fallback)
end

return M
