--- @module 'filetype.util'
local util = require('filetype.util')

--- @alias filetype_detect_module table
local M = {}

--- Maximum number of lines to check before giving up
---
--- @type number
M.line_limit = 10

--- Builder style function to set the line limit before calling a detect function
---
--- @param limit number The new line limit
--- @return filetype_detect_module
function M.set_line_limit(limit)
	M.line_limit = limit
	return M
end

--- Setup the module
---
--- @class filetype_detect_opts
--- @field line_check_limit number
--- @field sh_check_contents boolean
--- @field shebang_map { [string]: string|shebang_map_table }
---
--- @param opts? filetype_detect_opts
--- @return filetype_detect_module
function M.setup(opts)
	if not opts then
		return M
	end

	M.line_limit = opts.line_check_limit

	-- Extend the shebang_map with users map and override already existing
	-- values
	for binary, ft in pairs(opts.shebang_map) do
		M.shebang_map[binary] = ft
	end

	M.sh_check_contents = opts.sh_check_contents

	return M
end

--- A map from executable name to filetype
---
--- @class shebang_map_table
--- @field filetype string The filetype matched to the binary name, If it's missing the binary is used as the filetype
--- @field on_detect fun() Function that is executed if the binary is detected
---
--- @type { [string]: string|shebang_map_table }
M.shebang_map = {
	['node'] = 'javascript',
	['tclsh'] = 'tcl',
	['ksh'] = {
		on_detect = function()
			vim.b.is_kornshell = 1
			vim.b.is_bash = nil
			vim.b.is_dash = nil
			vim.b.is_sh = nil
		end,
	},
	['bash'] = {
		on_detect = function()
			vim.b.is_bash = 1
			vim.b.is_kornshell = nil
			vim.b.is_dash = nil
			vim.b.is_sh = nil
		end,
	},
	['dash'] = {
		on_detect = function()
			vim.b.is_dash = 1
			vim.b.is_kornshell = nil
			vim.b.is_bash = nil
			vim.b.is_sh = nil
		end,
	},
	['sh'] = {
		on_detect = function()
			vim.b.is_sh = 1
			vim.b.is_kornshell = vim.g.is_kornshell
			vim.b.is_bash = vim.g.is_bash or vim.g.bash_is_sh
			vim.b.is_dash = vim.g.is_dash
		end,
	},
}

--- Don't check the content after the shebang of shell files
---
--- @type boolean
M.sh_check_contents = false

--- Checks the first line in the buffer for a shebang; if there is one, set the filetype appropriately.
--- Taken from vim.filetype.detect
---
--- @param fallback? string The filetype that is returned if no filetype is detected. This disables shebang checking.
--- @param force_shebang_check? boolean Forces checking the shebang line even if a fallback filetype is defined
--- @return string? # The detected filetype
function M.sh(fallback, force_shebang_check)
	if vim.fn.did_filetype() ~= 0 then
		-- Filetype was already detected or detection should be skipped
		return
	end

	-- Analyze the first line if there is no file type
	if not fallback or force_shebang_check then
		fallback = M.analyze_shebang(util.getline()) or fallback
	end

	-- Check the contents of the file if it overrides the shebang or the
	-- passed name
	fallback = (M.check_contents and M.shell(fallback, util.getlines())) or fallback

	-- prioritize the passed shebang over the builtin map. use the passed name
	-- if it isn't defined in either
	local ft = (M.shebang_map and M.shebang_map[fallback]) or fallback
	if type(ft) == 'table' then
		ft.on_detect()
		ft = ft.filetype or fallback
	end

	return ft
end

--- Function to extract the binary name from from the shebang
---
--- @param shebang string The shebang to analyze
--- @return string? # The extracted binary name
function M.analyze_shebang(shebang)
	if not shebang or type(shebang) ~= 'string' then
		return -- Not a string, so don't bother
	end

	-- The regex requires that all binaries end in an alpha character, so that the same shell with different version
	-- numbers as suffix are treated the same
	-- (python3 => python | zsh-5.9 => zsh | test-b#in_sh2 => test-b#in_sh )
	return shebang:match('#!.*/env%s+([^/%s]*%a)') or shebang:match('#!.*/([^/%s]*%a)')
end

--- For shell-like file types, check for an "exec" command hidden in a comment, as used for Tcl.
--- Taken from vim.filetype.detect
---
--- @param name string|nil The filetype returned if the contents don't hint to a different filetype
--- @param contents table An array of the lines in the buffer
--- @return string? # The detected filetype
function M.shell(name, contents)
	if vim.fn.did_filetype() ~= 0 then
		-- Filetype was already detected or detection should be skipped
		return
	end

	local prev_line = ''
	for _, line in ipairs(contents) do
		line = line:lower()
		if line:find('%s*exec%s') and not prev_line:find('^%s*#.*\\$') then
			-- Found an "exec" line after a comment with continuation
			if util.match_vim_regex(line, [[\c\<tclsh\|\<wish]]) then
				return 'tclsh'
			end
		end
		prev_line = line
	end

	return name
end

--- The function tries to determine which csh varient is this filetype. The function still checks if shebang matches or not
--- Taken from vim.filetype.detect
---
--- @return string? # The detected filetype
function M.csh()
	if vim.fn.did_filetype() ~= 0 then
		-- Filetype was already detected
		return
	end

	local fallback
	if vim.g.filetype_csh then
		fallback = vim.g.filetype_csh
	end

	if string.find(vim.o.shell, 'tcsh') then
		fallback = 'tcsh'
	else
		fallback = 'csh'
	end

	return M.sh(fallback, true)
end

--- This function checks for the kind of assembly that is wanted by the user, or can be detected from the first five
--- lines of the file.
--- Taken from vim.filetype.detect
---
--- @return string # The detected filetype
function M.asm()
	local syntax = vim.b.asmsyntax
	if not syntax or syntax == '' then
		syntax = M.asm_syntax()
	end

	vim.b.asmsyntax = syntax
	return syntax
end

--- Checks the first 5 lines for a asmsyntax=foo override.
--- Only whitespace characters can be present immediately before or after this statement.
--- Taken from vim.filetype.detect
---
--- @return string # The detected filetype or g:asmsyntax or "asm"
function M.asm_syntax()
	local lines = ' ' .. util.getlines_as_string(0, M.line_limit, ' '):lower() .. ' '
	local match = lines:match('%sasmsyntax=([a-zA-Z0-9]+)%s')
	if match then
		return match
	end

	if util.findany(lines, { '%.title', '%.ident', '%.macro', '%.subtitle', '%.library' }) then
		return 'vmasm'
	end

	-- Defaults to g:asmsyntax or GNU
	return (vim.g.asmsyntax ~= 0 and vim.g.asmsyntax) or 'asm'
end

--- This function checks for user define g:filetype_euphoria and returns euphoira3 if it isn't set
--- Taken from vim.filetype.detect
---
--- @return string # The detected filetype
function M.euphoria_check()
	if vim.g.filetype_euphoria then
		return vim.g.filetype_euphoria
	end

	return 'euphoria3'
end

--- This function checks for user define g:filetype_euphoria and checks the contents for specman hints if it isn't set
--- Taken from vim.filetype.detect
---
--- @return string # The detected filetype
function M.eiffel_check()
	if vim.g.filetype_euphoria then
		return vim.g.filetype_euphoria
	end

	for _, line in ipairs(util.getlines(0, M.line_limit)) do
		if util.findany(line, { "^%s*<'%s*$", "^%s*'>%s*$" }) then
			return 'specman'
		end
	end

	return 'eiffel'
end

--- This function checks for user define g:filetype_euphoria and checks the contents for euphoria3 hints if it isn't set
--- Taken from vim.filetype.detect
---
--- @return string # The detected filetype
function M.elixir_check()
	if vim.g.filetype_euphoria then
		return vim.g.filetype_euphoria
	end

	for _, line in ipairs(util.getlines(0, M.line_limit)) do
		if util.match_vim_regex(line, [[\c^--\|^ifdef\>\|^include\>]]) then
			return 'euphoria3'
		end
	end

	return 'elixir'
end

--- This function checks if one of the first five lines start with a dot. In that case it is probably an nroff file.
--- Taken from vim.filetype.detect
---
--- @return string? # The detected filetype
function M.nroff()
	for _, line in ipairs(util.getlines(0, M.line_limit)) do
		if line:find('^%.') then
			return 'nroff'
		end
	end
end

--- If the file has an extension of 't' and is in a directory 't' or 'xt' then it is almost certainly a Perl test file.
--- If the first line starts with '#' and contains 'perl' it's probably a Perl file.
--- If a file contains a 'use' statement then it is almost certainly a Perl file.
--- Taken from vim.filetype.detect
---
--- @param file_path string|nil The absolute path to the file
--- @param file_ext string|nil The file extension
--- @return string? # The detected filetype
function M.perl(file_path, file_ext)
	local dir_name = vim.fs.dirname(file_path)
	if file_ext == 't' and (dir_name == 't' or dir_name == 'xt') then
		return 'perl'
	end

	local first_line = util.getline()
	if first_line:find('^#') and first_line:lower():find('perl') then
		return M.sh('perl')
	end

	for _, line in ipairs(util.getlines(0, M.line_limit)) do
		if util.match_vim_regex(line, [[\c^use\s\s*\k]]) then
			return 'perl'
		end
	end
end

local visual_basic_markers = {
	'vb_name',
	'begin vb%.form',
	'begin vb%.mdiform',
	'begin vb%.usercontrol',
}

--- Check the file contents for hints between freebasic, qb64 and vbasic
--- Taken from vim.filetype.detect
---
--- @return string # The detected filetype
function M.vbasic()
	if vim.g.filetype_bas then
		return vim.g.filetype_bas
	end

	-- Most frequent FreeBASIC-specific keywords in distro files
	local fb_keywords =
		[[\c^\s*\%(extern\|var\|enum\|private\|scope\|union\|byref\|operator\|constructor\|delete\|namespace\|public\|property\|with\|destructor\|using\)\>\%(\s*[:=(]\)\@!]]
	local fb_preproc =
		[[\c^\s*\%(#\s*\a\+\|option\s\+\%(byval\|dynamic\|escape\|\%(no\)\=gosub\|nokeyword\|private\|static\)\>\|\%(''\|rem\)\s*\$lang\>\|def\%(byte\|longint\|short\|ubyte\|uint\|ulongint\|ushort\)\>\)]]

	local fb_comment = "^%s*/'"
	-- OPTION EXPLICIT, without the leading underscore, is common to many dialects
	local qb64_preproc = [[\c^\s*\%($\a\+\|option\s\+\%(_explicit\|_\=explicitarray\)\>\)]]

	for _, line in ipairs(util.getlines(0, M.line_limit)) do
		if util.findany(line:lower(), visual_basic_markers) then
			return 'vb'
		end

		if
			line:find(fb_comment)
			or util.match_vim_regex(line, fb_preproc)
			or util.match_vim_regex(line, fb_keywords)
		then
			return 'freebasic'
		end

		if util.match_vim_regex(line, qb64_preproc) then
			return 'qb64'
		end
	end
	return 'basic'
end

--- Read the file contents to check for visual basic hints
--- Taken from vim.filetype.detect
---
--- @return string # The detected filetype
function M.vbasic_form()
	if vim.g.filetype_frm then
		return vim.g.filetype_frm
	end

	local lines = table.concat(util.getlines(0, M.line_limit)):lower()
	if util.findany(lines, visual_basic_markers) then
		return 'vb'
	end

	return 'form'
end

--- Read the file contens for hints on the html flavour
--- Taken from vim.filetype.detect
---
--- @return string # The detected filetype
function M.html()
	for _, line in ipairs(util.getlines(0, M.line_limit)) do
		if util.match_vim_regex(line, [[\<DTD\s\+XHTML\s]]) then
			return 'xhtml'
		end

		if util.match_vim_regex(line, [[\c{%\s*\(extends\|block\|load\)\>\|{#\s\+]]) then
			return 'htmldjango'
		end
	end

	return 'html'
end

--- Checks if the line is a doc book or not
---
--- @return string? # The docbook filetype
local function is_docbook(line, type)
	local is_docbook4 = line:find('%<%!DOCTYPE.*DocBook')
	local is_docbook5 = line:lower():find([[xmlns="http://docbook.org/ns/docbook"]])
	if is_docbook4 or is_docbook5 then
		vim.b.docbk_type = type
		vim.b.docbk_ver = is_docbook4 and 4 or 5
		return 'docbk'
	end
end

--- Read the file contens for hints on the sgml flavour
--- Taken from vim.filetype.detect
---
--- @return string # The detected filetype
function M.sgml()
	for _, line in ipairs(util.getlines(0, M.line_limit)) do
		if line:find('linuxdoc') then
			return 'sgmlnx'
		end

		local ft = is_docbook(line, 'sgml')
		if ft then
			return ft
		end
	end

	return 'sgml'
end

--- Read the file contens for hints on the xml flavour
--- Taken from vim.filetype.detect
---
--- @return string # The detected filetype
function M.xml()
	for _, line in ipairs(util.getlines(0, M.line_limit)) do
		local ft = is_docbook(line, 'sgml')
		if ft then
			return ft
		end

		if line:find([[xmlns:xbl="http://www.mozilla.org/xbl"]]) then
			return 'xbl'
		end
	end

	return 'xml'
end

--- Choose context, plaintex, or tex (LaTeX) based on these rules:
---     1. Check the first line of the file for "%&<format>".
---     2. Check the first 1000 non-comment lines for LaTeX or ConTeXt keywords.
---     3. Default to "plain" or to g:tex_flavor, can be set in user's vimrc.
--- Taken from vim.filetype.detect
---
--- @param file_path string The absolute path of the file
--- @return string # The detected filetype
function M.tex(file_path)
	local format = util.getline():find('^%%&%s*(%a+)')
	if format then
		format = format:lower():gsub('pdf', '', 1)
		if format == 'tex' then
			return 'tex'
		end

		if format == 'plaintex' then
			return 'plaintex'
		end
	end

	-- Early guarantee that the fileytpe is context
	if file_path:lower():find('tex/context/.*/.*%.tex') then
		return 'context'
	end

	local latex_pat = [[documentclass\>\|usepackage\>\|begin{\|newcommand\>\|renewcommand\>]]
	local context_pat =
		[[start\a\+\|setup\a\+\|usemodule\|enablemode\|enableregime\|setvariables\|useencoding\|usesymbols\|stelle\a\+\|verwende\a\+\|stel\a\+\|gebruik\a\+\|usa\a\+\|imposta\a\+\|regle\a\+\|utilisemodule\>]]
	for i, l in ipairs(util.getlines(0, M.line_limit)) do
		-- Skip comments
		if l:find('^%s*%%%S') then
			goto continue
		end

		-- Check the next thousand lines for a LaTeX or ConTeXt keyword.
		for _, line in ipairs(util.getlines(i, i + 1000)) do
			local lpat_match, cpat_match =
				util.match_vim_regex(line, [[\c^\s*\\\%(]] .. latex_pat .. [[\)\|^\s*\\\(]] .. context_pat .. [[\)]])

			if lpat_match then
				return 'tex'
			end
			if cpat_match then
				return 'context'
			end
		end

		::continue::
	end

	-- TODO: add AMSTeX, RevTex, others?
	if not vim.g.tex_flavor or vim.g.tex_flavor == 'plain' then
		return 'plaintex'
	end

	if vim.g.tex_flavor == 'context' then
		return 'context'
	end

	-- Probably LaTeX
	return 'tex'
end

--- Detect the flavor of R that is used.
--- Taken from vim.filetype.detect
---
--- @return string # The detected filetype
function M.r()
	local lines = util.getlines(0, M.line_limit)
	-- Rebol is easy to recognize, check for that first
	if util.match_vim_regex(table.concat(lines), [[\c\<rebol\>]]) then
		return 'rebol'
	end

	-- Check for comment style
	for _, line in ipairs(lines) do
		-- R has # comments
		if line:find('^%s*#') then
			return 'r'
		end

		-- Rexx has /* comments */
		if line:find('^%s*/%*') then
			return 'rexx'
		end
	end

	-- Nothing recognized, use user default or assume R
	if vim.g.filetype_r then
		return vim.g.filetype_r
	end

	-- Rexx used to be the default, but R appears to be much more popular.
	return 'r'
end

--- Distinguish between Prolog and Cproto prototype file.
--- Taken from vim.filetype.detect
---
--- @return string? nil # The filetype detected
function M.proto()
	-- Cproto files have a comment in the first line and a function prototype in the second line, it always ends in ";".
	-- Indent files may also have comments, thus we can't match comments to see the difference.
	-- IDL files can have a single ';' in the second line, require at least one character before the ';'.
	if util.getlines_as_string(0, 2, ' '):find('.;$') then
		return 'cpp'
	end

	-- Recognize Prolog by specific text in the first non-empty line; require a blank after the '%' because Perl uses "%list"
	-- and "%translate"
	local line = util.get_next_nonblank_line()
	if
		line:find(':%-')
		or util.match_vim_regex(line, [[\c\<prolog\>]])
		or util.findany(line, { '^%s*%%+%s', '^%s*%%+$', '^%s*/%*' })
	then
		return 'prolog'
	end
end

--- Distinguish between dtrace and d files
--- Taken from vim.filetype.detect
---
--- @return string? # The filetype detected
function M.dtrace()
	if vim.fn.did_filetype() ~= 0 then
		-- Filetype was already detected
		return
	end

	for _, line in ipairs(util.getlines(0, M.line_limit)) do
		if util.match_vim_regex(line, [[\c^module\>\|^import\>]]) then
			-- D files often start with a module and/or import statement.
			return 'd'
		end

		if util.findany(line, { '^#!%S+dtrace', '#pragma%s+D%s+option', ':%S-:%S-:' }) then
			return 'dtrace'
		end
	end

	return 'd'
end

--- Check for lpc syntax if the user specifies g:lpc_syntax_for_c
--- Taken from vim.filetype.detect
---
--- @return string # The filetype detected
function M.lpc()
	if not vim.g.lpc_syntax_for_c then
		return 'c'
	end

	for _, line in ipairs(util.getlines(0, M.line_limit)) do
		if
			util.findany(line, {
				'^//',
				'^inherit',
				'^private',
				'^protected',
				'^nosave',
				'^string',
				'^object',
				'^mapping',
				'^mixed',
			})
		then
			return 'lpc'
		end
	end

	return 'c'
end

--- Distinguish between different header files
--- Taken from vim.filetype.detect
---
--- @return string # The filetype detected
function M.header()
	-- Check the file contents for objective c hints
	for _, line in ipairs(util.getlines(0, M.line_limit)) do
		if util.findany(line:lower(), { '^@interface', '^@end', '^@class' }) then
			if vim.g.c_syntax_for_h then
				return 'objc'
			end

			return 'objcpp'
		end
	end

	if vim.g.c_syntax_for_h then
		return 'c'
	end

	if vim.g.ch_syntax_for_h then
		return 'ch'
	end

	return 'cpp'
end

--- This function checks:
---     1. If one of the first ten lines start with a '@'. In that case it is
---        probably a change file.
---     2. If the first line starts with # or ! it's probably a ch file.
---     3. If a line has "main", "include", "//" or "/*" it's probably ch.
---     4. Otherwise CHILL is assumed.
--- @return string # The detected filetype
function M.change()
	local first_line = util.getline()
	if util.findany(first_line, { '^#', '^!' }) then
		return 'ch'
	end

	for _, line in ipairs(util.getlines(0, M.line_limit)) do
		if line:find('^@') then
			return 'change'
		end

		if line:find('MODULE') then
			return 'chill'
		end

		if util.findany(line:lower(), { 'main%s*%(', '#%s*include', '//' }) then
			return 'ch'
		end
	end

	return 'chill'
end

--- Read the file contents for msidl hints
---
--- @return string # The detected filetype
function M.idl()
	for _, line in ipairs(util.getlines(0, M.line_limit)) do
		if util.findany(line:lower(), { '^%s*import%s+"unknwn"%.idl', '^%s*import%s+"objidl"%.idl' }) then
			return 'msidl'
		end
	end

	return 'idl'
end

--- Read the file contest to differentiate between matlab, octave, objective c, and other filetypes
--- Taken from vim.filetype.detect
---
--- @return string # the Detected filetype
function M.m()
	if vim.g.filetype_m then
		return vim.g.filetype_m
	end

	-- Excluding end(for|function|if|switch|while) common to Murphi
	local octave_block_terminators =
		[[\<end\%(_try_catch\|classdef\|enumeration\|events\|methods\|parfor\|properties\)\>]]
	local objc_preprocessor = [[\c^\s*#\s*\%(import\|include\|define\|if\|ifn\=def\|undef\|line\|error\|pragma\)\>]]

	-- Whether we've seen a multiline comment leader
	local saw_comment = false
	for _, line in ipairs(util.getlines(0, M.line_limit)) do
		if line:find('^%s*/%*') then
			-- /* ... */ is a comment in Objective C and Murphi, so we can't conclude
			-- it's either of them yet, but track this as a hint in case we don't see
			-- anything more definitive.
			saw_comment = true
		end

		if
			line:find('^%s*//')
			or util.match_vim_regex(line, [[\c^\s*@import\>]])
			or util.match_vim_regex(line, objc_preprocessor)
		then
			return 'objc'
		end

		if
			util.findany(line, { '^%s*#', '^%s*%%!' })
			or util.match_vim_regex(line, [[\c^\s*unwind_protect\>]])
			or util.match_vim_regex(line, [[\c\%(^\|;\)\s*]] .. octave_block_terminators)
		then
			return 'octave'
		end

		if line:find('^%s*%%') then
			return 'matlab'
		end

		if line:find('^%s*%(%*') then
			return 'mma'
		end

		if util.match_vim_regex(line, [[\c^\s*\(\(type\|var\)\>\|--\)]]) then
			return 'murphi'
		end
	end

	if saw_comment then
		-- We didn't see anything definitive, but this looks like either Objective C or Murphi based on the comment
		-- leader. Assume the former as it is more common.
		return 'objc'
	end

	-- Default is Matlab
	return 'matlab'
end

--- Read the file contents to diffrentiate between nroff and objective cpp
--- Taken from vim.filetype.detect
---
--- @return string # the Detected filetype
function M.mm()
	for _, line in ipairs(util.getlines(0, M.line_limit)) do
		if util.match_vim_regex(line, [[\c^\s*\(#\s*\(include\|import\)\>\|@import\>\|/\*\)]]) then
			return 'objcpp'
		end
	end

	return 'nroff'
end

--- Read the file contents to diffrentiate between make and mmix files
--- Taken from vim.filetype.detect
---
--- @return string # the Detected filetype
function M.mms()
	for _, line in ipairs(util.getlines(0, M.line_limit)) do
		if util.findany(line, { '^%s*%%', '^%s*//', '^%*' }) then
			return 'mmix'
		end

		if line:find('^%s*#') then
			return 'make'
		end
	end

	return 'mmix'
end

local pascal_comments = { '^%s*{', '^%s*%(%*', '^%s*//' }
local pascal_keywords = [[\c^\s*\%(program\|unit\|library\|uses\|begin\|procedure\|function\|const\|type\|var\)\>]]

--- Read the file contents to diffrentiate between pascal and puppet filetypes
--- Taken from vim.filetype.detect
---
--- @return string # the Detected filetype
function M.pp()
	if vim.g.filetype_pp then
		return vim.g.filetype_pp
	end

	local line = util.get_next_nonblank_line()
	if util.findany(line, pascal_comments) or util.match_vim_regex(line, pascal_keywords) then
		return 'pascal'
	end

	return 'puppet'
end

--- Read the file contents to diffrentiate between prolog and perl filetypes
--- Taken from vim.filetype.detect
---
--- @return string # the Detected filetype
function M.pl()
	if vim.g.filetype_pl then
		return vim.g.filetype_pl
	end

	-- Recognize Prolog by specific text in the first non-empty line; require a blank after the '%' because Perl uses
	-- "%list" and "%translate"
	local line = util.get_next_nonblank_line()
	if
		line:find(':%-')
		or util.match_vim_regex(line, [[\c\<prolog\>]])
		or util.findany(line, { '^%s*%%+%s', '^%s*%%+$', '^%s*/%*' })
	then
		return 'prolog'
	end

	return 'perl'
end

--- Read the file contents to diffrentiate between different inc filetypes
--- Taken from vim.filetype.detect
---
--- @return string # the Detected filetype
function M.inc()
	if vim.g.filetype_inc then
		return vim.g.filetype_inc
	end

	local lines = util.getlines_as_string(0, M.line_limit, ' ')
	if lines:lower():find('perlscript') then
		return 'aspperl'
	end

	if lines:find('<%%') then
		return 'aspvbs'
	end

	if lines:find('<%?') then
		return 'php'
	end

	-- Pascal supports // comments but they're vary rarely used for file headers so assume POV-Ray
	if util.findany(lines, { '^%s{', '^%s%(%*' }) or util.match_vim_regex(lines, pascal_keywords) then
		return 'pascal'
	end

	if util.findany(lines, {
		'^%s*inherit ',
		'^%s*require ',
		'^%s*%u[%w_:${}]*%s+%??[?:+]?= ',
	}) then
		return 'bitbake'
	end

	local syntax = M.asm_syntax()
	if syntax == vim.g.asmsyntax or syntax == 'asm' then
		return 'pov' -- If the default asm syntax is found
	end

	vim.b.asmsyntax = syntax
	return syntax
end

--- This function checks the file conents for an assembly commet. If not found, assume Progress.
--- Taken from vim.filetype.detect
---
--- @return string # The detected filetype
function M.progress_asm()
	if vim.g.filetype_i then
		return vim.g.filetype_i
	end

	for _, line in ipairs(util.getlines(0, M.line_limit)) do
		if line:find('^%s*;') or line:find('^/%*') then
			return M.asm()
		end

		if not line:find('^%s*$') or line:find('^/%*') then
			-- Not an empty line: doesn't look like valid assembly code or it looks like a Progress /* comment.
			break
		end
	end

	return 'progress'
end

--- This function checks cweb files for hints on whether they are progress files or not
--- Taken from vim.filetype.detect
---
--- @return string # The detected filetype
function M.progress_cweb()
	if vim.g.filetype_w then
		return vim.g.filetype_w
	else
		if util.getlines():lower():find('^&analyze') or util.getlines(2):lower():find('^&global%-define') then
			return 'progress'
		end

		return 'cweb'
	end
end

--- This function checks for valid Pascal syntax. Look for either an opening comment or a program start. If not found,
--- assume Progress.
--- Taken from vim.filetype.detect
---
--- @return string # The detected filetype
function M.progress_pascal()
	if vim.g.filetype_p then
		return vim.g.filetype_p
	end

	for _, line in ipairs(util.getlines(0, M.line_limit)) do
		if util.findany(line, pascal_comments) or util.match_vim_regex(line, pascal_keywords) then
			return 'pascal'
		end

		if not line:find('^%s*$') or line:find('^/%*') then
			-- Not an empty line: Doesn't look like valid Pascal code, or it looks like a Progress /* comment
			break
		end
	end

	return 'progress'
end

--- Read the file contents for hints Checks if this is a bindzone file or not
--- Taken from vim.filetype.detect
---
--- @return string? # The detected filetype
function M.bindzone()
	local lines = util.getlines_as_string(0, M.line_limit)
	if util.findany(lines, { '^; <<>> DiG [0-9%.]+.* <<>>', '%$ORIGIN', '%$TTL', 'IN%s+SOA' }) then
		return 'bindzone'
	end
end

local udev_rules_pattern = '^%s*udev_rules%s*=%s*"([%^"]+)/*".*'

--- This function looks at the file path rather the contents of the rule file. if the path is in any of the predifined
--- udev rules path or is in one off the paths defined in '/etc/udev/udev.conf', then it is not a udevrules file.
--- Taken from vim.filetype.detect
---
--- @param path string The absolute path the file is at
--- @return string # The detected filetype
function M.rules(path)
	path = path:lower()
	if
		util.findany(path, {
			'/etc/udev/.*%.rules$',
			'/etc/udev/rules%.d/.*$.rules$',
			'/usr/lib/udev/.*%.rules$',
			'/usr/lib/udev/rules%.d/.*%.rules$',
			'/lib/udev/.*%.rules$',
			'/lib/udev/rules%.d/.*%.rules$',
		})
	then
		return 'udevrules'
	end

	if path:find('^/etc/ufw/') then
		-- Better than hog
		return 'conf'
	end

	if util.findany(path, { '^/etc/polkit%-1/rules%.d', '/usr/share/polkit%-1/rules%.d' }) then
		return 'javascript'
	end

	local ok, config_lines = pcall(vim.fn.readfile, '/etc/udev/udev.conf')
	if not ok then
		return 'hog'
	end

	local dir = vim.fs.dirname(path)
	for _, line in ipairs(config_lines) do
		local match = line:match(udev_rules_pattern)
		if not match then
			goto continue
		end

		local udev_rules = line:gsub(udev_rules_pattern, match, 1)
		if dir == udev_rules then
			return 'udevrules'
		end

		::continue::
	end

	return 'hog'
end

--- Read the file contents to diffrentiate between racc and yacc
--- Taken from vim.filetype.detect
---
--- @return string? # The detected filetype
function M.inp()
	if util.getline():find('^%*') then
		return 'abaqus'
	end

	for _, line in ipairs(util.getlines(0, M.line_limit)) do
		if line:lower():find('^header surface data') then
			return 'trasys'
		end
	end
end

--- Read the file contents to diffrentiate between racc and yacc
--- Taken from vim.filetype.detect
---
--- @return string # The detected filetype
function M.y()
	for _, line in ipairs(util.getlines(0, M.line_limit)) do
		if line:find('^%s*%%') then
			return 'yacc'
		end

		if util.match_vim_regex(line, [[\c^\s*\(#\|class\>\)]]) and not line:lower():find('^%s*#%s*include') then
			return 'racc'
		end
	end

	return 'yacc'
end

--- Rely on the file to start with a comment.
--- MS message text files use ';', Sendmail files use '#' or 'dnl'
--- Taken from vim.filetype.detect
---
--- @return string # The detected filetype
function M.mc()
	for _, line in ipairs(util.getlines(0, M.line_limit)) do
		if util.findany(line, { '^%s*#', '^s*dnl' }) then
			return 'm4'
		end

		if line:find('^#s*;') then
			return 'msmessages'
		end
	end

	return 'm4'
end

--- Check the first nonblank line for RAPID markers
--- Taken from vim.filetype.detect
---
--- @return boolean # If the file contains RAPID markers or not
local function is_rapid()
	-- Called from mod, prg or sys functions
	local line = util.get_next_nonblank_line()
	return util.match_vim_regex(line, [[\c\v^\s*%(\%{3}|module\s+\k+\s*%(\(|$))]]) ---@diagnostic disable-line
end

--- Read the file contents to identify if the file is RAPID or a cfg file
--- Taken from vim.filetype.detect
---
--- @return string? # The detected filetype
function M.cfg()
	if vim.g.filetype_cfg then
		return vim.g.filetype_cfg
	end

	local line = util.getline():lower()
	if util.findany(line, { 'eio:cfg', 'mmc:cfg', 'moc:cfg', 'proc:cfg', 'sio:cfg', 'sys:cfg' }) or is_rapid() then
		return 'rapid'
	end

	return 'cfg'
end

--- Read the check if the filename is an upstreamdat file before checking the file contents
--- Taken from vim.filetype.detect
---
--- @param file_name string? The file name
--- @return string? # The detected filetype
function M.dat(file_name)
	-- Innovation data processing
	if util.findany(file_name, { '^upstream%.dat$', '^upstream%..*%.dat$', '^.*%.upstream%.dat$' }) then
		return 'upstreamdat'
	end

	if vim.g.filetype_dat then
		return vim.g.filetype_dat
	end

	-- Determine if a *.dat file is Kuka Robot Language
	local line = util.get_next_nonblank_line()
	if util.match_vim_regex(line, [[\c\v^\s*%(\&\w+|defdat>)]]) then
		return 'krl'
	end
end

--- This function is called for all files under */debian/patches/*, make sure not to non-dep3patch files, such as README
--- and other text files.
--- Taken from vim.filetype.detect
---
--- @return string? # The detected filetype
function M.dep3patch()
	for _, line in ipairs(util.getlines(0, M.line_limit)) do
		if
			util.findany(line, {
				'^Description:',
				'^Subject:',
				'^Origin:',
				'^Bug:',
				'^Forwarded:',
				'^Author:',
				'^From:',
				'^Reviewed%-by:',
				'^Acked%-by:',
				'^Last%-Updated:',
				'^Applied%-Upstream:',
			})
		then
			return 'dep3patch'
		end

		if line:find('^%-%-%-') then
			-- End of headers found. stop processing
			return
		end
	end
end

--- Read the file's content to differentiate between scala and SuperCollider files
--- Taken from vim.filetype.detect
---
--- @return string? # The detected filetype
function M.sc()
	for _, line in ipairs(util.getlines(0, M.line_limit)) do
		if
			util.findany(line, {
				'[A-Za-z0-9]*%s:%s[A-Za-z0-9]',
				'var%s<',
				'classvar%s<',
				'%^this.*',
				'|%w*|',
				'%+%s%w*%s{',
				'%*ar%s',
			})
		then
			return 'supercollider'
		end
	end

	return 'scala'
end

return M
