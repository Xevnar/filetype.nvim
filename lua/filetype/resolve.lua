-- Deprecate the setup function
vim.deprecate('setup', 'add', '')

--- @module 'filetype.util'
local util = require('filetype.util')

--- The default mappings
--- @alias filetype_mapping string|fun(args: filetype_mapping_argument): string?

--- @type { [string]: filetype_map }
local mappings = require('filetype.mappings')

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

--- Generate the rest of paramaters from the file_path
---
--- @return filetype_mapping_argument # Self
function callback_args:gen_from_path()
	self.file_name = self.file_path:match('.*[\\/]([^/]*)')
	self.file_ext = self.file_name:match('.+%.([^./]+)$')
	return self
end

--- Strip extension from file path, call gen_from_path after it
---
--- @return filetype_mapping_argument # Self
function callback_args:strip_ext()
	self.file_path = self.file_path:match('(.*)%.' .. self.file_ext)
	return self
end

--- The extensions are stripped from the end of the file_path before it is processed
--- @type { [string]: boolean|string[] }
local ignored_extensions = {
	['bk'] = true,
	['in'] = {
		'cmake.in',
		'configure.in',
	},
	['bak'] = true,
	['new'] = true,
	['old'] = true,
	['orig'] = true,
	['pacnew'] = true,
	['rmpnew'] = true,
	['pacsave'] = true,
	['rpmsave'] = true,
	['dpkg-bak'] = true,
	['dpkg-new'] = true,
	['dpkg-old'] = true,
	['dpkg-dist'] = true,
}

--- This function strips all ignored_extensions from
--- @param self filetype_mapping_argument
function callback_args:strip_ignored_ext()
	while ignored_extensions[self.file_ext] do
		if type(ignored_extensions[self.file_ext]) ~= 'table' then
			goto continue
		end

		---@diagnostic disable-next-line: param-type-mismatch
		for _, file in ipairs(ignored_extensions[self.file_ext]) do
			if self.file_name == file then
				return
			end
		end

		::continue::
		self:strip_ext():gen_from_path()
	end
end

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
--- @param map filetype_map A table of literal mappings
--- @return boolean # Whether the the filetype was set or not
local function try_lookup(query, map)
	if not query or not map then
		return false
	end

	return set_filetype(map[query])
end

--- Replace an enviroment variable in a string with it's value
---
--- @param s string The string containg an enviroment variable. The variable must be enclosed by `${}` to be expanded
--- @return string # The string after expansion
--- @return boolean? # If the enviroment variable was defined or not
local function expand_env_var(s)
	local var_exists
	s = s:gsub('%${(%S-)}', function(env)
		-- If an environment variable is present in the pattern but not set, there is no match
		if not vim.env[env] then
			var_exists = false
			return nil
		end
		var_exists = true
		return vim.env[env]
	end)

	return s, var_exists
end

--- Loop through the pattern-filetype pairs in the map table and check if the absolute_path matches any of them
---
--- @param absolute_path string the path of the file
--- @param map filetype_map A table of lua pattern mappings
--- @return boolean # Whether the the filetype was set or not
local function try_pattern(absolute_path, map)
	if not map then
		return false
	end

	for pattern, ft in pairs(map) do
		if mappings.contains_env_var[pattern] then
			local var_exists
			pattern, var_exists = expand_env_var(pattern)
			if not var_exists then
				return false
			end
		end

		if absolute_path:find(pattern) then
			return set_filetype(ft)
		end
	end

	return false
end

--- Loop through the regex-filetype pairs in the map table and check if the absolute_path matches any of them
---
--- @param absolute_path string the path of the file
--- @param map filetype_map A table of vim regex mappings
--- @return boolean # Whether the the filetype was set or not
local function try_regex(absolute_path, map)
	if not map then
		return false
	end

	for pattern, ft in pairs(map) do
		if mappings.contains_env_var[pattern] then
			local var_exists
			pattern, var_exists = expand_env_var(pattern)
			if not var_exists then
				return false
			end
		end

		if util.match_vim_regex(absolute_path, pattern) then
			return set_filetype(ft)
		end
	end

	return false
end

local M = {}

--- The class defines how each filetype indicator is resolved to file type
--- @class filetype_overrides
--- @field literals filetype_map Lookup table that maps file names to filetypes
--- @field extensions filetype_map Lookup table that maps file extensions to filetypes
--- @field complex filetype_map Table of lua patterns that are tested against the full file path
--- @field vim_regex filetype_map Table of vim regexes that are tested against the full file path
--- @field filetypes { [string]: filetype_indicators, [integer]: filetype_conflict_map }
---
--- @alias filetype_map { [string]: filetype_mapping }
--- @alias filetype_indicators { extensions: string[], literals: string[], complex: string[], vim_regex: string[] }
--- @alias filetype_conflict_map { extensions: string[], literals: string[], complex: string[], vim_regex: string[], resolution: filetype_mapping }

--- This function adds the filetype indicators into the builtin tables
---
--- @param overrides filetype_overrides
function M.add(overrides)
	-- Extend the shebang_map with users map and override already existing values
	if overrides.extensions then
		for ext, ft in pairs(overrides.extensions) do
			mappings.extensions[ext] = ft
		end
	end

	if overrides.literals then
		for literal, ft in pairs(overrides.literals) do
			mappings.literals[literal] = ft
		end
	end

	-- Add the user's complex maps
	mappings:add_custom_map('custom_complex', overrides.complex)
	mappings:add_custom_map('custom_vcomplex', overrides.vim_regex)

	if overrides.filetypes then
		local function process_map(map, res)
			if map.extensions then
				for _, ext in ipairs(map.extensions) do
					mappings.extensions[ext] = res
				end
			end

			if map.literals then
				for _, literal in ipairs(map.literals) do
					mappings.literals[literal] = res
				end
			end

			mappings:add_custom_list('custom_complex', map.complex, res)
			mappings:add_custom_list('custom_vcomplex', map.vim_regex, res)
		end

		for _, map in ipairs(overrides.filetypes) do
			process_map(map, map.resolution)
		end

		for ft, map in pairs(overrides.filetypes) do
			process_map(map, ft)
		end
	end
end

--- This function adds extensions that will be stripped from the file path before attempting to resolve the filetype.
--- If the value of the extension is string list, then all files that match any of strings won't have their extensions
--- stripped.
---
--- @param extensions { [string]: boolean|string[] }
function M.add_ignored_extension(extensions)
	for ext, v in pairs(extensions) do
		ignored_extensions[ext] = v
	end
end

--- The function tries to resolve the filetype of the current buffer, either from the file name or through the file's
--- contents
--- The args passed to this function are the same as the ones passed by |nvim_create_autocommand()| to callbacks:
---
---     * id number # Autocommand id
---     * event string # Name of the triggered event |autocmd-events|
---     * group number|nil autocommand group id, if any
---     * match string # Expanded value of |<amatch>|
---     * buf number # Expanded value of |<abuf>|
---     * file string # expanded value of |<afile>|
---     * data any # Arbitrary data passed to |nvim_exec_autocmds()|

---
--- @see :help autocmd-events
--- @see :help nvim_create_autocommand()
--- @see :help nvim_exec_autocmds()
function M.resolve(args)
	-- Just in case
	vim.g.did_load_filetypes = 1

	callback_args.file_path = args.file

	if vim.bo.filetype == 'bqfpreview' then
		callback_args.file_path = args.match
	end

	-- If this an empty buffer, skip to detecting from file contents
	if #callback_args.file_path == 0 then
		goto detect_from_contents
	end

	-- Normalize filepath
	callback_args.file_path = vim.fs.normalize(callback_args.file_path)

	-- Some extensions are tacked at the end of the filename to indicate that the file is a backup
	callback_args:gen_from_path()
	callback_args:strip_ignored_ext()

	if vim.g.ft_ignore_pat == nil then
		vim.g.ft_ignore_pat = [[\.\(Z\|gz\|bz2\|zip\|tgz\)$]]
	end

	if util.match_vim_regex(callback_args.file_path, vim.g.ft_ignore_pat) then
		return -- Don't set the files filetype
	end

	if try_lookup(callback_args.file_path, mappings.literals) then
		return
	end

	if try_lookup(callback_args.file_name, mappings.literals) then
		return
	end

	if try_pattern(callback_args.file_path, mappings.custom_complex) then
		return
	end

	if try_pattern(callback_args.file_name, mappings.fcustom_complex) then
		return
	end

	if try_regex(callback_args.file_path, mappings.custom_vcomplex) then
		return
	end

	if try_regex(callback_args.file_name, mappings.fcustom_vcomplex) then
		return
	end

	if try_pattern(callback_args.file_path, mappings.endswith) then
		return
	end

	if try_pattern(callback_args.file_name, mappings.fendswith) then
		return
	end

	if try_pattern(callback_args.file_path, mappings.complex) then
		return
	end

	if try_pattern(callback_args.file_name, mappings.fcomplex) then
		return
	end

	if try_lookup(callback_args.file_ext, mappings.extensions) then
		return
	end

	-- Starsets are always lower priority
	if try_pattern(callback_args.file_path, mappings.starsets) then
		return
	end

	if try_pattern(callback_args.file_name, mappings.fstarsets) then
		return
	end

	-- At this point, no filetype has been detected so let's just default to the extension, if it has one
	if callback_args.file_ext and set_filetype(callback_args.file_ext) then
		return
	end

	-- If this is an empty buffer, or there is no filetype extention then try and detect from the file's contents
	::detect_from_contents::

	-- Detect filetype from shebang
	set_filetype(require('filetype.detect').from_content())
end

return M
