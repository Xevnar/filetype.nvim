local detect = require("filetype.detect")

-- generate the filetype
local custom_map = nil

--- Lua implementation of the setfiletype builtin function.
--- See :help setf
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

--- @param filetype string|function The filetype to set for the buffer it can
---                                 either be a string or a function that
---                                 returns a string
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

if vim.g.ft_ignore_pat == nil then
    vim.g.ft_ignore_pat = [[\.\(Z\|gz\|bz2\|zip\|tgz\)$]]
end
local ft_ignore_regex = vim.regex(vim.g.ft_ignore_pat)

local function star_set_filetype(name)
    if not ft_ignore_regex:match_str(name) then
        return set_filetype(name)
    end

    return false
end

--- Loop through the regex-filetype pairs in the map table and check if
--- absolute_path matches any of them
---
--- @param absolute_path string the path of the file
--- @param map table A table of mappings
--- @param star_set? boolean Whether to resepct `g:ft_ignore_pat`
--- @return boolean Whether the the filetype was set or not
local function try_pattern(absolute_path, map, star_set)
    if not map then
        return false
    end

    for pattern, ft in pairs(map) do
        if absolute_path:find(pattern) then
            if star_set then
                return star_set_filetype(ft)
            end

            return set_filetype(ft)
        end
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

local M = {}

function M.setup(opts)
    if opts.overrides then
        custom_map = opts.overrides
    end
end

function M.resolve()
    -- Just in case
    vim.g.did_load_filetypes = 1

    callback_args.file_path = vim.api.nvim_buf_get_name(0)

    if vim.bo.filetype == "bqfpreview" then
        callback_args.file_path = vim.fn.expand("<amatch>")
    end

    if #callback_args.file_path == 0 then
        return
    end

    callback_args.file_name = callback_args.file_path:match(".*[\\/](.*)")
    callback_args.file_ext = callback_args.file_name:match(".+%.(%w+)")

    -- Used at the end if no filetype is detected or an extension isn't available
    local detect_sh_args

    -- The default mappings
    local extension_map = require("filetype.mappings.extensions")
    local literal_map = require("filetype.mappings.literal")
    local complex_maps = require("filetype.mappings.complex")

    -- Try to match the custom defined filetypes
    if custom_map then
        -- Extend the shebang_map with users map and override already existing
        -- values
        for ext, ft in pairs(custom_map.extensions) do
            extension_map[ext] = ft
        end

        for literal, ft in pairs(custom_map.literal) do
            literal_map[literal] = ft
        end

        -- Add the user's complex maps
        complex_maps.custom_complex = custom_map.complex
        complex_maps.custom_starset = custom_map.complex_ft_ignore

        -- Extend the shebang_map with users map and override already existing
        -- values
        for binary, ft in pairs(custom_map.shebang) do
            detect.shebang[binary] = ft
        end

        detect_sh_args.fallback = custom_map.default_filetype
        detect_sh_args.force_shebang_check = custom_map.force_shebang_check
        detect_sh_args.check_contents = custom_map.check_sh_contents

        if custom_map.function_extensions then
            vim.api.nvim_echo({
                { "[filetype.nvim] ", "Normal" },
                { "overrides.function_extensions", "WarningMsg" },
                { " is deprecated.\n", "Normal" },
                { "[filetype.nvim] Please use ", "Normal" },
                { "overrides.extensions", "WarningMsg" },
                { " instead.", "Normal" },
            }, true, {})
        end

        if custom_map.function_literal then
            vim.api.nvim_echo({
                { "[filetype.nvim] ", "Normal" },
                { "overrides.function_literal", "WarningMsg" },
                { " is deprecated.\n", "Normal" },
                { "[filetype.nvim] Please use ", "Normal" },
                { "overrides.literal", "WarningMsg" },
                { " instead.", "Normal" },
            }, true, {})
        end

        if custom_map.function_complex then
            vim.api.nvim_echo({
                { "[filetype.nvim] ", "Normal" },
                { "overrides.function_complex", "WarningMsg" },
                { " is deprecated.\n", "Normal" },
                { "[filetype.nvim] Please use either of (", "Normal" },
                {
                    "overrides.complex, overrides.complex_ft_ignore",
                    "WarningMsg",
                },
                { ") instead.", "Normal" },
            }, true, {})
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

    if try_pattern(callback_args.file_path, complex_maps.custom_starset, true) then
        return
    end

    if try_pattern(callback_args.file_path, complex_maps.endswith) then
        return
    end

    if try_pattern(callback_args.file_path, complex_maps.complex) then
        return
    end

    if try_pattern(callback_args.file_path, complex_maps.star_sets, true) then
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
    set_filetype(detect.sh(detect_sh_args))
end

return M
