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

	local fkey = 'f' .. key
	for pat, val in pairs(map) do
		-- Check if pattern contains an env var
		if M.contains_env_var[pat] == nil then
			M.contains_env_var[pat] = pat:find('%${') ~= nil
		end

		if pat:find('/') then
			if not self[key] then
				self[key] = {}
			end

			self[key][pat] = val
		else
			if not self[fkey] then
				self[fkey] = {}
			end

			self[fkey][pat] = val
		end
	end
end
]])

print()
print([[--- @type { [string]: filetype_mapping }]])
print('M.extensions = ', inspect(extensions))
print()
print([[--- @type { [string]: filetype_mapping }]])
print('M.literals = ', inspect(literals))

print()
print([[
--- Cache table that stores if the pattern contains an en enviroment variable that must
--- be expanded
---
--- @type { [string]: boolean } A table of lua pattern mappings]])
print('M.contains_env_var =', inspect(patterns_with_env))

print()
print([[--- @type { [string]: filetype_mapping }]])
print('M.endswith = ', inspect(endswith))
print()
print([[--- @type { [string]: filetype_mapping }]])
print('M.fendswith = ', inspect(fendswith))

print()
print([[--- @type { [string]: filetype_mapping }]])
print('M.complex = ', inspect(complex))
print()
print([[--- @type { [string]: filetype_mapping }]])
print('M.fcomplex = ', inspect(fcomplex))

print()
print([[--- @type { [string]: filetype_mapping }]])
print('M.starsets = ', inspect(starsets))
print()
print([[--- @type { [string]: filetype_mapping }]])
print('M.fstarsets = ', inspect(fstarsets))

print('\nreturn M\n')
