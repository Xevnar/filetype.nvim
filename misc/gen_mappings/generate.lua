#!/usr/bin/lua
-- This script is used to generate the file mappings excluding the conflicting ones are resolved through a function
-- are manually added

local function get_script_path()
	local path = debug.getinfo(2, 'S').source
	if path then
		return path:match('@(.*)/')
	end

	if arg and arg[0] then
		return arg[0]:match('(.*)/')
	end
end

local function source_luafile(file)
	local mod, err = loadfile(file)
	if err or not mod then
		error(err or "Can't run luachunck")
	end

	return mod()
end

local script_path = get_script_path()
local inspect = source_luafile(script_path .. '/inspect.lua')
if not inspect then
	error('No inspect')
end

local filetype_dat = source_luafile(script_path .. '/filetypes.lua')
if not filetype_dat then
	error('No filetypes')
end

local function get_keys(t)
	local keys = {}
	for k, _ in pairs(t) do
		keys[#keys + 1] = k
	end

	table.sort(keys)
	return keys
end

local filetype_mappings = filetype_dat.filetypes
local filetypes = get_keys(filetype_mappings)

local extensions = {}
local literals = {}
local patterns_with_env = {}
local endswith = {}
local fendswith = {}
local complex = {}
local fcomplex = {}
local starsets = {}
local fstarsets = {}
for _, ft in ipairs(filetypes) do
	local maps = filetype_mappings[ft]

	for _, v in ipairs(maps.extensions or {}) do
		extensions[#extensions + 1] = { v, ft }
	end

	for _, v in ipairs(maps.literals or {}) do
		literals[#literals + 1] = { v, ft }
	end

	for _, v in ipairs(maps.endswith or {}) do
		if v:find('%${') then
			patterns_with_env[v] = true
		end

		if v:find('[/]') then
			endswith[#endswith + 1] = { v, ft }
		else
			fendswith[#fendswith + 1] = { v, ft }
		end
	end

	for _, v in ipairs(maps.complex or {}) do
		if v:find('%${') then
			patterns_with_env[v] = true
		end

		if v:find('[/]') then
			complex[#complex + 1] = { v, ft }
		else
			fcomplex[#fcomplex + 1] = { v, ft }
		end
	end

	for _, v in ipairs(maps.starsets or {}) do
		if v:find('%${') then
			patterns_with_env[v] = true
		end

		if v:find('[/]') then
			starsets[#starsets + 1] = { v, ft }
		else
			fstarsets[#fstarsets + 1] = { v, ft }
		end
	end
end

local function string_sorter(a, b)
	return (#a == #b and a < b) or #a < #b
end

local conflicts = filetype_dat.conflicts
for _, con in ipairs(conflicts) do
	table.sort(con.extensions or {}, string_sorter)
	for _, v in ipairs(con.extensions or {}) do
		extensions[#extensions + 1] = { v, con.resolution }
	end

	table.sort(con.literals or {}, string_sorter)
	for _, v in ipairs(con.literals or {}) do
		literals[#literals + 1] = { v, con.resolution }
	end

	table.sort(con.endswith or {}, string_sorter)
	for _, v in ipairs(con.endswith or {}) do
		if v:find('%${') then
			patterns_with_env[v] = true
		end

		if v:find('[/]') then
			endswith[#endswith + 1] = { v, con.resolution }
		else
			fendswith[#fendswith + 1] = { v, con.resolution }
		end
	end

	table.sort(con.complex or {}, string_sorter)
	for _, v in ipairs(con.complex or {}) do
		if v:find('%${') then
			patterns_with_env[v] = true
		end

		if v:find('[/]') then
			complex[#complex + 1] = { v, con.resolution }
		else
			fcomplex[#fcomplex + 1] = { v, con.resolution }
		end
	end

	table.sort(con.starsets or {}, string_sorter)
	for _, v in ipairs(con.starsets or {}) do
		if v:find('%${') then
			patterns_with_env[v] = true
		end

		if v:find('[/]') then
			starsets[#starsets + 1] = { v, con.resolution }
		else
			fstarsets[#fstarsets + 1] = { v, con.resolution }
		end
	end
end

print([[
--- @module 'filetype.util'
local util = require('filetype.util')

--- @module 'filetype.detect'
local detect = require('filetype.detect')

local M = {}

--- Arguments to pass to function callbacks. The argements should be set when the resolve function is called
---
--- @class filetype_mapping_argument
--- @field file_path string The file's aboslute path (includes filename)
--- @field file_name string The file's name (includes extension)
--- @field file_ext string The file's extension
---
--- @type filetype_mapping_argument
M.callback_args = {}

--- Create a new callback_args table
---
--- @param file string
--- @return filetype_mapping_argument # New callback_args
function M.callback_args:new(file)
	local o = { file_path = vim.fn.fnamemodify(file, ':p') }
	setmetatable(o, self)
	self.__index = self
	return o
end

--- Generate the rest of paramaters from the file_path
---
--- @return filetype_mapping_argument # Self
function M.callback_args:gen_from_path()
	self.file_name = self.file_path:match('([^/]*)$')
	self.file_ext = self.file_name:match('.+%.([^./]+)$')
	return self
end

--- Strip extension from file path, call gen_from_path after it
---
--- @return filetype_mapping_argument # Self
function M.callback_args:strip_ext()
	self.file_path = self.file_path:match('(.*)%.' .. self.file_ext)
	return self
end

--- The extensions are stripped from the end of the file_path before it is processed
---
--- @type { [string]: boolean|string[] }
M.ignored_extensions = {
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

--- This function strips all ignored_extensions from the file path
---
--- @param self filetype_mapping_argument
function M.callback_args:strip_ignored_ext()
	-- Also ignore `mv`'s numbered backup suffixes
	while self.file_ext and (M.ignored_extensions[self.file_ext] or self.file_ext:find('%~%d+%~')) do
		if type(M.ignored_extensions[self.file_ext]) ~= 'table' then
			goto continue
		end

		---@diagnostic disable-next-line: param-type-mismatch
		for _, file in ipairs(M.ignored_extensions[self.file_ext]) do
			if self.file_name == file then
				return
			end
		end

		::continue::
		self:strip_ext():gen_from_path()
	end
end

--- Add user defined map to module as two maps
---
--- @param key string The name of the new maps in the module
--- @param map { [string]: filetype_mapping } The user's filetype mappings
function M:add_custom_map(key, map)
	if not map then
		return
	end

	-- validate args
	vim.validate({ key = { key, 'string' }, map = { map, 'table' } })

	-- Create user maps if they don't exist
	if not self[key] then
		self[key] = {}
	end

	local fkey = 'f' .. key
	if not self[fkey] then
		self[fkey] = {}
	end

	for pat, val in pairs(map) do
		-- Check if pattern contains an env var
		if M.contains_env_var[pat] == nil then
			M.contains_env_var[pat] = pat:find('%${') ~= nil
		end

		if pat:find('/') then
			self[key][pat] = val
		else
			self[fkey][pat] = val
		end
	end
end

--- Add user defined list to module as two maps
---
--- @param key string The name of the new maps in the module
--- @param list string[] The user's filetype keys
--- @param res filetype_mapping The user's filetype mapping
function M:add_custom_list(key, list, res)
	if not list then
		return
	end

	-- validate args
	vim.validate({ key = { key, 'string' }, list = { list, 'table' } })

	-- Create user lists if they don't exist
	if not self[key] then
		self[key] = {}
	end

	local fkey = 'f' .. key
	if not self[fkey] then
		self[fkey] = {}
	end

	for _, pat in ipairs(list) do
		-- Check if pattern contains an env var
		if M.contains_env_var[pat] == nil then
			M.contains_env_var[pat] = pat:find('%${') ~= nil
		end

		if pat:find('/') then
			self[key][pat] = res
		else
			self[fkey][pat] = res
		end
	end
end

--- @type { [string]: filetype_mapping }
M.extensions = ]] .. inspect(extensions) .. [[


--- @type { [string]: filetype_mapping }
M.literals = ]] .. inspect(literals) .. [[


--- Cache table that stores if the pattern contains an en enviroment variable that must
--- be expanded
---
--- @type { [string]: boolean } A table of lua pattern mappings
M.contains_env_var =]] .. inspect(patterns_with_env) .. [[


--- @type { [string]: filetype_mapping }
M.endswith = ]] .. inspect(endswith) .. [[


--- @type { [string]: filetype_mapping }
M.fendswith = ]] .. inspect(fendswith) .. [[


--- @type { [string]: filetype_mapping }
M.complex = ]] .. inspect(complex) .. [[


--- @type { [string]: filetype_mapping }
M.fcomplex = ]] .. inspect(fcomplex) .. [[


--- @type { [string]: filetype_mapping }
M.starsets = ]] .. inspect(starsets) .. [[


--- @type { [string]: filetype_mapping }
M.fstarsets = ]] .. inspect(fstarsets) .. [[


return M
]])
