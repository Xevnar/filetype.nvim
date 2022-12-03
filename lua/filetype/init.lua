local util = require("filetype.util")
local detect = require("filetype.detect")

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

-- Arguments to pass to function callbacks.
-- The argements should be set when the resolve function is called
local callback_args = {
    file_path = "",
    file_name = "",
    file_ext = "",
}

--- Set the buffer's filetype
---
--- @param filetype? string|function The filetype to set for the buffer it can
---                                  either be a string or a function that
---                                  returns a string
--- @return boolean Whether the filetype was set or not
local function set_filetype(filetype)
    if type(filetype) == "string" then
        return setf(filetype)
    end

    if type(filetype) == "function" then
        local ft = filetype(callback_args)
        return type(ft) == "string" and setf(ft)
    end

    return false
end

--- Look up a query in the map
---
--- @param query string The pattern to lookup in  `map`
--- @param map table A table of mappings
--- @return boolean Whether the the filetype was set or not
local function try_lookup(query, map)
    if not query or not map then
        return false
    end

    return set_filetype(map[query])
end

--- Loop through the pattern-filetype pairs in the map table and check if the
--- absolute_path matches any of them
---
--- @param absolute_path string the path of the file
--- @param map table A table of mappings
--- @return boolean Whether the the filetype was set or not
local function try_pattern(absolute_path, map)
    for pattern, ft in pairs(map) do
        if absolute_path:find(pattern) then
            return set_filetype(ft)
        end
    end

    return false
end

--- Loop through the regex-filetype pairs in the map table and check if the
--- absolute_path matches any of them
---
--- @param absolute_path string the path of the file
--- @param map table A table of mappings
--- @return boolean Whether the the filetype was set or not
local function try_regex(absolute_path, map)
    for pattern, ft in pairs(map) do
        if util.match_vim_regex(absolute_path, pattern) then
            return set_filetype(ft)
        end
    end

    return false
end

local M = {}

local overrides = nil

function M.setup(opts)
    if opts.overrides then
        overrides = opts.overrides
    end

    detect.setup(opts.detection_settings)
end

function M.resolve()
    -- Just in case
    vim.g.did_load_filetypes = 1

    callback_args.file_path = vim.api.nvim_buf_get_name(0)

    -- Special exception for *.orig files. We remove the .orig extensions to get the
    -- original filename
    if callback_args.file_path:find("%.orig$") then
        callback_args.file_path = callback_args.file_path:match("(.*)%.orig")
    end

    if vim.g.ft_ignore_pat == nil then
        vim.g.ft_ignore_pat = [[\.\(Z\|gz\|bz2\|zip\|tgz\)$]]
    end

    if util.match_vim_regex(callback_args.file_path, vim.g.ft_ignore_pat) then
        return -- Don't set the files filetype
    end

    if vim.bo.filetype == "bqfpreview" then
        callback_args.file_path = vim.fn.expand("<amatch>")
    end

    if #callback_args.file_path == 0 then
        return
    end

    callback_args.file_name = callback_args.file_path:match(".*[\\/](.*)")
    callback_args.file_ext = callback_args.file_name:match(".+%.(%w+)")

    -- The default mappings
    local extension_map = require("filetype.mappings.extensions")
    local literal_map = require("filetype.mappings.literal")
    local complex_maps = require("filetype.mappings.complex")

    -- Fallback filetype
    local fallback

    -- Try to match the custom defined filetypes
    if overrides then
        -- Extend the shebang_map with users map and override already existing
        -- values
        for ext, ft in pairs(overrides.extensions or {}) do
            extension_map[ext] = ft
        end

        for literal, ft in pairs(overrides.literal or {}) do
            literal_map[literal] = ft
        end

        -- Add the user's complex maps
        complex_maps.custom_complex = overrides.complex
        complex_maps.custom_vcomplex = overrides.vim_regex

        fallback = overrides.default_filetype

        if overrides.shebang then
            util.deprecated_option_warning(
                "overrides.shebang",
                "detection_settings.shebang_map"
            )
        end

        if overrides.force_shebang_check then
            util.deprecated_option_warning("overrides.force_shebang_check")
        end

        if overrides.function_extensions then
            util.deprecated_option_warning(
                "overrides.function_extensions",
                "overrides.extensions"
            )
        end

        if overrides.function_literal then
            util.deprecated_option_warning(
                "overrides.function_literal",
                "overrides.literal"
            )
        end

        if overrides.function_complex then
            util.deprecated_option_warning(
                "overrides.function_complex",
                { "overrides.complex", "overrides.complex_ft_ignore" }
            )
        end
    end

    if try_lookup(callback_args.file_ext, extension_map) then
        return
    end

    if try_lookup(callback_args.file_name, literal_map) then
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

    -- At this point, no filetype has been detected
    -- so let's just default to the extension, if it has one
    if callback_args.file_ext and set_filetype(callback_args.file_ext) then
        return
    end

    -- If there is no extension, look for a shebang and set the filetype to
    -- that. Look for a shebang override in custom_map first. If there is none,
    -- check the default shebangs defined in function_maps. Otherwise, default
    -- to setting the filetype to the value of shebang itself.
    set_filetype(detect.sh(fallback, true))
end

return M
