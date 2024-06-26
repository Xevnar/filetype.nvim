local M = {}

--- Function to get a specific line from the current buffer current buffer. The
--- function is zero-indexed.
---
--- @param i number|nil The line index, 0 if nil
--- @return string The line contents at index i or an empty string
function M.getline(i)
	i = i or 0
	return M.getlines(i, i + 1)[1] or ''
end

--- Function to get a range of lines from the current buffer current buffer. The
--- function is zero-indexed.
---
--- @param i number|nil The start index, 0 if nil
--- @param j number|nil The end index (exclusive), buffer length if nil
--- @return table<string> Array of lines, can be empty
function M.getlines(i, j)
	i = i or 0
	j = j or -1
	return vim.api.nvim_buf_get_lines(0, i, j, false)
end

--- Function to get a range of lines from the current buffer current buffer. The
--- function is zero-indexed.
---
--- @param i number|nil The start index, 0 if nil
--- @param j number|nil The end index (exclusive), buffer length if nil
--- @param sep string|nil The line separator, empty string if nil
--- @return string String representing lines concatenated by sep
function M.getlines_as_string(i, j, sep)
	sep = sep or ''
	return table.concat(M.getlines(i, j), sep)
end

--- Get the next non-whitespace line in the buffer.
---
---@param i number|nil The line number of the first line to start from (inclusive, 0-based)
---@return string|nil The first non-blank line if found or `nil` otherwise
function M.get_next_nonblank_line(i)
	for _, line in ipairs(M.getlines(i)) do
		if not line:find('^%s*$') then
			return line
		end
	end
	return nil
end

--- Check whether a string matches any of the given Lua patterns.
--- Taken from https://github.com/neovim/neovim/blob/c6c21db82b31ea43ce878ab3725dcd901db1e7a1/runtime/lua/vim/filetype.lua#L65
---
--- @param s string? The string to check
--- @param patterns string[] A list of Lua patterns
--- @return boolean `true` if s matched a pattern, else `false`
function M.findany(s, patterns)
	if not s then
		return false
	end

	for _, v in ipairs(patterns) do
		if s:find(v) then
			return true
		end
	end

	return false
end

--- Print a deprecation warning to the user
---
---@param old string|table<string> The deprecated options
---@param replacement? string|table<string> The replacement options
function M.deprecated_option_warning(old, replacement)
	if type(old) == 'table' then
		old = '(' .. table.concat(old, ',') .. ')'
	end

	local msg = {
		{ '[filetype.nvim] ', 'Normal' },
		{ old, 'WarningMsg' },
		{ ' is deprecated.\n', 'Normal' },
	}

	if type(replacement) == 'table' then
		replacement = '(' .. table.concat(replacement, ',') .. ')'
	end

	if replacement then
		table.insert(msg, { '[filetype.nvim] Please use ', 'Normal' })
		table.insert(msg, { replacement, 'WarningMsg' })
		table.insert(msg, { ' instead.', 'Normal' })
	end

	vim.api.nvim_echo(msg, true, {})
end

--- Convert a lua pattern it case insensitive:
---     `xyz = %d+ or %% end`  => `[xX][yY][zZ] = %d+ [oO][rR] %% [eE][nN][dD]`
--- Taken from https://stackoverflow.com/questions/11401890/case-insensitive-lua-pattern-matching
---
--- @param pattern string The pattern to convert to case-insensitive
--- @return string # The case insensitive pattern
function M.to_case_insensitive(pattern)
	-- find an optional '%' (group 1) followed by any character (group 2)
	local p = pattern:gsub('(%%?)(.)', function(percent, letter)
		if percent ~= '' or not letter:match('%a') then
			-- if the '%' matched, or `letter` is not a letter, return "as is"
			return percent .. letter
		end

		-- else, return a case-insensitive character class of the matched letter
		return string.format('[%s%s]', letter:lower(), letter:upper())
	end)

	return p
end

return M
