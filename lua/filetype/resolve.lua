-- Deprecate the setup function
vim.deprecate('setup', 'add', '')

--- @module 'filetype.util'
local util = require('filetype.util')

--- The default mappings
--- @alias filetype_mapping string|fun(args: filetype_mapping_argument): string?

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

--- Set the buffer's filetype
---
--- @param filetype? filetype_mapping The filetype to set for the buffer it can
---                                   either be a string or a function that
---                                   returns a string
--- @param callback_args filetype_mapping_argument
--- @return boolean # Whether the filetype was set or not
local function set_filetype(filetype, callback_args)
	if type(filetype) == 'string' then
		return setf(filetype)
	end

	if type(filetype) == 'function' then
		local ft = filetype(callback_args)
		return type(ft) == 'string' and setf(ft)
	end

	return false
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
--- @param callback_args filetype_mapping_argument
--- @param map_name string The name of the map in `filetype.mappings`
--- @return boolean # Whether the the filetype was set or not
local function try_pattern(callback_args, map_name)
	-- If mappings[map_name] doesn't exsit then mappings['f' .. map_name] also doesn't exist
	if not mappings[map_name] then
		return false
	end

	-- Test against path
	for pattern, ft in pairs(mappings[map_name]) do
		if mappings.contains_env_var[pattern] then
			local var_exists
			pattern, var_exists = expand_env_var(pattern)
			if not var_exists then
				return false
			end
		end

		if callback_args.file_path:find(pattern) then
			return set_filetype(ft, callback_args)
		end
	end

	-- Test against file
	for pattern, ft in pairs(mappings['f' .. map_name]) do
		if mappings.contains_env_var[pattern] then
			local var_exists
			pattern, var_exists = expand_env_var(pattern)
			if not var_exists then
				return false
			end
		end

		if callback_args.file_name:find(pattern) then
			return set_filetype(ft, callback_args)
		end
	end

	return false
end

--- Loop through the regex-filetype pairs in the map table and check if the absolute_path matches any of them
---
--- @param callback_args filetype_mapping_argument
--- @param map_name string The name of the map in `filetype.mappings`
--- @return boolean # Whether the the filetype was set or not
local function try_regex(callback_args, map_name)
	-- If mappings[map_name] doesn't exsit then mappings['f' .. map_name] also doesn't exist
	if not mappings[map_name] then
		return false
	end

	-- Test against path
	for pattern, ft in pairs(mappings[map_name]) do
		if mappings.contains_env_var[pattern] then
			local var_exists
			pattern, var_exists = expand_env_var(pattern)
			if not var_exists then
				return false
			end
		end

		if util.match_vim_regex(callback_args.file_path, pattern) then
			return set_filetype(ft, callback_args)
		end
	end

	-- Test against file
	for pattern, ft in pairs(mappings['f' .. map_name]) do
		if mappings.contains_env_var[pattern] then
			local var_exists
			pattern, var_exists = expand_env_var(pattern)
			if not var_exists then
				return false
			end
		end

		if util.match_vim_regex(callback_args.file_name, pattern) then
			return set_filetype(ft, callback_args)
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
		mappings.ignored_extensions[ext] = v
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

	local callback_args = mappings.callback_args:new(args.file)
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

	if set_filetype(mappings.literals[callback_args.file_path], callback_args) then
		return
	end

	if set_filetype(mappings.literals[callback_args.file_name], callback_args) then
		return
	end

	if try_pattern(callback_args, 'custom_complex') then
		return
	end

	if try_regex(callback_args, 'custom_vcomplex') then
		return
	end

	if try_pattern(callback_args, 'endswith') then
		return
	end

	if try_pattern(callback_args, 'complex') then
		return
	end

	if set_filetype(mappings.extensions[callback_args.file_ext], callback_args) then
		return
	end

	-- Starsets are always lower priority
	if try_pattern(callback_args, 'starsets') then
		return
	end

	-- At this point, no filetype has been detected so let's just default to the extension, if it has one
	if callback_args.file_ext and set_filetype(callback_args.file_ext, callback_args) then
		return
	end

	-- If this is an empty buffer, or there is no filetype extention then try and detect from the file's contents
	::detect_from_contents::

	-- Detect filetype from shebang
	set_filetype(require('filetype.detect').from_content(), callback_args)
end

return M
