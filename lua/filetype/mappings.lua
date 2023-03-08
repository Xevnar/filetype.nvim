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
--- @param file_path string
--- @return filetype_mapping_argument # New callback_args
function M.callback_args:new(file_path)
	local o = { file_path = file_path }
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
M.extensions = {
	['8th'] = '8th',
	['a65'] = 'a65',
	['aap'] = 'aap',
	['abap'] = 'abap',
	['abc'] = 'abc',
	['abl'] = 'abel',
	['wrm'] = 'acedb',
	['ada'] = 'ada',
	['adb'] = 'ada',
	['ads'] = 'ada',
	['gpr'] = 'ada',
	['tdf'] = 'ahdl',
	['aidl'] = 'aidl',
	['aml'] = 'aml',
	['run'] = 'ampl',
	['scpt'] = 'applescript',
	['ino'] = 'arduino',
	['pde'] = 'arduino',
	['art'] = 'art',
	['adoc'] = 'asciidoc',
	['asciidoc'] = 'asciidoc',
	['asn'] = 'asn',
	['asn1'] = 'asn',
	['astro'] = 'astro',
	['as'] = 'atlas',
	['atl'] = 'atlas',
	['ahk'] = 'autohotkey',
	['au3'] = 'autoit',
	['ave'] = 'ave',
	['awk'] = 'awk',
	['gawk'] = 'awk',
	['imp'] = 'b',
	['mch'] = 'b',
	['ref'] = 'b',
	['bass'] = 'bass',
	['bc'] = 'bc',
	['bdf'] = 'bdf',
	['beancount'] = 'beancount',
	['bib'] = 'bib',
	['bicep'] = 'bicep',
	['bb'] = 'bitbake',
	['bbclass'] = 'bitbake',
	['bbappend'] = 'bitbake',
	['bl'] = 'blank',
	['blp'] = 'blueprint',
	['bsd'] = 'bsdl',
	['bsdl'] = 'bsdl',
	['bst'] = 'bst',
	['bzl'] = 'bzl',
	['BUILD'] = 'bzl',
	['bazel'] = 'bzl',
	['qc'] = 'c',
	['cabal'] = 'cabal',
	['capnp'] = 'capnp',
	['cdl'] = 'cdl',
	['toc'] = 'cdrtoc',
	['cfc'] = 'cf',
	['cfi'] = 'cf',
	['cfm'] = 'cf',
	['hgrc'] = 'cfg',
	['chf'] = 'ch',
	['chai'] = 'chaiscript',
	['chs'] = 'chaskell',
	['chatito'] = 'chatito',
	['cho'] = 'chordpro',
	['crd'] = 'chordpro',
	['chopro'] = 'chordpro',
	['crdpro'] = 'chordpro',
	['chordpro'] = 'chordpro',
	['eni'] = 'cl',
	['dcl'] = 'clean',
	['icl'] = 'clean',
	['clj'] = 'clojure',
	['cljc'] = 'clojure',
	['cljs'] = 'clojure',
	['cljx'] = 'clojure',
	['cmake'] = 'cmake',
	['cmod'] = 'cmod',
	['cbl'] = 'cobol',
	['cob'] = 'cobol',
	['lib'] = 'cobol',
	['atg'] = 'coco',
	['recipe'] = 'conaryrecipe',
	['nmconnection'] = 'confini',
	['mkii'] = 'context',
	['mkiv'] = 'context',
	['mklx'] = 'context',
	['mkvi'] = 'context',
	['mkxl'] = 'context',
	['cook'] = 'cook',
	['C'] = 'cpp',
	['H'] = 'cpp',
	['hh'] = 'cpp',
	['c++'] = 'cpp',
	['cxx'] = 'cpp',
	['hpp'] = 'cpp',
	['hxx'] = 'cpp',
	['inl'] = 'cpp',
	['ipp'] = 'cpp',
	['moc'] = 'cpp',
	['tcc'] = 'cpp',
	['tlh'] = 'cpp',
	['cql'] = 'cqlang',
	['crm'] = 'crm',
	['cs'] = 'cs',
	['csx'] = 'cs',
	['csc'] = 'csc',
	['csdl'] = 'csdl',
	['csp'] = 'csp',
	['fdr'] = 'csp',
	['css'] = 'css',
	['csv'] = 'csv',
	['con'] = 'cterm',
	['feature'] = 'cucumber',
	['cu'] = 'cuda',
	['cuh'] = 'cuda',
	['cue'] = 'cue',
	['pld'] = 'cupl',
	['si'] = 'cuplsim',
	['cyn'] = 'cynpp',
	['drt'] = 'dart',
	['dart'] = 'dart',
	['ds'] = 'datascript',
	['dcd'] = 'dcd',
	['def'] = 'def',
	['desc'] = 'desc',
	['desktop'] = 'desktop',
	['directory'] = 'desktop',
	['rej'] = 'diff',
	['diff'] = 'diff',
	['Dockerfile'] = 'dockerfile',
	['dockerfile'] = 'dockerfile',
	['bat'] = 'dosbatch',
	['ini'] = 'dosini',
	['wrap'] = 'dosini',
	['gv'] = 'dot',
	['dot'] = 'dot',
	['drc'] = 'dracula',
	['drac'] = 'dracula',
	['dtd'] = 'dtd',
	['dts'] = 'dts',
	['dtsi'] = 'dts',
	['dune'] = 'dune',
	['dylan'] = 'dylan',
	['intr'] = 'dylanintr',
	['lid'] = 'dylanlid',
	['ecd'] = 'ecd',
	['edf'] = 'edif',
	['edo'] = 'edif',
	['edif'] = 'edif',
	['eex'] = 'eelixir',
	['leex'] = 'eelixir',
	['exs'] = 'elixir',
	['elm'] = 'elm',
	['lc'] = 'elsa',
	['elv'] = 'elvish',
	['epp'] = 'epuppet',
	['erl'] = 'erlang',
	['hrl'] = 'erlang',
	['yaws'] = 'erlang',
	['erb'] = 'eruby',
	['rhtml'] = 'eruby',
	['EC'] = 'esqlc',
	['ec'] = 'esqlc',
	['strl'] = 'esterel',
	['exp'] = 'expect',
	['factor'] = 'factor',
	['fal'] = 'falcon',
	['fan'] = 'fan',
	['fwt'] = 'fan',
	['fnl'] = 'fennel',
	['4gh'] = 'fgl',
	['4gl'] = 'fgl',
	['m4gl'] = 'fgl',
	['fish'] = 'fish',
	['wiki'] = 'flexwiki',
	['fex'] = 'focexec',
	['focexec'] = 'focexec',
	['ft'] = 'forth',
	['fth'] = 'forth',
	['F'] = 'fortran',
	['f'] = 'fortran',
	['F03'] = 'fortran',
	['F08'] = 'fortran',
	['F77'] = 'fortran',
	['F90'] = 'fortran',
	['F95'] = 'fortran',
	['FOR'] = 'fortran',
	['FPP'] = 'fortran',
	['FTN'] = 'fortran',
	['f03'] = 'fortran',
	['f08'] = 'fortran',
	['f77'] = 'fortran',
	['f90'] = 'fortran',
	['f95'] = 'fortran',
	['for'] = 'fortran',
	['fpp'] = 'fortran',
	['ftn'] = 'fortran',
	['fortran'] = 'fortran',
	['fpc'] = 'fpcmake',
	['fsl'] = 'framescript',
	['fb'] = 'freebasic',
	['fsh'] = 'fsh',
	['fsi'] = 'fsharp',
	['fsx'] = 'fsharp',
	['fusion'] = 'fusion',
	['gdb'] = 'gdb',
	['mo'] = 'gdmo',
	['gdmo'] = 'gdmo',
	['tres'] = 'gdresource',
	['tscn'] = 'gdresource',
	['gd'] = 'gdscript',
	['shader'] = 'gdshader',
	['gdshader'] = 'gdshader',
	['ged'] = 'gedcom',
	['gmi'] = 'gemtext',
	['gemini'] = 'gemtext',
	['gift'] = 'gift',
	['gleam'] = 'gleam',
	['glsl'] = 'glsl',
	['gpi'] = 'gnuplot',
	['go'] = 'go',
	['gp'] = 'gp',
	['gs'] = 'grads',
	['gql'] = 'graphql',
	['graphql'] = 'graphql',
	['graphqls'] = 'graphql',
	['gretl'] = 'gretl',
	['gradle'] = 'groovy',
	['groovy'] = 'groovy',
	['Jenkinsfile'] = 'groovy',
	['gsp'] = 'gsp',
	['gyp'] = 'gyp',
	['gypi'] = 'gyp',
	['hack'] = 'hack',
	['hackpartial'] = 'hack',
	['haml'] = 'haml',
	['hsm'] = 'hamster',
	['hbs'] = 'handlebars',
	['ha'] = 'hare',
	['hs'] = 'haskell',
	['hsc'] = 'haskell',
	['hsig'] = 'haskell',
	['hs-boot'] = 'haskell',
	['ht'] = 'haste',
	['htpp'] = 'hastepreproc',
	['hx'] = 'haxe',
	['hb'] = 'hb',
	['hcl'] = 'hcl',
	['heex'] = 'heex',
	['ev'] = 'hercules',
	['vc'] = 'hercules',
	['sum'] = 'hercules',
	['errsum'] = 'hercules',
	['h32'] = 'hex',
	['hex'] = 'hex',
	['hjson'] = 'hjson',
	['m3u'] = 'hlsplaylist',
	['m3u8'] = 'hlsplaylist',
	['hog'] = 'hog',
	['hws'] = 'hollywood',
	['hoon'] = 'hoon',
	['cshtml'] = 'html',
	['htb'] = 'httest',
	['htt'] = 'httest',
	['hxml'] = 'hxml',
	['iba'] = 'ibasic',
	['ibi'] = 'ibasic',
	['icn'] = 'icon',
	['INF'] = 'inform',
	['inf'] = 'inform',
	['ii'] = 'initng',
	['iss'] = 'iss',
	['ist'] = 'ist',
	['mst'] = 'ist',
	['ijs'] = 'j',
	['JAL'] = 'jal',
	['jal'] = 'jal',
	['jpl'] = 'jam',
	['jpr'] = 'jam',
	['jav'] = 'java',
	['java'] = 'java',
	['jj'] = 'javacc',
	['jjt'] = 'javacc',
	['es'] = 'javascript',
	['js'] = 'javascript',
	['cjs'] = 'javascript',
	['jsm'] = 'javascript',
	['mjs'] = 'javascript',
	['javascript'] = 'javascript',
	['gjs'] = 'javascript.glimmer',
	['jsx'] = 'javascriptreact',
	['clp'] = 'jess',
	['jgr'] = 'jgraph',
	['j73'] = 'jovial',
	['jov'] = 'jovial',
	['jovial'] = 'jovial',
	['properties'] = 'jproperties',
	['jq'] = 'jq',
	['json'] = 'json',
	['slnf'] = 'json',
	['ipynb'] = 'json',
	['jsonp'] = 'json',
	['json-patch'] = 'json',
	['webmanifest'] = 'json',
	['json5'] = 'json5',
	['jsonc'] = 'jsonc',
	['jsonnet'] = 'jsonnet',
	['libsonnet'] = 'jsonnet',
	['jsp'] = 'jsp',
	['jl'] = 'julia',
	['kv'] = 'kivy',
	['kix'] = 'kix',
	['kt'] = 'kotlin',
	['ktm'] = 'kotlin',
	['kts'] = 'kotlin',
	['SUB'] = 'krl',
	['SUb'] = 'krl',
	['SuB'] = 'krl',
	['Sub'] = 'krl',
	['sUB'] = 'krl',
	['sUb'] = 'krl',
	['suB'] = 'krl',
	['sub'] = 'krl',
	['ks'] = 'kscript',
	['k'] = 'kwt',
	['ACE'] = 'lace',
	['ace'] = 'lace',
	['lte'] = 'latte',
	['latte'] = 'latte',
	['ld'] = 'ld',
	['ldif'] = 'ldif',
	['ldg'] = 'ledger',
	['ledger'] = 'ledger',
	['journal'] = 'ledger',
	['less'] = 'less',
	['l'] = 'lex',
	['l++'] = 'lex',
	['lex'] = 'lex',
	['lxx'] = 'lex',
	['lhs'] = 'lhaskell',
	['ll'] = 'lifelines',
	['ly'] = 'lilypond',
	['ily'] = 'lilypond',
	['liquid'] = 'liquid',
	['L'] = 'lisp',
	['cl'] = 'lisp',
	['el'] = 'lisp',
	['asd'] = 'lisp',
	['lsp'] = 'lisp',
	['lisp'] = 'lisp',
	['lt'] = 'lite',
	['lite'] = 'lite',
	['lgt'] = 'logtalk',
	['lot'] = 'lotos',
	['lotos'] = 'lotos',
	['lou'] = 'lout',
	['lout'] = 'lout',
	['lpc'] = 'lpc',
	['ulpc'] = 'lpc',
	['lss'] = 'lss',
	['lua'] = 'lua',
	['nse'] = 'lua',
	['rockspec'] = 'lua',
	['lrc'] = 'lyrics',
	['quake'] = 'm3quake',
	['at'] = 'm4',
	['m4'] = 'm4',
	['eml'] = 'mail',
	['mk'] = 'make',
	['dsp'] = 'make',
	['mak'] = 'make',
	['page'] = 'mallard',
	['map'] = 'map',
	['mv'] = 'maple',
	['mpl'] = 'maple',
	['mws'] = 'maple',
	['md'] = 'markdown',
	['mkd'] = 'markdown',
	['mdwn'] = 'markdown',
	['mkdn'] = 'markdown',
	['mdown'] = 'markdown',
	['markdown'] = 'markdown',
	['comp'] = 'mason',
	['mason'] = 'mason',
	['mhtml'] = 'mason',
	['mas'] = 'master',
	['master'] = 'master',
	['dm1'] = 'maxima',
	['dm2'] = 'maxima',
	['dm3'] = 'maxima',
	['dmt'] = 'maxima',
	['wxm'] = 'maxima',
	['demo'] = 'maxima',
	['mel'] = 'mel',
	['mmd'] = 'mermaid',
	['mmdc'] = 'mermaid',
	['mermaid'] = 'mermaid',
	['mf'] = 'mf',
	['mgl'] = 'mgl',
	['mgp'] = 'mgp',
	['my'] = 'mib',
	['mib'] = 'mib',
	['mix'] = 'mix',
	['mixal'] = 'mix',
	['nb'] = 'mma',
	['mmp'] = 'mmp',
	['m2'] = 'modula2',
	['mi'] = 'modula2',
	['DEF'] = 'modula2',
	['i3'] = 'modula3',
	['ig'] = 'modula3',
	['m3'] = 'modula3',
	['mg'] = 'modula3',
	['lm3'] = 'modula3',
	['isc'] = 'monk',
	['ssc'] = 'monk',
	['tsc'] = 'monk',
	['monk'] = 'monk',
	['moo'] = 'moo',
	['moon'] = 'moonscript',
	['mof'] = 'msidl',
	['odl'] = 'msidl',
	['msql'] = 'msql',
	['mu'] = 'mupad',
	['mush'] = 'mush',
	['mysql'] = 'mysql',
	['nql'] = 'n1ql',
	['n1ql'] = 'n1ql',
	['nanorc'] = 'nanorc',
	['ncf'] = 'ncf',
	['nginx'] = 'nginx',
	['nim'] = 'nim',
	['nims'] = 'nim',
	['nimble'] = 'nim',
	['ninja'] = 'ninja',
	['nix'] = 'nix',
	['nqc'] = 'nqc',
	['nr'] = 'nroff',
	['tr'] = 'nroff',
	['man'] = 'nroff',
	['mom'] = 'nroff',
	['roff'] = 'nroff',
	['tmac'] = 'nroff',
	['nsh'] = 'nsis',
	['nsi'] = 'nsis',
	['obj'] = 'obj',
	['obl'] = 'obse',
	['obse'] = 'obse',
	['oblivion'] = 'obse',
	['obscript'] = 'obse',
	['ml'] = 'ocaml',
	['mli'] = 'ocaml',
	['mll'] = 'ocaml',
	['mlp'] = 'ocaml',
	['mlt'] = 'ocaml',
	['mly'] = 'ocaml',
	['mlip'] = 'ocaml',
	['occ'] = 'occam',
	['xin'] = 'omnimark',
	['xom'] = 'omnimark',
	['opam'] = 'opam',
	['or'] = 'openroad',
	['scad'] = 'openscad',
	['ovpn'] = 'openvpn',
	['OPL'] = 'opl',
	['OPl'] = 'opl',
	['OpL'] = 'opl',
	['Opl'] = 'opl',
	['oPL'] = 'opl',
	['oPl'] = 'opl',
	['opL'] = 'opl',
	['opl'] = 'opl',
	['ora'] = 'ora',
	['org'] = 'org',
	['org_archive'] = 'org',
	['papp'] = 'papp',
	['pxml'] = 'papp',
	['pxsl'] = 'papp',
	['dpr'] = 'pascal',
	['lpr'] = 'pascal',
	['pas'] = 'pascal',
	['pbtxt'] = 'pbtxt',
	['g'] = 'pccts',
	['pcmk'] = 'pcmk',
	['pdf'] = 'pdf',
	['al'] = 'perl',
	['plx'] = 'perl',
	['psgi'] = 'perl',
	['ctp'] = 'php',
	['php'] = 'php',
	['php0'] = 'php',
	['php1'] = 'php',
	['php2'] = 'php',
	['php3'] = 'php',
	['php4'] = 'php',
	['php5'] = 'php',
	['php6'] = 'php',
	['php7'] = 'php',
	['php8'] = 'php',
	['php9'] = 'php',
	['phpt'] = 'php',
	['phtml'] = 'php',
	['theme'] = 'php',
	['pike'] = 'pike',
	['pmod'] = 'pike',
	['rcp'] = 'pilrc',
	['pl1'] = 'pli',
	['pli'] = 'pli',
	['p36'] = 'plm',
	['pac'] = 'plm',
	['plm'] = 'plm',
	['plp'] = 'plp',
	['pls'] = 'plsql',
	['plsql'] = 'plsql',
	['po'] = 'po',
	['pot'] = 'po',
	['pod'] = 'pod',
	['filter'] = 'poefilter',
	['pk'] = 'poke',
	['ai'] = 'postscr',
	['ps'] = 'postscr',
	['afm'] = 'postscr',
	['eps'] = 'postscr',
	['pfa'] = 'postscr',
	['epsf'] = 'postscr',
	['epsi'] = 'postscr',
	['pov'] = 'pov',
	['ppd'] = 'ppd',
	['ih'] = 'ppwiz',
	['it'] = 'ppwiz',
	['prisma'] = 'prisma',
	['action'] = 'privoxy',
	['pc'] = 'proc',
	['pdb'] = 'prolog',
	['pml'] = 'promela',
	['proto'] = 'proto',
	['ps1'] = 'ps1',
	['psd1'] = 'ps1',
	['psm1'] = 'ps1',
	['pssc'] = 'ps1',
	['ps1xml'] = 'ps1xml',
	['psf'] = 'psf',
	['psl'] = 'psl',
	['pug'] = 'pug',
	['arr'] = 'pyret',
	['pxd'] = 'pyrex',
	['pyx'] = 'pyrex',
	['py'] = 'python',
	['ptl'] = 'python',
	['pyi'] = 'python',
	['pyw'] = 'python',
	['ql'] = 'ql',
	['qll'] = 'ql',
	['qmd'] = 'quarto',
	['mat'] = 'radiance',
	['rad'] = 'radiance',
	['p6'] = 'raku',
	['t6'] = 'raku',
	['pm6'] = 'raku',
	['pod6'] = 'raku',
	['raku'] = 'raku',
	['rakudoc'] = 'raku',
	['rakumod'] = 'raku',
	['rakutest'] = 'raku',
	['raml'] = 'raml',
	['rbs'] = 'rbs',
	['rch'] = 'rc',
	['rego'] = 'rego',
	['rem'] = 'remind',
	['remind'] = 'remind',
	['res'] = 'rescript',
	['resi'] = 'rescript',
	['frt'] = 'reva',
	['orx'] = 'rexx',
	['rex'] = 'rexx',
	['rxj'] = 'rexx',
	['rxo'] = 'rexx',
	['rexx'] = 'rexx',
	['jrexx'] = 'rexx',
	['rexxj'] = 'rexx',
	['testUnit'] = 'rexx',
	['testGroup'] = 'rexx',
	['Rd'] = 'rhelp',
	['rd'] = 'rhelp',
	['rib'] = 'rib',
	['Rmd'] = 'rmd',
	['Smd'] = 'rmd',
	['rmd'] = 'rmd',
	['smd'] = 'rmd',
	['rnc'] = 'rnc',
	['rng'] = 'rng',
	['Rnw'] = 'rnoweb',
	['Snw'] = 'rnoweb',
	['rnw'] = 'rnoweb',
	['snw'] = 'rnoweb',
	['robot'] = 'robot',
	['resource'] = 'robot',
	['rsc'] = 'routeros',
	['x'] = 'rpcgen',
	['rpl'] = 'rpl',
	['Rrst'] = 'rrst',
	['Srst'] = 'rrst',
	['rrst'] = 'rrst',
	['srst'] = 'rrst',
	['rst'] = 'rst',
	['rtf'] = 'rtf',
	['rb'] = 'ruby',
	['ru'] = 'ruby',
	['rbw'] = 'ruby',
	['rjs'] = 'ruby',
	['rake'] = 'ruby',
	['rant'] = 'ruby',
	['rxml'] = 'ruby',
	['Appfile'] = 'ruby',
	['Podfile'] = 'ruby',
	['builder'] = 'ruby',
	['gemspec'] = 'ruby',
	['Brewfile'] = 'ruby',
	['Fastfile'] = 'ruby',
	['rs'] = 'rust',
	['sas'] = 'sas',
	['sass'] = 'sass',
	['sa'] = 'sather',
	['sbt'] = 'sbt',
	['scala'] = 'scala',
	['ss'] = 'scheme',
	['rkt'] = 'scheme',
	['scm'] = 'scheme',
	['sld'] = 'scheme',
	['rktd'] = 'scheme',
	['rktl'] = 'scheme',
	['sce'] = 'scilab',
	['sci'] = 'scilab',
	['scss'] = 'scss',
	['sd'] = 'sd',
	['sdc'] = 'sdc',
	['pr'] = 'sdl',
	['sdl'] = 'sdl',
	['sed'] = 'sed',
	['sexp'] = 'sexplib',
	['siv'] = 'sieve',
	['sieve'] = 'sieve',
	['sim'] = 'simula',
	['s85'] = 'sinda',
	['sin'] = 'sinda',
	['ssi'] = 'sisu',
	['ssm'] = 'sisu',
	['sst'] = 'sisu',
	['-sst'] = 'sisu',
	['_sst'] = 'sisu',
	['il'] = 'skill',
	['cdf'] = 'skill',
	['ils'] = 'skill',
	['sl'] = 'slang',
	['ice'] = 'slice',
	['score'] = 'slrnsc',
	['smali'] = 'smali',
	['tpl'] = 'smarty',
	['hlp'] = 'smcl',
	['ihlp'] = 'smcl',
	['smcl'] = 'smcl',
	['smt'] = 'smith',
	['smith'] = 'smith',
	['smithy'] = 'smithy',
	['sml'] = 'sml',
	['sno'] = 'snobol4',
	['spt'] = 'snobol4',
	['sol'] = 'solidity',
	['sln'] = 'solution',
	['rq'] = 'sparql',
	['sparql'] = 'sparql',
	['spec'] = 'spec',
	['sp'] = 'spice',
	['spice'] = 'spice',
	['spd'] = 'spup',
	['spdata'] = 'spup',
	['speedup'] = 'spup',
	['spi'] = 'spyce',
	['spy'] = 'spyce',
	['pkb'] = 'sql',
	['pks'] = 'sql',
	['tyb'] = 'sql',
	['tyc'] = 'sql',
	['typ'] = 'sql',
	['sqlj'] = 'sqlj',
	['sqi'] = 'sqr',
	['sqr'] = 'sqr',
	['nut'] = 'squirrel',
	['mot'] = 'srec',
	['s19'] = 'srec',
	['s28'] = 'srec',
	['s37'] = 'srec',
	['srec'] = 'srec',
	['srt'] = 'srt',
	['ass'] = 'ssa',
	['ssa'] = 'ssa',
	['st'] = 'st',
	['do'] = 'stata',
	['ado'] = 'stata',
	['mata'] = 'stata',
	['imata'] = 'stata',
	['stp'] = 'stp',
	['quark'] = 'supercollider',
	['sface'] = 'surface',
	['svelte'] = 'svelte',
	['svg'] = 'svg',
	['swift'] = 'swift',
	['service'] = 'systemd',
	['sv'] = 'systemverilog',
	['svh'] = 'systemverilog',
	['tak'] = 'tak',
	['task'] = 'taskedit',
	['tk'] = 'tcl',
	['tm'] = 'tcl',
	['itk'] = 'tcl',
	['tcl'] = 'tcl',
	['itcl'] = 'tcl',
	['jacl'] = 'tcl',
	['tl'] = 'teal',
	['tmpl'] = 'template',
	['ti'] = 'terminfo',
	['tfvars'] = 'terraform-vars',
	['bbl'] = 'tex',
	['dtx'] = 'tex',
	['ltx'] = 'tex',
	['sty'] = 'tex',
	['latex'] = 'tex',
	['txi'] = 'texinfo',
	['texi'] = 'texinfo',
	['texinfo'] = 'texinfo',
	['txt'] = 'text',
	['text'] = 'text',
	['thrift'] = 'thrift',
	['tla'] = 'tla',
	['tli'] = 'tli',
	['lock'] = 'toml',
	['toml'] = 'toml',
	['tpp'] = 'tpp',
	['treetop'] = 'treetop',
	['slt'] = 'tsalt',
	['tsscl'] = 'tsscl',
	['tssgm'] = 'tssgm',
	['tssop'] = 'tssop',
	['tsv'] = 'tsv',
	['tutor'] = 'tutor',
	['twig'] = 'twig',
	['cts'] = 'typescript',
	['mts'] = 'typescript',
	['gts'] = 'typescript.glimmer',
	['tsx'] = 'typescriptreact',
	['uc'] = 'uc',
	['uil'] = 'uil',
	['uit'] = 'uil',
	['vala'] = 'vala',
	['vb'] = 'vb',
	['ctl'] = 'vb',
	['dsm'] = 'vb',
	['sba'] = 'vb',
	['vbs'] = 'vb',
	['vdf'] = 'vdf',
	['vpp'] = 'vdmpp',
	['vdmpp'] = 'vdmpp',
	['vdmrt'] = 'vdmrt',
	['vdm'] = 'vdmsl',
	['vdmsl'] = 'vdmsl',
	['vr'] = 'vera',
	['vrh'] = 'vera',
	['vri'] = 'vera',
	['v'] = 'verilog',
	['va'] = 'verilogams',
	['vams'] = 'verilogams',
	['hdl'] = 'vhdl',
	['vbe'] = 'vhdl',
	['vhd'] = 'vhdl',
	['vho'] = 'vhdl',
	['vst'] = 'vhdl',
	['vhdl'] = 'vhdl',
	['tape'] = 'vhs',
	['vba'] = 'vim',
	['vim'] = 'vim',
	['mar'] = 'vmasm',
	['cm'] = 'voscm',
	['wrl'] = 'vrml',
	['vroom'] = 'vroom',
	['vue'] = 'vue',
	['wat'] = 'wast',
	['wast'] = 'wast',
	['wdl'] = 'wdl',
	['wm'] = 'webmacro',
	['wbt'] = 'winbatch',
	['wml'] = 'wml',
	['wsc'] = 'wsh',
	['wsf'] = 'wsh',
	['wsml'] = 'wsml',
	['ad'] = 'xdefaults',
	['xht'] = 'xhtml',
	['xhtml'] = 'xhtml',
	['msc'] = 'xmath',
	['msf'] = 'xmath',
	['ui'] = 'xml',
	['mpd'] = 'xml',
	['rss'] = 'xml',
	['tpm'] = 'xml',
	['wpl'] = 'xml',
	['xlf'] = 'xml',
	['xmi'] = 'xml',
	['xul'] = 'xml',
	['atom'] = 'xml',
	['psc1'] = 'xml',
	['wsdl'] = 'xml',
	['cdxml'] = 'xml',
	['xliff'] = 'xml',
	['csproj'] = 'xml',
	['fsproj'] = 'xml',
	['vbproj'] = 'xml',
	['xpm2'] = 'xpm2',
	['xq'] = 'xquery',
	['xql'] = 'xquery',
	['xqm'] = 'xquery',
	['xqy'] = 'xquery',
	['xquery'] = 'xquery',
	['xs'] = 'xs',
	['xsd'] = 'xsd',
	['xsl'] = 'xslt',
	['xslt'] = 'xslt',
	['yy'] = 'yacc',
	['y++'] = 'yacc',
	['yxx'] = 'yacc',
	['bu'] = 'yaml',
	['yml'] = 'yaml',
	['yaml'] = 'yaml',
	['yang'] = 'yang',
	['z8a'] = 'z8a',
	['zig'] = 'zig',
	['zu'] = 'zimbu',
	['zut'] = 'zimbutempl',
	['zir'] = 'zir',
	['zsh'] = 'zsh',
	['sh'] = function()
		return detect.sh('sh', true)
	end,
	['env'] = function()
		return detect.sh('sh', true)
	end,
	['bash'] = function()
		return detect.sh('bash')
	end,
	['ebuild'] = function()
		return detect.sh('bash')
	end,
	['eclass'] = function()
		return detect.sh('bash')
	end,
	['csh'] = function()
		return detect.csh()
	end,
	['ksh'] = function()
		return detect.sh('ksh')
	end,
	['tcsh'] = function()
		return detect.sh('tcsh')
	end,
	['inp'] = function()
		return detect.inp()
	end,
	['A'] = function()
		return detect.asm()
	end,
	['S'] = function()
		return detect.asm()
	end,
	['a'] = function()
		return detect.asm()
	end,
	['s'] = function()
		return detect.asm()
	end,
	['asm'] = function()
		return detect.asm()
	end,
	['lst'] = function()
		return detect.asm()
	end,
	['mac'] = function()
		return detect.asm()
	end,
	['inc'] = function()
		return detect.inc()
	end,
	['asa'] = function()
		return (vim.g.filetype_asa and vim.g.filetype_asa) or 'aspvbs'
	end,
	['asp'] = function()
		if vim.g.filetype_asp then
			return vim.g.filetype_asp
		end

		if util.getlines_as_string(0, detect.line_limit, ' '):find('perlscript') then
			return 'aspperl'
		end

		return 'aspvbs'
	end,
	['db'] = function()
		return detect.bindzone()
	end,
	['com'] = function()
		return detect.bindzone() or 'dcl'
	end,
	['btm'] = function()
		if vim.g.dosbatch_syntax_for_btm and vim.g.dosbatch_syntax_for_btm ~= 0 then
			return 'dosbatch'
		end

		return 'btm'
	end,
	['c'] = function()
		return detect.lpc()
	end,
	['h'] = function()
		return detect.header()
	end,
	['ch'] = function()
		return detect.change()
	end,
	['cpy'] = function()
		return (util.getline():find('^##') and 'python') or 'cobol'
	end,
	['hook'] = function()
		return util.getline() == '[Trigger]' and 'conf'
	end,
	['cc'] = function()
		return (vim.g.cynlib_syntax_for_cc and 'cynlib') or 'cpp'
	end,
	['cpp'] = function()
		return (vim.g.cynlib_syntax_for_cc and 'cynlib') or 'cpp'
	end,
	['pro'] = function()
		return detect.proto() or 'idlang'
	end,
	['d'] = function()
		return detect.dtrace()
	end,
	['patch'] = function()
		return detect.patch()
	end,
	['rul'] = function()
		return (util.getlines_as_string(0, detect.line_limit):find('InstallShield') and 'ishd') or 'diva'
	end,
	['dsl'] = function()
		return (util.getline():find('^%s*<!') and 'dsl') or 'structurizr'
	end,
	['edn'] = function()
		return (util.getline():find('^%s*%(%s*edif') and 'edif') or 'clojure'
	end,
	['E'] = function()
		return detect.eiffel_check()
	end,
	['e'] = function()
		return detect.eiffel_check()
	end,
	['ent'] = function()
		return detect.eiffel_check()
	end,
	['ex'] = function()
		return detect.elixir_check()
	end,
	['EU'] = function()
		return (vim.g.filetype_euphoria and vim.g.filetype_euphoria) or 'euphoria3'
	end,
	['EW'] = function()
		return (vim.g.filetype_euphoria and vim.g.filetype_euphoria) or 'euphoria3'
	end,
	['EX'] = function()
		return (vim.g.filetype_euphoria and vim.g.filetype_euphoria) or 'euphoria3'
	end,
	['eu'] = function()
		return (vim.g.filetype_euphoria and vim.g.filetype_euphoria) or 'euphoria3'
	end,
	['ew'] = function()
		return (vim.g.filetype_euphoria and vim.g.filetype_euphoria) or 'euphoria3'
	end,
	['EXU'] = function()
		return (vim.g.filetype_euphoria and vim.g.filetype_euphoria) or 'euphoria3'
	end,
	['EXW'] = function()
		return (vim.g.filetype_euphoria and vim.g.filetype_euphoria) or 'euphoria3'
	end,
	['exu'] = function()
		return (vim.g.filetype_euphoria and vim.g.filetype_euphoria) or 'euphoria3'
	end,
	['exw'] = function()
		return (vim.g.filetype_euphoria and vim.g.filetype_euphoria) or 'euphoria3'
	end,
	['fs'] = function()
		return detect.fs()
	end,
	['fvwmrc'] = function()
		vim.b.fvwm_version = 1
		return 'fvwm'
	end,
	['fvwm2rc'] = function()
		vim.b.fvwm_version = 2
		return 'fvwm'
	end,
	['rules'] = function(args)
		return detect.rules(args.file_path)
	end,
	['pt'] = function()
		return detect.html()
	end,
	['cpt'] = function()
		return detect.html()
	end,
	['htm'] = function()
		return detect.html()
	end,
	['stm'] = function()
		return detect.html()
	end,
	['dtml'] = function()
		return detect.html()
	end,
	['html'] = function()
		return detect.html()
	end,
	['shtml'] = function()
		return detect.html()
	end,
	['idl'] = function()
		return detect.idl()
	end,
	['SRC'] = function()
		return detect.src()
	end,
	['SRc'] = function()
		return detect.src()
	end,
	['SrC'] = function()
		return detect.src()
	end,
	['Src'] = function()
		return detect.src()
	end,
	['sRC'] = function()
		return detect.src()
	end,
	['sRc'] = function()
		return detect.src()
	end,
	['srC'] = function()
		return detect.src()
	end,
	['src'] = function()
		return detect.src()
	end,
	['DAT'] = function()
		return detect.dat()
	end,
	['DAt'] = function()
		return detect.dat()
	end,
	['DaT'] = function()
		return detect.dat()
	end,
	['Dat'] = function()
		return detect.dat()
	end,
	['dAT'] = function()
		return detect.dat()
	end,
	['dAt'] = function()
		return detect.dat()
	end,
	['daT'] = function()
		return detect.dat()
	end,
	['dat'] = function()
		return detect.dat()
	end,
	['lsl'] = function()
		return detect.lsl()
	end,
	['mc'] = function()
		return detect.mc()
	end,
	['mms'] = function()
		return detect.mms()
	end,
	['smi'] = function()
		return (util.getline():find('smil') and 'smil') or 'mib'
	end,
	['m'] = function()
		return detect.m()
	end,
	['mp'] = function()
		vim.b.mp_metafun = 1
		return 'mp'
	end,
	['mpiv'] = function()
		vim.b.mp_metafun = 1
		return 'mp'
	end,
	['mpvi'] = function()
		vim.b.mp_metafun = 1
		return 'mp'
	end,
	['mpxl'] = function()
		vim.b.mp_metafun = 1
		return 'mp'
	end,
	['me'] = function(args)
		if args.file_name ~= 'read.me' and args.file_name ~= 'click.me' then
			return 'nroff'
		end
	end,
	['ms'] = function()
		return detect.nroff() or 'xmath'
	end,
	['mm'] = function()
		return detect.mm()
	end,
	['t'] = function(args)
		return detect.nroff() or detect.perl(args.file_path, args.file_ext) or 'tads'
	end,
	['pp'] = function()
		return detect.pp()
	end,
	['PL'] = function()
		return detect.pl()
	end,
	['pl'] = function()
		return detect.pl()
	end,
	['install'] = function()
		return (util.getline():find('%<%?php') and 'php') or detect.sh('bash')
	end,
	['hw'] = function()
		return (util.getline():find('%<%?php') and 'php') or 'virata'
	end,
	['pkg'] = function()
		return (util.getline():find('%<%?php') and 'php') or 'virata'
	end,
	['module'] = function()
		return (util.getline():find('%<%?php') and 'php') or 'virata'
	end,
	['w'] = function()
		return detect.progress_cweb()
	end,
	['i'] = function()
		return detect.progress_asm()
	end,
	['p'] = function()
		return detect.progress_pascal()
	end,
	['R'] = function()
		return detect.r()
	end,
	['r'] = function()
		return detect.r()
	end,
	['y'] = function()
		return detect.y()
	end,
	['MOD'] = function()
		return detect.mod()
	end,
	['MOd'] = function()
		return detect.mod()
	end,
	['MoD'] = function()
		return detect.mod()
	end,
	['Mod'] = function()
		return detect.mod()
	end,
	['mOD'] = function()
		return detect.mod()
	end,
	['mOd'] = function()
		return detect.mod()
	end,
	['moD'] = function()
		return detect.mod()
	end,
	['mod'] = function()
		return detect.mod()
	end,
	['PRG'] = function()
		return detect.prg()
	end,
	['PRg'] = function()
		return detect.prg()
	end,
	['PrG'] = function()
		return detect.prg()
	end,
	['Prg'] = function()
		return detect.prg()
	end,
	['pRG'] = function()
		return detect.prg()
	end,
	['pRg'] = function()
		return detect.prg()
	end,
	['prG'] = function()
		return detect.prg()
	end,
	['prg'] = function()
		return detect.prg()
	end,
	['reg'] = function()
		if util.getline():find('^REGEDIT[0-9]*%s*$|^Windows Registry Editor Version %d*%.%d*%s*$') then
			return 'registry'
		end
	end,
	['cmd'] = function()
		return (util.getline():find('^%/%*') and 'rexx') or 'dosbatch'
	end,
	['sc'] = function()
		return detect.sc()
	end,
	['scd'] = function()
		return detect.scd()
	end,
	['sgm'] = function()
		return detect.sgml()
	end,
	['sgml'] = function()
		return detect.sgml()
	end,
	['decl'] = function()
		return util.getlines_as_string(0, detect.line_limit, ' '):find('^%<%!SGML') and 'sgmldecl'
	end,
	['sil'] = function()
		return detect.sil()
	end,
	['sig'] = function()
		return detect.sig()
	end,
	['cls'] = function()
		if vim.g.filetype_cls then
			return vim.g.filetype_cls
		end

		local line = util.getline()
		if line == 'VERSION 1.0 CLASS' then
			return 'vb'
		end

		if line:find('^[%%\\]') then
			return 'tex'
		end

		if line:sub(1, 1) == '#' and line:find('rexx') then
			return detect.sh('rexx')
		end

		return 'st'
	end,
	['class'] = function()
		-- Decimal escape sequence
		-- The original was "^\xca\xfe\xba\xbe"
		if util.getline():find('^\x202\x254\x186\x190') then
			return 'stata'
		end
	end,
	['sql'] = function()
		return (vim.g.filetype_sql and vim.g.filetype_sql) or 'sql'
	end,
	['zsql'] = function()
		return (vim.g.filetype_sql and vim.g.filetype_sql) or 'sql'
	end,
	['SYS'] = function()
		return detect.sys()
	end,
	['SYs'] = function()
		return detect.sys()
	end,
	['SyS'] = function()
		return detect.sys()
	end,
	['Sys'] = function()
		return detect.sys()
	end,
	['sYS'] = function()
		return detect.sys()
	end,
	['sYs'] = function()
		return detect.sys()
	end,
	['syS'] = function()
		return detect.sys()
	end,
	['sys'] = function()
		return detect.sys()
	end,
	['tex'] = function(args)
		return detect.tex()
	end,
	['tf'] = function()
		return detect.tf()
	end,
	['ttl'] = function()
		local line = util.getline():lower()
		if line:find('^@?prefix') or line:find('^@?base') then
			return 'turtle'
		end
		return 'teraterm'
	end,
	['bi'] = function()
		return detect.vbasic()
	end,
	['bm'] = function()
		return detect.vbasic()
	end,
	['bas'] = function()
		return detect.vbasic()
	end,
	['frm'] = function()
		return detect.vbasic_form()
	end,
	['xbl'] = function()
		return detect.xml()
	end,
	['xml'] = function()
		return detect.xml()
	end,
	['docbk'] = function()
		return detect.xml()
	end,
	['smil'] = function()
		return (util.getline():find('<?%s*xml.*?>') and 'xml') or 'smil'
	end,
	['ts'] = function()
		return (util.getline():find('<%?xml') and 'xml') or 'typescript'
	end,
	['xpm'] = function()
		return (util.getline():find('XPM2') and 'xpm2') or 'xpm'
	end,
	['pm'] = function()
		local line = util.getline()
		return (line:find('XPM2') and 'xpm2') or (line:find('XPM') and 'xpm') or 'perl'
	end,
}

--- @type { [string]: filetype_mapping }
M.literals = {
	['a2psrc'] = 'a2ps',
	['.a2psrc'] = 'a2ps',
	['/etc/a2ps.cfg'] = 'a2ps',
	['.asoundrc'] = 'alsaconf',
	['/etc/asound.conf'] = 'alsaconf',
	['/usr/share/alsa/alsa.conf'] = 'alsaconf',
	['build.xml'] = 'ant',
	['.htaccess'] = 'apache',
	['apt.conf'] = 'aptconf',
	['/.aptitude/config'] = 'aptconf',
	['.arch-inventory'] = 'arch',
	['=tagging-method'] = 'arch',
	['Makefile.am'] = 'automake',
	['makefile.am'] = 'automake',
	['GNUmakefile.am'] = 'automake',
	['named.root'] = 'bindzone',
	['BUILD'] = 'bzl',
	['WORKSPACE'] = 'bzl',
	['WORKSPACE.bzlmod'] = 'bzl',
	['cabal.config'] = 'cabalconfig',
	['cabal.project'] = 'cabalproject',
	['calendar'] = 'calendar',
	['catalog'] = 'catalog',
	['.cdrdao'] = 'cdrdaoconf',
	['/etc/cdrdao.conf'] = 'cdrdaoconf',
	['/etc/default/cdrdao'] = 'cdrdaoconf',
	['/etc/defaults/cdrdao'] = 'cdrdaoconf',
	['cfengine.conf'] = 'cfengine',
	['hgrc'] = 'cfg',
	['cmake.in'] = 'cmake',
	['CMakeLists.txt'] = 'cmake',
	['auto.master'] = 'conf',
	['configure.ac'] = 'config',
	['configure.in'] = 'config',
	['mpv.conf'] = 'confini',
	['/etc/pacman.conf'] = 'confini',
	['crontab'] = 'crontab',
	['.cvsrc'] = 'cvsrc',
	['NEWS.dch'] = 'debchangelog',
	['NEWS.Debian'] = 'debchangelog',
	['changelog.dch'] = 'debchangelog',
	['changelog.Debian'] = 'debchangelog',
	['/debian/changelog'] = 'debchangelog',
	['/debian/control'] = 'debcontrol',
	['/debian/copyright'] = 'debcopyright',
	['/etc/apt/sources.list'] = 'debsources',
	['denyhosts.conf'] = 'denyhosts',
	['.dictrc'] = 'dictconf',
	['dict.conf'] = 'dictconf',
	['dictd.conf'] = 'dictdconf',
	['.dircolors'] = 'dircolors',
	['.dir_colors'] = 'dircolors',
	['/etc/DIR_COLORS'] = 'dircolors',
	['/etc/dnsmasq.conf'] = 'dnsmasq',
	['Dockerfile'] = 'dockerfile',
	['dockerfile'] = 'dockerfile',
	['Containerfile'] = 'dockerfile',
	['npmrc'] = 'dosini',
	['.npmrc'] = 'dosini',
	['/etc/yum.conf'] = 'dosini',
	['drc'] = 'dracula',
	['dune'] = 'dune',
	['jbuild'] = 'dune',
	['dune-project'] = 'dune',
	['dune-workspace'] = 'dune',
	['.editorconfig'] = 'editorconfig',
	['elinks.conf'] = 'elinks',
	['mix.lock'] = 'elixir',
	['filter-rules'] = 'elmfilt',
	['exim.conf'] = 'exim',
	['exports'] = 'exports',
	['.fetchmailrc'] = 'fetchmail',
	['mtab'] = 'fstab',
	['fstab'] = 'fstab',
	['gdbinit'] = 'gdb',
	['.gdbinit'] = 'gdb',
	['gdbearlyinit'] = 'gdb',
	['.gdbearlyinit'] = 'gdb',
	['lltxxxxx.txt'] = 'gedcom',
	['.gitattributes'] = 'gitattributes',
	['MERGE_MSG'] = 'gitcommit',
	['TAG_EDITMSG'] = 'gitcommit',
	['NOTES_EDITMSG'] = 'gitcommit',
	['COMMIT_EDITMSG'] = 'gitcommit',
	['EDIT_DESCRIPTION'] = 'gitcommit',
	['gitconfig'] = 'gitconfig',
	['.gitconfig'] = 'gitconfig',
	['.gitmodules'] = 'gitconfig',
	['/etc/gitconfig'] = 'gitconfig',
	['.gitignore'] = 'gitignore',
	['gitolite.conf'] = 'gitolite',
	['git-rebase-todo'] = 'gitrebase',
	['gkrellmrc'] = 'gkrellmrc',
	['gnashrc'] = 'gnash',
	['.gnashrc'] = 'gnash',
	['gnashpluginrc'] = 'gnash',
	['.gnashpluginrc'] = 'gnash',
	['.gnuplot'] = 'gnuplot',
	['go.mod'] = 'gomod',
	['go.sum'] = 'gosum',
	['go.work'] = 'gowork',
	['.gprc'] = 'gp',
	['/.gnupg/options'] = 'gpg',
	['/.gnupg/gpg.conf'] = 'gpg',
	['/etc/group'] = 'group',
	['/etc/group-'] = 'group',
	['/etc/gshadow'] = 'group',
	['/etc/gshadow-'] = 'group',
	['/etc/group.edit'] = 'group',
	['/etc/gshadow.edit'] = 'group',
	['/var/backups/group'] = 'group',
	['/var/backups/gshadow'] = 'group',
	['/etc/grub.conf'] = 'grub',
	['/boot/grub/menu.lst'] = 'grub',
	['/boot/grub/grub.conf'] = 'grub',
	['gtkrc'] = 'gtkrc',
	['.gtkrc'] = 'gtkrc',
	['hs-boot'] = 'haskell',
	['snort.conf'] = 'hog',
	['vision.conf'] = 'hog',
	['/etc/host.conf'] = 'hostconf',
	['/etc/hosts.deny'] = 'hostsaccess',
	['/etc/hosts.allow'] = 'hostsaccess',
	['html.m4'] = 'htmlm4',
	['/.icewm/menu'] = 'icemenu',
	['indentrc'] = 'indent',
	['.indent.pro'] = 'indent',
	['inittab'] = 'inittab',
	['ipf.conf'] = 'ipfilter',
	['ipf.rules'] = 'ipfilter',
	['ipf6.conf'] = 'ipfilter',
	['json-patch'] = 'json',
	['.firebaserc'] = 'json',
	['.prettierrc'] = 'json',
	['.stylelintrc'] = 'json',
	['Pipfile.lock'] = 'json',
	['.swrc'] = 'jsonc',
	['.hintrc'] = 'jsonc',
	['.babelrc'] = 'jsonc',
	['.jsfmtrc'] = 'jsonc',
	['.eslintrc'] = 'jsonc',
	['.jshintrc'] = 'jsonc',
	['Kconfig'] = 'kconfig',
	['Kconfig.debug'] = 'kconfig',
	['.lftprc'] = 'lftp',
	['lftp.conf'] = 'lftp',
	['/.libao'] = 'libao',
	['/etc/libao.conf'] = 'libao',
	['lilo.conf'] = 'lilo',
	['/etc/limits'] = 'limits',
	['.emacs'] = 'lisp',
	['sbclrc'] = 'lisp',
	['.sbclrc'] = 'lisp',
	['.sawfishrc'] = 'lisp',
	['/etc/login.access'] = 'loginaccess',
	['/etc/login.defs'] = 'logindefs',
	['.luacheckrc'] = 'lua',
	['lynx.cfg'] = 'lynx',
	['lrc'] = 'lyrics',
	['m3makefile'] = 'm3build',
	['m3overrides'] = 'm3build',
	['cm3.cfg'] = 'm3quake',
	['.letter'] = 'mail',
	['.article'] = 'mail',
	['.followup'] = 'mail',
	['/etc/aliases'] = 'mailaliases',
	['/etc/mail/aliases'] = 'mailaliases',
	['mailcap'] = 'mailcap',
	['.mailcap'] = 'mailcap',
	['man.config'] = 'manconf',
	['/etc/man.conf'] = 'manconf',
	['maxima-init.mac'] = 'maxima',
	['meson.build'] = 'meson',
	['meson_options.txt'] = 'meson',
	['/etc/modules'] = 'modconf',
	['/etc/conf.modules'] = 'modconf',
	['/etc/modules.conf'] = 'modconf',
	['mplayer.conf'] = 'mplayerconf',
	['/.mplayer/config'] = 'mplayerconf',
	['mrxvtrc'] = 'mrxvtrc',
	['.mrxvtrc'] = 'mrxvtrc',
	['Muttrc'] = 'muttrc',
	['Muttngrc'] = 'muttrc',
	['nanorc'] = 'nanorc',
	['/etc/nanorc'] = 'nanorc',
	['Neomuttrc'] = 'neomuttrc',
	['.netrc'] = 'netrc',
	['.ocamlinit'] = 'ocaml',
	['octaverc'] = 'octave',
	['.octaverc'] = 'octave',
	['octave.conf'] = 'octave',
	['opam'] = 'opam',
	['opam.template'] = 'opam',
	['org_archive'] = 'org',
	['/etc/pam.conf'] = 'pamconf',
	['pam_env.conf'] = 'pamenv',
	['.pam_environment'] = 'pamenv',
	['/etc/passwd'] = 'passwd',
	['/etc/shadow'] = 'passwd',
	['/etc/passwd-'] = 'passwd',
	['/etc/shadow-'] = 'passwd',
	['/etc/passwd.edit'] = 'passwd',
	['/etc/shadow.edit'] = 'passwd',
	['/var/backups/passwd'] = 'passwd',
	['/var/backups/shadow'] = 'passwd',
	['latexmkrc'] = 'perl',
	['.latexmkrc'] = 'perl',
	['pf.conf'] = 'pf',
	['main.cf'] = 'pfmain',
	['main.cf.proto'] = 'pfmain',
	['pinerc'] = 'pine',
	['.pinerc'] = 'pine',
	['pinercex'] = 'pine',
	['.pinercex'] = 'pine',
	['/.pinforc'] = 'pinfo',
	['/etc/pinforc'] = 'pinfo',
	['.povrayrc'] = 'povini',
	['.procmail'] = 'procmail',
	['.procmailrc'] = 'procmail',
	['/etc/protocols'] = 'protocols',
	['.pythonrc'] = 'python',
	['SConstruct'] = 'python',
	['.pythonstartup'] = 'python',
	['Rprofile'] = 'r',
	['.Rprofile'] = 'r',
	['Rprofile.site'] = 'r',
	['ratpoisonrc'] = 'ratpoison',
	['.ratpoisonrc'] = 'ratpoison',
	['inputrc'] = 'readline',
	['.inputrc'] = 'readline',
	['.reminders'] = 'remind',
	['resolv.conf'] = 'resolv',
	['robots.txt'] = 'robots',
	['irbrc'] = 'ruby',
	['.irbrc'] = 'ruby',
	['Gemfile'] = 'ruby',
	['Rakefile'] = 'ruby',
	['Rantfile'] = 'ruby',
	['rakefile'] = 'ruby',
	['rantfile'] = 'ruby',
	['Puppetfile'] = 'ruby',
	['Vagrantfile'] = 'ruby',
	['smb.conf'] = 'samba',
	['screenrc'] = 'screen',
	['.screenrc'] = 'screen',
	['/etc/sensors.conf'] = 'sensors',
	['/etc/sensors3.conf'] = 'sensors',
	['/etc/services'] = 'services',
	['/etc/serial.conf'] = 'setserial',
	['/etc/udev/cdsymlinks.conf'] = 'sh',
	['/etc/slp.conf'] = 'slpconf',
	['/etc/slp.reg'] = 'slpreg',
	['/etc/slp.spi'] = 'slpspi',
	['.slrnrc'] = 'slrnrc',
	['sendmail.cf'] = 'sm',
	['squid.conf'] = 'squid',
	['ssh_config'] = 'sshconfig',
	['sshd_config'] = 'sshdconfig',
	['sudoers.tmp'] = 'sudoers',
	['/etc/sudoers'] = 'sudoers',
	['swift.gyb'] = 'swiftgyb',
	['/etc/sysctl.conf'] = 'sysctl',
	['tags'] = 'tags',
	['undo.data'] = 'taskdata',
	['pending.data'] = 'taskdata',
	['completed.data'] = 'taskdata',
	['.wishrc'] = 'tcl',
	['.tclshrc'] = 'tcl',
	['tclsh.rc'] = 'tcl',
	['texmf.cnf'] = 'texmf',
	['README'] = 'text',
	['AUTHORS'] = 'text',
	['COPYING'] = 'text',
	['LICENSE'] = 'text',
	['tfrc'] = 'tf',
	['.tfrc'] = 'tf',
	['tidyrc'] = 'tidy',
	['.tidyrc'] = 'tidy',
	['tidy.conf'] = 'tidy',
	['t.html'] = 'tilde',
	['.tmux.conf'] = 'tmux',
	['Pipfile'] = 'toml',
	['Cargo.lock'] = 'toml',
	['Gopkg.lock'] = 'toml',
	['/.cargo/config'] = 'toml',
	['/.cargo/credentials'] = 'toml',
	['trustees.conf'] = 'trustees',
	['/etc/udev/udev.conf'] = 'udevconf',
	['/etc/updatedb.conf'] = 'updatedb',
	['fdrupstream.log'] = 'upstreamlog',
	['vgrindefs'] = 'vgrindefs',
	['.exrc'] = 'vim',
	['_exrc'] = 'vim',
	['.viminfo'] = 'viminfo',
	['_viminfo'] = 'viminfo',
	['wgetrc'] = 'wget',
	['.wgetrc'] = 'wget',
	['wget2rc'] = 'wget2',
	['.wget2rc'] = 'wget2',
	['.wvdialrc'] = 'wvdial',
	['wvdial.conf'] = 'wvdial',
	['.Xdefaults'] = 'xdefaults',
	['xdm-config'] = 'xdefaults',
	['.Xpdefaults'] = 'xdefaults',
	['.Xresources'] = 'xdefaults',
	['/etc/xinetd.conf'] = 'xinetd',
	['fglrxrc'] = 'xml',
	['/etc/blkid.tab'] = 'xml',
	['/etc/blkid.tab.old'] = 'xml',
	['.clang-tidy'] = 'yaml',
	['.clang-format'] = 'yaml',
	['_clang-format'] = 'yaml',
	['.zshrc'] = 'zsh',
	['.zlogin'] = 'zsh',
	['.zshenv'] = 'zsh',
	['.zlogout'] = 'zsh',
	['.zprofile'] = 'zsh',
	['.zcompdump'] = 'zsh',
	['.zfbfmarks'] = 'zsh',
	['/etc/zprofile'] = 'zsh',
	['.profile'] = function()
		return detect.sh('sh', true)
	end,
	['/etc/profile'] = function()
		return detect.sh('sh', true)
	end,
	['.d'] = function()
		return detect.sh('bash')
	end,
	['bashrc'] = function()
		return detect.sh('bash')
	end,
	['.bashrc'] = function()
		return detect.sh('bash')
	end,
	['APKBUILD'] = function()
		return detect.sh('bash')
	end,
	['PKGBUILD'] = function()
		return detect.sh('bash')
	end,
	['.bash-fc-'] = function()
		return detect.sh('bash')
	end,
	['.bash-fc_'] = function()
		return detect.sh('bash')
	end,
	['bash.bashrc'] = function()
		return detect.sh('bash')
	end,
	['.bash-logout'] = function()
		return detect.sh('bash')
	end,
	['.bash_logout'] = function()
		return detect.sh('bash')
	end,
	['.bash-aliases'] = function()
		return detect.sh('bash')
	end,
	['.bash-profile'] = function()
		return detect.sh('bash')
	end,
	['.bash_aliases'] = function()
		return detect.sh('bash')
	end,
	['.bash_profile'] = function()
		return detect.sh('bash')
	end,
	['.alias'] = function()
		return detect.csh()
	end,
	['.cshrc'] = function()
		return detect.csh()
	end,
	['.login'] = function()
		return detect.csh()
	end,
	['csh.cshrc'] = function()
		return detect.csh()
	end,
	['csh.login'] = function()
		return detect.csh()
	end,
	['csh.logout'] = function()
		return detect.csh()
	end,
	['.kshrc'] = function()
		return detect.sh('ksh')
	end,
	['.tcshrc'] = function()
		return detect.sh('tcsh')
	end,
	['tcsh.login'] = function()
		return detect.sh('tcsh')
	end,
	['tcsh.tcshrc'] = function()
		return detect.sh('tcsh')
	end,
	['NEWS'] = function()
		return (util.getline():find('%; urgency%=') and 'debchangelog') or 'changelog'
	end,
	['indent.pro'] = function()
		return detect.proto() or 'indent'
	end,
	['control'] = function()
		return util.getline():find('^Source%:') and 'debcontrol'
	end,
	['fvModels'] = function()
		return detect.foam()
	end,
	['fvSchemes'] = function()
		return detect.foam()
	end,
	['fvSolution'] = function()
		return detect.foam()
	end,
	['fvConstraints'] = function()
		return detect.foam()
	end,
	['fvwmrc'] = function()
		vim.b.fvwm_version = 1
		return 'fvwm'
	end,
	['fvwm2rc'] = function()
		vim.b.fvwm_version = 2
		return 'fvwm'
	end,
	['INFO'] = function()
		if
			util.findany(util.getline(), {
				'^%s*distribution%s*$',
				'^%s*installed_software%s*$',
				'^%s*root%s*$',
				'^%s*bundle%s*$',
				'^%s*product%s*$',
			})
		then
			return 'psf'
		end
	end,
	['INDEX'] = function()
		if
			util.findany(util.getline(), {
				'^%s*distribution%s*$',
				'^%s*installed_software%s*$',
				'^%s*root%s*$',
				'^%s*bundle%s*$',
				'^%s*product%s*$',
			})
		then
			return 'psf'
		end
	end,
	['printcap'] = function()
		vim.b.ptcap_type = 'print'
		return 'ptcap'
	end,
	['termcap'] = function()
		vim.b.ptcap_type = 'term'
		return 'ptcap'
	end,
	['xorg.conf'] = function()
		vim.b.xf86conf_xfree86_version = 4
		return 'xf86conf'
	end,
	['xorg.conf-4'] = function()
		vim.b.xf86conf_xfree86_version = 4
		return 'xf86conf'
	end,
	['XF86Config'] = function()
		if util.getline():find('XConfigurator') then
			vim.b.xf86conf_xfree86_version = 3
		end
		return 'xf86conf'
	end,
}

--- Cache table that stores if the pattern contains an en enviroment variable that must
--- be expanded
---
--- @type { [string]: boolean } A table of lua pattern mappings
M.contains_env_var = {
	['^${GNUPGHOME}/gpg%.conf$'] = true,
	['^${GNUPGHOME}/options$'] = true,
	['^${HOME}/cabal%.config$'] = true,
	['^${VIMRUNTIME}/doc/.*%.txt$'] = true,
	['^${XDG_CONFIG_HOME}/git/attributes$'] = true,
	['^${XDG_CONFIG_HOME}/git/config$'] = true,
	['^${XDG_CONFIG_HOME}/git/ignore$'] = true,
}

--- @type { [string]: filetype_mapping }
M.endswith = {
	['/debian/patches/series$'] = '',
	['/etc/a2ps%.cfg$'] = 'a2ps',
	['/etc/asound%.conf$'] = 'alsaconf',
	['/usr/share/alsa/alsa%.conf$'] = 'alsaconf',
	['/%.aptitude/config$'] = 'aptconf',
	['^${HOME}/cabal%.config$'] = 'cabalconfig',
	['/etc/cdrdao%.conf$'] = 'cdrdaoconf',
	['/etc/default/cdrdao$'] = 'cdrdaoconf',
	['/etc/defaults/cdrdao$'] = 'cdrdaoconf',
	['/%.?cmus/rc$'] = 'cmusrc',
	['/%.cmus/autosave$'] = 'cmusrc',
	['/%.cmus/command%-history$'] = 'cmusrc',
	['/%.aws/config$'] = 'confini',
	['/etc/pacman%.conf$'] = 'confini',
	['/%.aws/credentials$'] = 'confini',
	['/debian/changelog$'] = 'debchangelog',
	['/debian/control$'] = 'debcontrol',
	['/debian/copyright$'] = 'debcopyright',
	['/etc/apt/sources%.list$'] = 'debsources',
	['/etc/DIR_COLORS$'] = 'dircolors',
	['/etc/dnsmasq%.conf$'] = 'dnsmasq',
	['/etc/yum%.conf$'] = 'dosini',
	['/etc/gitattributes$'] = 'gitattributes',
	['%.git/info/attributes$'] = 'gitattributes',
	['/%.config/git/attributes$'] = 'gitattributes',
	['^${XDG_CONFIG_HOME}/git/attributes$'] = 'gitattributes',
	['%.git/config$'] = 'gitconfig',
	['/etc/gitconfig$'] = 'gitconfig',
	['%.git/modules/config$'] = 'gitconfig',
	['/%.config/git/config$'] = 'gitconfig',
	['%.git/config%.worktree$'] = 'gitconfig',
	['^${XDG_CONFIG_HOME}/git/config$'] = 'gitconfig',
	['%.git/info/exclude$'] = 'gitignore',
	['/%.config/git/ignore$'] = 'gitignore',
	['^${XDG_CONFIG_HOME}/git/ignore$'] = 'gitignore',
	['/%.gnupg/options$'] = 'gpg',
	['/%.gnupg/gpg.conf$'] = 'gpg',
	['/%.gnupg/gpg%.conf$'] = 'gpg',
	['^${GNUPGHOME}/options$'] = 'gpg',
	['^${GNUPGHOME}/gpg%.conf$'] = 'gpg',
	['/etc/group$'] = 'group',
	['/etc/group%-$'] = 'group',
	['/etc/gshadow$'] = 'group',
	['/etc/gshadow%-$'] = 'group',
	['/etc/group%.edit$'] = 'group',
	['/etc/gshadow%.edit$'] = 'group',
	['/var/backups/group$'] = 'group',
	['/var/backups/gshadow$'] = 'group',
	['/etc/grub%.conf$'] = 'grub',
	['/boot/grub/menu%.lst$'] = 'grub',
	['/boot/grub/grub%.conf$'] = 'grub',
	['/etc/host%.conf$'] = 'hostconf',
	['/etc/hosts%.deny$'] = 'hostsaccess',
	['/etc/hosts%.allow$'] = 'hostsaccess',
	['/i3/config$'] = 'i3config',
	['/%.i3/config$'] = 'i3config',
	['/%.icewm/menu$'] = 'icemenu',
	['lftp/rc$'] = 'lftp',
	['/%.libao$'] = 'libao',
	['/etc/libao%.conf$'] = 'libao',
	['/etc/limits$'] = 'limits',
	['/etc/login%.access$'] = 'loginaccess',
	['/etc/login%.defs$'] = 'logindefs',
	['^/tmp/SLRN[0-9A-Z.]+$'] = 'mail',
	['/etc/aliases$'] = 'mailaliases',
	['/etc/mail/aliases$'] = 'mailaliases',
	['/etc/man%.conf$'] = 'manconf',
	['/log/lpr$'] = 'messages',
	['/log/auth$'] = 'messages',
	['/log/cron$'] = 'messages',
	['/log/kern$'] = 'messages',
	['/log/mail$'] = 'messages',
	['/log/user$'] = 'messages',
	['/log/debug$'] = 'messages',
	['/log/daemon$'] = 'messages',
	['/log/syslog$'] = 'messages',
	['/log/lpr%.err$'] = 'messages',
	['/log/lpr%.log$'] = 'messages',
	['/log/messages$'] = 'messages',
	['/log/auth%.err$'] = 'messages',
	['/log/auth%.log$'] = 'messages',
	['/log/cron%.err$'] = 'messages',
	['/log/cron%.log$'] = 'messages',
	['/log/kern%.err$'] = 'messages',
	['/log/kern%.log$'] = 'messages',
	['/log/lpr%.crit$'] = 'messages',
	['/log/lpr%.info$'] = 'messages',
	['/log/lpr%.warn$'] = 'messages',
	['/log/mail%.err$'] = 'messages',
	['/log/mail%.log$'] = 'messages',
	['/log/news/news$'] = 'messages',
	['/log/user%.err$'] = 'messages',
	['/log/user%.log$'] = 'messages',
	['/log/auth%.crit$'] = 'messages',
	['/log/auth%.info$'] = 'messages',
	['/log/auth%.warn$'] = 'messages',
	['/log/cron%.crit$'] = 'messages',
	['/log/cron%.info$'] = 'messages',
	['/log/cron%.warn$'] = 'messages',
	['/log/debug%.err$'] = 'messages',
	['/log/debug%.log$'] = 'messages',
	['/log/kern%.crit$'] = 'messages',
	['/log/kern%.info$'] = 'messages',
	['/log/kern%.warn$'] = 'messages',
	['/log/mail%.crit$'] = 'messages',
	['/log/mail%.info$'] = 'messages',
	['/log/mail%.warn$'] = 'messages',
	['/log/user%.crit$'] = 'messages',
	['/log/user%.info$'] = 'messages',
	['/log/user%.warn$'] = 'messages',
	['/log/daemon%.err$'] = 'messages',
	['/log/daemon%.log$'] = 'messages',
	['/log/debug%.crit$'] = 'messages',
	['/log/debug%.info$'] = 'messages',
	['/log/debug%.warn$'] = 'messages',
	['/log/lpr%.notice$'] = 'messages',
	['/log/syslog%.err$'] = 'messages',
	['/log/syslog%.log$'] = 'messages',
	['/log/auth%.notice$'] = 'messages',
	['/log/cron%.notice$'] = 'messages',
	['/log/daemon%.crit$'] = 'messages',
	['/log/daemon%.info$'] = 'messages',
	['/log/daemon%.warn$'] = 'messages',
	['/log/kern%.notice$'] = 'messages',
	['/log/mail%.notice$'] = 'messages',
	['/log/syslog%.crit$'] = 'messages',
	['/log/syslog%.info$'] = 'messages',
	['/log/syslog%.warn$'] = 'messages',
	['/log/user%.notice$'] = 'messages',
	['/log/debug%.notice$'] = 'messages',
	['/log/messages%.err$'] = 'messages',
	['/log/messages%.log$'] = 'messages',
	['/log/daemon%.notice$'] = 'messages',
	['/log/messages%.crit$'] = 'messages',
	['/log/messages%.info$'] = 'messages',
	['/log/messages%.warn$'] = 'messages',
	['/log/news/news%.err$'] = 'messages',
	['/log/news/news%.log$'] = 'messages',
	['/log/syslog%.notice$'] = 'messages',
	['/log/news/news%.crit$'] = 'messages',
	['/log/news/news%.info$'] = 'messages',
	['/log/news/news%.warn$'] = 'messages',
	['/log/messages%.notice$'] = 'messages',
	['/log/news/news%.notice$'] = 'messages',
	['/etc/modules$'] = 'modconf',
	['/etc/conf%.modules$'] = 'modconf',
	['/etc/modules%.conf$'] = 'modconf',
	['/%.mplayer/config$'] = 'mplayerconf',
	['/etc/nanorc$'] = 'nanorc',
	['/etc/pam%.conf$'] = 'pamconf',
	['/etc/passwd$'] = 'passwd',
	['/etc/shadow$'] = 'passwd',
	['/etc/passwd%-$'] = 'passwd',
	['/etc/shadow%-$'] = 'passwd',
	['/etc/passwd%.edit$'] = 'passwd',
	['/etc/shadow%.edit$'] = 'passwd',
	['/var/backups/passwd$'] = 'passwd',
	['/var/backups/shadow$'] = 'passwd',
	['/%.pinforc$'] = 'pinfo',
	['/etc/pinforc$'] = 'pinfo',
	['/etc/protocols$'] = 'protocols',
	['/etc/sensors%.conf$'] = 'sensors',
	['/etc/sensors3%.conf$'] = 'sensors',
	['/etc/services$'] = 'services',
	['/etc/serial%.conf$'] = 'setserial',
	['/etc/udev/cdsymlinks%.conf$'] = 'sh',
	['/etc/slp%.conf$'] = 'slpconf',
	['/etc/slp%.reg$'] = 'slpreg',
	['/etc/slp%.spi$'] = 'slpspi',
	['/%.ssh/config$'] = 'sshconfig',
	['/etc/sudoers$'] = 'sudoers',
	['/sway/config$'] = 'swayconfig',
	['/%.sway/config$'] = 'swayconfig',
	['/etc/sysctl%.conf$'] = 'sysctl',
	['/%.cargo/config$'] = 'toml',
	['/%.cargo/credentials$'] = 'toml',
	['/etc/udev/udev%.conf$'] = 'udevconf',
	['/etc/updatedb%.conf$'] = 'updatedb',
	['/etc/xinetd%.conf$'] = 'xinetd',
	['/etc/blkid%.tab$'] = 'xml',
	['/etc/blkid%.tab.old$'] = 'xml',
	['/etc/blkid%.tab%.old$'] = 'xml',
	['/etc/zprofile$'] = 'zsh',
	['/etc/profile$'] = function()
		return detect.sh('sh', true)
	end,
}

--- @type { [string]: filetype_mapping }
M.fendswith = {
	['hgrc$'] = 'cfg',
	['%.%.ch$'] = 'chill',
	['%.cmake%.in$'] = 'cmake',
	['%.desktop$'] = 'desktop',
	['%.directory$'] = 'desktop',
	['lpe$'] = 'dracula',
	['lvs$'] = 'dracula',
	['esmtprc$'] = 'esmtprc',
	['^%.gitsendemail%.msg%.......$'] = 'gitsendemail',
	['^gkrellmrc_.$'] = 'gkrellmrc',
	['%.html%.m4$'] = 'htmlm4',
	['%.properties_..$'] = 'jproperties',
	['%.properties_.._..$'] = 'jproperties',
	['^snd%.%d+$'] = 'mail',
	['^pico%.%d+$'] = 'mail',
	['^ae%d+%.txt$'] = 'mail',
	['^%.letter%.%d+$'] = 'mail',
	['^%.article%.%d+$'] = 'mail',
	['^mutt[%w_-][%w_-][%w_-][%w_-][%w_-][%w_-]$'] = 'mail',
	['^neomutt[%w_-][%w_-][%w_-][%w_-][%w_-][%w_-]$'] = 'mail',
	['[mM]akefile$'] = 'make',
	['%.NS[ACGLMNPS]$'] = 'natural',
	['nginx%.conf$'] = 'nginx',
	['%.ml%.cppo$'] = 'ocaml',
	['%.mli%.cppo$'] = 'ocaml',
	['%.mli?%.cppo$'] = 'ocaml',
	['%.opam%.template$'] = 'opam',
	['^%.?gitolite%.rc$'] = 'perl',
	['^example%.gitolite%.rc$'] = 'perl',
	[',v$'] = 'rcs',
	['%.[_%-]?sst%.meta$'] = 'sisu',
	['%.swift%.gyb$'] = 'swiftgyb',
	['%.t%.html$'] = 'tilde',
	['%.csproj%.user$'] = 'xml',
	['%.fsproj%.user$'] = 'xml',
	['%.vbproj%.user$'] = 'xml',
	['Xmodmap$'] = 'xmodmap',
	['fvwmrc$'] = function()
		vim.b.fvwm_version = 1
		return 'fvwm'
	end,
	['fvwm95%.hook$'] = function()
		vim.b.fvwm_version = 1
		return 'fvwm'
	end,
	['fvwm2rc$'] = function()
		vim.b.fvwm_version = 2
		return 'fvwm'
	end,
}

--- @type { [string]: filetype_mapping }
M.complex = {
	['/etc/a2ps/.*%.cfg$'] = 'a2ps',
	['/etc/httpd/.*%.conf$'] = 'apache',
	['/etc/apache2/sites%-.*/.*%.com$'] = 'apache',
	['/meta/conf/.*%.conf$'] = 'bitbake',
	['/build/conf/.*%.conf$'] = 'bitbake',
	['/meta%-.*/conf/.*%.conf$'] = 'bitbake',
	['enlightenment/.*%.cfg$'] = 'c',
	['/%.?cmus/.*%.theme$'] = 'cmusrc',
	['/etc/ufw/.*%.rules'] = 'conf',
	['/tex/context/.*%.tex$'] = 'context',
	['/etc/apt/sources%.list%.d/.*%.list$'] = 'debsources',
	['/dtrace/.*%.d$'] = 'dtrace',
	['Eterm/.*%.cfg$'] = 'eterm',
	['git/config$'] = 'gitconfig',
	['%.git/modules/.*/config$'] = 'gitconfig',
	['%.git/worktrees/.*/config%.worktree$'] = 'gitconfig',
	['/usr/.*/gnupg/options%.skel$'] = 'gpg',
	['^${VIMRUNTIME}/doc/.*%.txt$'] = 'help',
	['/etc/initng/.*/.*%.i$'] = 'initng',
	['/etc/polkit%-1/rules%.d/.*%.rules'] = 'javascript',
	['/usr/share/polkit%-1/rules%.d/.*%.rules'] = 'javascript',
	['/etc/.*limits%.conf$'] = 'limits',
	['/etc/.*limits%.d/.*%.conf$'] = 'limits',
	['/LiteStep/.*/.*%.rc$'] = 'litestep',
	['/nginx/.*%.conf$'] = 'nginx',
	['/openvpn/.*/.*%.conf$'] = 'openvpn',
	['id1/.*%.cfg$'] = 'quake',
	['baseq[2-3]/.*%.cfg$'] = 'quake',
	['quake[1-3]/.*%.cfg$'] = 'quake',
	['/queries/.*%.scm$'] = 'query',
	['/%.ssh/.*%.conf$'] = 'sshconfig',
	['/etc/ssh/ssh_config%.d/.*%.conf$'] = 'sshconfig',
	['/etc/ssh/sshd_config%.d/.*%.conf$'] = 'sshdconfig',
	['/etc/sysctl%.d/.*%.conf$'] = 'sysctl',
	['/systemd/.*%.link$'] = 'systemd',
	['/systemd/.*%.path$'] = 'systemd',
	['/systemd/.*%.swap$'] = 'systemd',
	['/systemd/.*%.dnssd$'] = 'systemd',
	['/systemd/.*%.mount$'] = 'systemd',
	['/systemd/.*%.slice$'] = 'systemd',
	['/systemd/.*%.timer$'] = 'systemd',
	['/systemd/.*%.netdev$'] = 'systemd',
	['/systemd/.*%.nspawn$'] = 'systemd',
	['/systemd/.*%.socket$'] = 'systemd',
	['/systemd/.*%.target$'] = 'systemd',
	['/systemd/.*%.network$'] = 'systemd',
	['/systemd/.*%.service$'] = 'systemd',
	['/systemd/.*%.automount$'] = 'systemd',
	['/etc/systemd/.*%.conf%.d/.*%.conf$'] = 'systemd',
	['/etc/systemd/system/.*%.d/.*%.conf$'] = 'systemd',
	['/%.config/systemd/user/.*%.d/.*%.conf$'] = 'systemd',
	['/etc/udev/permissions%.d/.*%.permissions$'] = 'udevperm',
	['/etc/udev/.*%.rules$'] = 'udevrules',
	['/lib/udev/.*%.rules$'] = 'udevrules',
	['/%.init/.*%.conf$'] = 'upstart',
	['/etc/init/.*%.conf$'] = 'upstart',
	['/%.init/.*%.override$'] = 'upstart',
	['/etc/init/.*%.override$'] = 'upstart',
	['/%.config/upstart/.*%.conf$'] = 'upstart',
	['/usr/share/upstart/.*%.conf$'] = 'upstart',
	['/%.config/upstart/.*%.override$'] = 'upstart',
	['/usr/share/upstart/.*%.override$'] = 'upstart',
	['/etc/xdg/menus/.*%.menu$'] = 'xml',
	['/constant/g$'] = function()
		return detect.foam()
	end,
	['/xorg%.conf%.d/.*%.conf$'] = function()
		vim.b.xf86conf_xfree86_version = 4
		return 'xf86conf'
	end,
}

--- @type { [string]: filetype_mapping }
M.fcomplex = {
	['^dictd.*%.conf$'] = 'dictdconf',
	['^hg%-editor%-.*%.txt$'] = 'hgcommit',
	['^org%.eclipse%..*%.prefs$'] = 'jproperties',
	['^[jt]sconfig.*%.json$'] = 'jsonc',
	['^mutt%-.*%-%w+$'] = 'mail',
	['^muttng%-.*%-%w+$'] = 'mail',
	['^neomutt%-.*%-%w+$'] = 'mail',
	['^rndc.*%.key$'] = 'named',
	['^rndc.*%.conf$'] = 'named',
	['^named.*%.conf$'] = 'named',
	['^nginx.*%.conf$'] = 'nginx',
	['^svn%-commit.*%.tmp$'] = 'svn',
	['^%.tmux.*%.conf$'] = 'tmux',
	['^%.?tmux.*%.conf$'] = 'tmux',
	['%.?[uU][pP][sS][tT][rR][eE][aA][mM]%.[dD][aA][tT]$'] = 'upstreamdat',
	['[uU][pP][sS][tT][rR][eE][aA][mM]%..*%.[dD][aA][tT]$'] = 'upstreamdat',
	['%.?[uU][pP][sS][tT][rR][eE][aA][mM][iI][nN][sS][tT][aA][lL][lL]%.[lL][oO][gG]$'] = 'upstreaminstalllog',
	['[uU][pP][sS][tT][rR][eE][aA][mM][iI][nN][sS][tT][aA][lL][lL]%..*%.[lL][oO][gG]$'] = 'upstreaminstalllog',
	['%.?[uU][pP][sS][tT][rR][eE][aA][mM]%.[lL][oO][gG]$'] = 'upstreamlog',
	['[uU][pP][sS][tT][rR][eE][aA][mM]%-.*%.[lL][oO][gG]$'] = 'upstreamlog',
	['[uU][pP][sS][tT][rR][eE][aA][mM]%..*%.[lL][oO][gG]$'] = 'upstreamlog',
	['%.?[uU][sS][sS][eE][rR][vV][eE][rR]%.[lL][oO][gG]$'] = 'usserverlog',
	['[uU][sS][sS][eE][rR][vV][eE][rR]%..*%.[lL][oO][gG]$'] = 'usserverlog',
	['%.?[uU][sS][wW]2[kK][aA][gG][tT]%.[lL][oO][gG]$'] = 'usw2kagtlog',
	['[uU][sS][wW]2[kK][aA][gG][tT]%..*%.[lL][oO][gG]$'] = 'usw2kagtlog',
	['^[a-zA-Z0-9].*Dict$'] = function()
		return detect.foam()
	end,
	['^[a-zA-Z].*Properties$'] = function()
		return detect.foam()
	end,
	['fvwm2rc.*%.m4$'] = function()
		return 'fvwm2m4'
	end,
}

--- @type { [string]: filetype_mapping }
M.starsets = {
	['/etc/httpd/conf%..*/'] = 'apache',
	['/etc/httpd/mods%-.*/'] = 'apache',
	['/etc/apache2/.*%.conf'] = 'apache',
	['/etc/apache2/mods-.*/'] = 'apache',
	['/etc/httpd/sites%-.*/'] = 'apache',
	['/etc/apache2/conf%..*/'] = 'apache',
	['/etc/apache2/mods%-.*/'] = 'apache',
	['/etc/apache2/sites-.*/'] = 'apache',
	['/etc/apache2/sites%-.*/'] = 'apache',
	['/etc/httpd/conf%.d/.*%.conf'] = 'apache',
	['/etc/proftpd/.*%.conf'] = 'apachestyle',
	['/etc/proftpd/conf%..*/'] = 'apachestyle',
	['asterisk/.*%.conf'] = 'asterisk',
	['asterisk.*/.*voicemail%.conf'] = 'asteriskvm',
	['/bind/db%.'] = 'bindzone',
	['/named/db%.'] = 'bindzone',
	['/%.calendar/'] = 'calendar',
	['/share/calendar/calendar%.'] = 'calendar',
	['/share/calendar/.*/calendar%.'] = 'calendar',
	['/etc/hostname%.'] = 'config',
	['/etc/cron%.d/'] = 'crontab',
	['/etc/dnsmasq%.d/'] = 'dnsmasq',
	['/etc/yum%.repos%.d/'] = 'dosini',
	['/tmp/lltmp'] = 'gedcom',
	['/%.gitconfig%.d/'] = 'gitconfig',
	['/etc/gitconfig%.d/'] = 'gitconfig',
	['/gitolite-admin/conf/'] = 'gitolite',
	['/gitolite%-admin/conf/'] = 'gitolite',
	['/etc/logcheck/.*%.d.*/'] = 'logcheck',
	['/etc/modprobe%.'] = 'modconf',
	['/%.mutt/muttrc'] = 'muttrc',
	['/etc/Muttrc%.d/'] = 'muttrc',
	['/%.muttng/muttrc'] = 'muttrc',
	['/%.muttng/muttngrc'] = 'muttrc',
	['/%.neomutt/neomuttrc'] = 'neomuttrc',
	['/etc/nginx/'] = 'nginx',
	['/usr/local/nginx/conf/'] = 'nginx',
	['/etc/pam%.d/'] = 'pamconf',
	['/etc/sensors%.d/[^.]'] = 'sensors',
	['/etc/sudoers%.d/'] = 'sudoers',
	['/etc/systemd/system/%.#'] = 'systemd',
	['/%.config/systemd/user/%.#'] = 'systemd',
	['/etc/systemd/system/.*%.d/%.#'] = 'systemd',
	['/%.config/systemd/user/.*%.d/%.#'] = 'systemd',
	['/Xresources/'] = 'xdefaults',
	['/app-defaults/'] = 'xdefaults',
	['/app%-defaults/'] = 'xdefaults',
	['/etc/xinetd%.d/'] = 'xinetd',
	['/debian/patches/'] = function()
		return detect.dep3patch()
	end,
	['/0/'] = function()
		return detect.foam()
	end,
	['/0%.orig/'] = function()
		return detect.foam()
	end,
	['/%.fvwm/'] = function()
		vim.b.fvwm_version = 1
		return 'fvwm'
	end,
	['%.git/'] = function()
		local line = util.getline()
		if util.match_vim_regex(line, [[^\x\{40,\}\>\|^ref: ]]) then
			return 'git'
		end
	end,
}

--- @type { [string]: filetype_mapping }
M.fstarsets = {
	['^srm%.conf'] = 'apache',
	['^httpd%.conf'] = 'apache',
	['^access%.conf'] = 'apache',
	['^apache%.conf'] = 'apache',
	['^apache2%.conf'] = 'apache',
	['^proftpd%.conf'] = 'apachestyle',
	['^bzr_log%.'] = 'bzr',
	['^cabal%.project%.'] = 'cabalproject',
	['^sgml%.catalog'] = 'catalog',
	['^crontab%.'] = 'crontab',
	['^cvs%d+$'] = 'cvs',
	['^Dockerfile%.'] = 'dockerfile',
	['^Containerfile%.'] = 'dockerfile',
	['^php%.ini%-'] = 'dosini',
	['^drac%.'] = 'dracula',
	['^%.?gtkrc'] = 'gtkrc',
	['^JAM.*%.'] = 'jam',
	['^Prl.*%.'] = 'jam',
	['%.properties_.._.._'] = 'jproperties',
	['%.properties_??_??_'] = 'jproperties',
	['^Kconfig%.'] = 'kconfig',
	['^lilo%.conf'] = 'lilo',
	['^reportbug-'] = 'mail',
	['^reportbug%-'] = 'mail',
	['^[mM]akefile'] = 'make',
	['^Muttrc'] = 'muttrc',
	['^Muttngrc'] = 'muttrc',
	['^%.?muttrc'] = 'muttrc',
	['^%.?muttngrc'] = 'muttrc',
	['^Neomuttrc'] = 'neomuttrc',
	['^%.?neomuttrc'] = 'neomuttrc',
	['^tmac%.'] = 'nroff',
	['^%.reminders'] = 'remind',
	['^[rR]akefile'] = 'ruby',
	['^%.?tmux.*%.conf'] = 'tmux',
	['%.vhdl_[0-9]'] = 'vhdl',
	['vimrc'] = 'vim',
	['^Xresources'] = 'xdefaults',
	['xmodmap'] = 'xmodmap',
	['^%.?zsh'] = 'zsh',
	['^%.?zlog'] = 'zsh',
	['^%.?zcompdump'] = 'zsh',
	['^%.profile'] = function()
		return detect.sh('sh', true)
	end,
	['^%.bashrc'] = function()
		return detect.sh('bash')
	end,
	['^APKBUILD'] = function()
		return detect.sh('bash')
	end,
	['^PKGBUILD'] = function()
		return detect.sh('bash')
	end,
	['^%.cshrc'] = function()
		return detect.csh()
	end,
	['^%.login'] = function()
		return detect.csh()
	end,
	['^%.kshrc'] = function()
		return detect.sh('ksh')
	end,
	['^%.tcshrc'] = function()
		return detect.sh('tcsh')
	end,
	['^[cC]hange[lL]og'] = function()
		return (util.getline():find('%; urgency%=') and 'debchangelog') or 'changelog'
	end,
	['Transport%.'] = function()
		return detect.foam()
	end,
	['^[a-zA-Z0-9].*Dict%.'] = function()
		return detect.foam()
	end,
	['^[a-zA-Z].*Properties%.'] = function()
		return detect.foam()
	end,
	['fvwmrc'] = function()
		vim.b.fvwm_version = 1
		return 'fvwm'
	end,
	['fvwm2rc'] = function()
		vim.b.fvwm_version = 2
		return 'fvwm'
	end,
	['printcap'] = function()
		vim.b.ptcap_type = 'print'
		return 'ptcap'
	end,
	['termcap'] = function()
		vim.b.ptcap_type = 'term'
		return 'ptcap'
	end,
	['%.[cC][fF][gG]$'] = function()
		return detect.cfg()
	end,
}

return M