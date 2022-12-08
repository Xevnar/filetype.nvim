--- @module 'filetype.util'
local util = require('filetype.util')

--- @module 'filetype.detect'
local detect = require('filetype.detect')

--- @type { [string]: filetype_mapping }
local extensions = {
	['4gh'] = 'fgl',
	['4gl'] = 'fgl',
	['8th'] = '8th',
	['ACE'] = 'lace',
	['BUILD'] = 'bzl',
	['C'] = 'cpp',
	['DEF'] = 'modula2',
	['Dockerfile'] = 'dockerfile',
	['EC'] = 'esqlc',
	['F'] = 'fortran',
	['F03'] = 'fortran',
	['F08'] = 'fortran',
	['F77'] = 'fortran',
	['F90'] = 'fortran',
	['F95'] = 'fortran',
	['FOR'] = 'fortran',
	['FPP'] = 'fortran',
	['FTN'] = 'fortran',
	['H'] = 'cpp',
	['INF'] = 'inform',
	['JAL'] = 'jal',
	['L'] = 'lisp',
	['MOD'] = 'modula2',
	['Rd'] = 'rhelp',
	['Rmd'] = 'rmd',
	['Rnw'] = 'rnoweb',
	['Rrst'] = 'rrst',
	['Smd'] = 'rmd',
	['Snw'] = 'rnoweb',
	['Srst'] = 'rrst',
	['a65'] = 'a65',
	['aap'] = 'aap',
	['abap'] = 'abap',
	['abc'] = 'abc',
	['abl'] = 'abel',
	['ace'] = 'lace',
	['action'] = 'privoxy',
	['ada'] = 'ada',
	['adb'] = 'ada',
	['ado'] = 'stata',
	['adoc'] = 'asciidoc',
	['ads'] = 'ada',
	['afm'] = 'postscr',
	['ahk'] = 'autohotkey',
	['ai'] = 'postscr',
	['aidl'] = 'aidl',
	['al'] = 'perl',
	['aml'] = 'aml',
	['art'] = 'art',
	['as'] = 'atlas',
	['asciidoc'] = 'asciidoc',
	['asn'] = 'asn',
	['asn1'] = 'asn',
	['at'] = 'm4',
	['atg'] = 'coco',
	['atl'] = 'atlas',
	['atom'] = 'xml',
	['au3'] = 'autoit',
	['ave'] = 'ave',
	['awk'] = 'awk',
	['bat'] = 'dosbatch',
	['bbl'] = 'tex',
	['bc'] = 'bc',
	['bdf'] = 'bdf',
	['beancount'] = 'beancount',
	['bi'] = 'freebasic',
	['bib'] = 'bib',
	['bl'] = 'blank',
	['bsdl'] = 'bsdl',
	['bst'] = 'bst',
	['bu'] = 'yaml',
	['builder'] = 'ruby',
	['c++'] = 'cpp',
	['cabal'] = 'cabal',
	['cbl'] = 'cobol',
	['cdf'] = 'skill',
	['cdl'] = 'cdl',
	['cdxml'] = 'xml',
	['cfc'] = 'cf',
	['cfi'] = 'cf',
	['cfm'] = 'cf',
	['chf'] = 'ch',
	['cho'] = 'chordpro',
	['chopro'] = 'chordpro',
	['chordpro'] = 'chordpro',
	['chs'] = 'chaskell',
	['cjs'] = 'javascript',
	['cl'] = 'lisp',
	['clj'] = 'clojure',
	['cljc'] = 'clojure',
	['cljs'] = 'clojure',
	['cljx'] = 'clojure',
	['clp'] = 'jess',
	['cm'] = 'voscm',
	['cmake'] = 'cmake',
	['cmake.in'] = 'cmake',
	['cmod'] = 'cmod',
	['cob'] = 'cobol',
	['comp'] = 'mason',
	['con'] = 'cterm',
	['crd'] = 'chordpro',
	['crdpro'] = 'chordpro',
	['crm'] = 'crm',
	['cs'] = 'cs',
	['csc'] = 'csc',
	['csdl'] = 'csdl',
	['csp'] = 'csp',
	['csproj'] = 'xml',
	['csproj.user'] = 'xml',
	['css'] = 'css',
	['ctl'] = 'vb',
	['cu'] = 'cuda',
	['cuh'] = 'cuda',
	['cxx'] = 'cpp',
	['cyn'] = 'cynpp',
	['dart'] = 'dart',
	['dcd'] = 'dcd',
	['dcl'] = 'clean',
	['def'] = 'def',
	['desc'] = 'desc',
	['desktop'] = 'desktop',
	['diff'] = 'diff',
	['directory'] = 'desktop',
	['do'] = 'stata',
	['dot'] = 'dot',
	['dpr'] = 'pascal',
	['drac'] = 'dracula',
	['drc'] = 'dracula',
	['ds'] = 'datascript',
	['dsm'] = 'vb',
	['dtd'] = 'dtd',
	['dts'] = 'dts',
	['dtsi'] = 'dts',
	['dtx'] = 'tex',
	['dylan'] = 'dylan',
	['ec'] = 'esqlc',
	['ecd'] = 'ecd',
	['el'] = 'lisp',
	['elm'] = 'elm',
	['eni'] = 'cl',
	['epp'] = 'epuppet',
	['eps'] = 'postscr',
	['epsf'] = 'postscr',
	['epsi'] = 'postscr',
	['erb'] = 'eruby',
	['erl'] = 'erlang',
	['errsum'] = 'hercules',
	['es'] = 'javascript',
	['ev'] = 'hercules',
	['exp'] = 'expect',
	['exs'] = 'elixir',
	['f'] = 'fortran',
	['f03'] = 'fortran',
	['f08'] = 'fortran',
	['f77'] = 'fortran',
	['f90'] = 'fortran',
	['f95'] = 'fortran',
	['factor'] = 'factor',
	['fal'] = 'falcon',
	['fan'] = 'fan',
	['fb'] = 'freebasic',
	['fdr'] = 'csp',
	['feature'] = 'cucumber',
	['fex'] = 'focexec',
	['fnl'] = 'fennel',
	['focexec'] = 'focexec',
	['for'] = 'fortran',
	['fortran'] = 'fortran',
	['fpc'] = 'fpcmake',
	['fpp'] = 'fortran',
	['frt'] = 'reva',
	['fsl'] = 'framescript',
	['ft'] = 'forth',
	['fth'] = 'forth',
	['ftn'] = 'fortran',
	['fwt'] = 'fan',
	['g'] = 'pccts',
	['gawk'] = 'awk',
	['gdmo'] = 'gdmo',
	['ged'] = 'gedcom',
	['gemspec'] = 'ruby',
	['go'] = 'go',
	['gp'] = 'gp',
	['gpi'] = 'gnuplot',
	['gpr'] = 'ada',
	['gql'] = 'graphql',
	['gradle'] = 'groovy',
	['graphql'] = 'graphql',
	['gretl'] = 'gretl',
	['groovy'] = 'groovy',
	['gs'] = 'grads',
	['gsp'] = 'gsp',
	['gv'] = 'dot',
	['h32'] = 'hex',
	['haml'] = 'haml',
	['hs'] = 'haskell',
	['hsc'] = 'haskell',
	['hs-boot'] = 'haskell',
	['hsig'] = 'haskell',
	['hb'] = 'hb',
	['hdl'] = 'vhdl',
	['hex'] = 'hex',
	['hgrc'] = 'cfg',
	['hh'] = 'cpp',
	['hlp'] = 'smcl',
	['hog'] = 'hog',
	['hpp'] = 'cpp',
	['hrl'] = 'erlang',
	['hsm'] = 'hamster',
	['ht'] = 'haste',
	['htb'] = 'httest',
	['html.m4'] = 'htmlm4',
	['htpp'] = 'hastepreproc',
	['htt'] = 'httest',
	['hx'] = 'haxe',
	['hxml'] = 'hxml',
	['hxx'] = 'cpp',
	['iba'] = 'ibasic',
	['ibi'] = 'ibasic',
	['ice'] = 'slice',
	['icl'] = 'clean',
	['icn'] = 'icon',
	['ih'] = 'ppwiz',
	['ihlp'] = 'smcl',
	['ii'] = 'initng',
	['ijs'] = 'j',
	['il'] = 'skill',
	['ils'] = 'skill',
	['imata'] = 'stata',
	['imp'] = 'b',
	['inf'] = 'inform',
	['ini'] = 'dosini',
	['inl'] = 'cpp',
	['ino'] = 'arduino',
	['intr'] = 'dylanintr',
	['ipp'] = 'cpp',
	['ipynb'] = 'json',
	['isc'] = 'monk',
	['iss'] = 'iss',
	['ist'] = 'ist',
	['it'] = 'ppwiz',
	['itcl'] = 'tcl',
	['itk'] = 'tcl',
	['j73'] = 'jovial',
	['jacl'] = 'tcl',
	['jal'] = 'jal',
	['jav'] = 'java',
	['java'] = 'java',
	['javascript'] = 'javascript',
	['jgr'] = 'jgraph',
	['jj'] = 'javacc',
	['jjt'] = 'javacc',
	['jl'] = 'julia',
	['jov'] = 'jovial',
	['jovial'] = 'jovial',
	['jpl'] = 'jam',
	['jpr'] = 'jam',
	['jrexx'] = 'rexx',
	['js'] = 'javascript',
	['json'] = 'json',
	['jsonp'] = 'json',
	['jsp'] = 'jsp',
	['jsx'] = 'javascriptreact',
	['k'] = 'kwt',
	['kix'] = 'kix',
	['ks'] = 'kscript',
	['kt'] = 'kotlin',
	['ktm'] = 'kotlin',
	['kts'] = 'kotlin',
	['kv'] = 'kivy',
	['latex'] = 'tex',
	['latte'] = 'latte',
	['ld'] = 'ld',
	['ldif'] = 'ldif',
	['less'] = 'less',
	['lgt'] = 'logtalk',
	['lhs'] = 'lhaskell',
	['lib'] = 'cobol',
	['lid'] = 'dylanlid',
	['liquid'] = 'liquid',
	['lisp'] = 'lisp',
	['lite'] = 'lite',
	['ll'] = 'lifelines',
	['lot'] = 'lotos',
	['lotos'] = 'lotos',
	['lou'] = 'lout',
	['lout'] = 'lout',
	['lpc'] = 'lpc',
	['lpr'] = 'pascal',
	['lsp'] = 'lisp',
	['lss'] = 'lss',
	['lt'] = 'lite',
	['lte'] = 'latte',
	['ltx'] = 'tex',
	['lua'] = 'lua',
	['lock'] = 'toml',
	['m2'] = 'modula2',
	['m4gl'] = 'fgl',
	['man'] = 'nroff',
	['map'] = 'map',
	['mar'] = 'vmasm',
	['markdown'] = 'markdown',
	['mas'] = 'master',
	['mason'] = 'mason',
	['master'] = 'master',
	['mat'] = 'radiance',
	['mata'] = 'stata',
	['mch'] = 'b',
	['md'] = 'markdown',
	['mdown'] = 'markdown',
	['mdwn'] = 'markdown',
	['mel'] = 'mel',
	['mf'] = 'mf',
	['mgl'] = 'mgl',
	['mgp'] = 'mgp',
	['mhtml'] = 'mason',
	['mi'] = 'modula2',
	['mib'] = 'mib',
	['mix'] = 'mix',
	['mixal'] = 'mix',
	['mjs'] = 'javascript',
	['mkd'] = 'markdown',
	['mkdn'] = 'markdown',
	['mkii'] = 'context',
	['mkiv'] = 'context',
	['mklx'] = 'context',
	['mkvi'] = 'context',
	['mkxl'] = 'context',
	['ml'] = 'ocaml',
	['ml.cppo'] = 'ocaml',
	['mli'] = 'ocaml',
	['mli.cppo'] = 'ocaml',
	['mlip'] = 'ocaml',
	['mll'] = 'ocaml',
	['mlp'] = 'ocaml',
	['mlt'] = 'ocaml',
	['mly'] = 'ocaml',
	['mmp'] = 'mmp',
	['mo'] = 'gdmo',
	['moc'] = 'cpp',
	['mof'] = 'msidl',
	['mom'] = 'nroff',
	['monk'] = 'monk',
	['moo'] = 'moo',
	['mot'] = 'srec',
	['mp'] = 'mp',
	['mpl'] = 'maple',
	['msc'] = 'xmath',
	['msf'] = 'xmath',
	['msql'] = 'msql',
	['mst'] = 'ist',
	['mush'] = 'mush',
	['mv'] = 'maple',
	['mws'] = 'maple',
	['my'] = 'mib',
	['mysql'] = 'mysql',
	['nanorc'] = 'nanorc',
	['nb'] = 'mma',
	['ncf'] = 'ncf',
	['ninja'] = 'ninja',
	['nqc'] = 'nqc',
	['nr'] = 'nroff',
	['nse'] = 'lua',
	['nsh'] = 'nsis',
	['nsi'] = 'nsis',
	['obj'] = 'obj',
	['occ'] = 'occam',
	['odl'] = 'msidl',
	['opam'] = 'opam',
	['opam.template'] = 'opam',
	['or'] = 'openroad',
	['ora'] = 'ora',
	['org'] = 'org',
	['orx'] = 'rexx',
	['p36'] = 'plm',
	['p6'] = 'raku',
	['pac'] = 'plm',
	['page'] = 'mallard',
	['papp'] = 'papp',
	['pas'] = 'pascal',
	['pbtxt'] = 'pbtxt',
	['pc'] = 'proc',
	['pcmk'] = 'pcmk',
	['pdb'] = 'prolog',
	['pde'] = 'arduino',
	['pdf'] = 'pdf',
	['pfa'] = 'postscr',
	['pike'] = 'pike',
	['pk'] = 'poke',
	['pkb'] = 'sql',
	['pks'] = 'sql',
	['pl1'] = 'pli',
	['pld'] = 'cupl',
	['pli'] = 'pli',
	['plm'] = 'plm',
	['plp'] = 'plp',
	['pls'] = 'plsql',
	['plsql'] = 'plsql',
	['plx'] = 'perl',
	['pm6'] = 'raku',
	['pml'] = 'promela',
	['pmod'] = 'pike',
	['po'] = 'po',
	['pod'] = 'pod',
	['pod6'] = 'raku',
	['pot'] = 'po',
	['pov'] = 'pov',
	['ppd'] = 'ppd',
	['pr'] = 'sdl',
	['proto'] = 'proto',
	['ps'] = 'postscr',
	['ps1'] = 'ps1',
	['ps1xml'] = 'ps1xml',
	['psc1'] = 'xml',
	['psd1'] = 'ps1',
	['psf'] = 'psf',
	['psgi'] = 'perl',
	['psl'] = 'psl',
	['psm1'] = 'ps1',
	['pssc'] = 'ps1',
	['ptl'] = 'python',
	['pxd'] = 'pyrex',
	['pxml'] = 'papp',
	['pxsl'] = 'papp',
	['py'] = 'python',
	['pyi'] = 'python',
	['pyw'] = 'python',
	['pyx'] = 'pyrex',
	['qc'] = 'c',
	['quake'] = 'm3quake',
	['rad'] = 'radiance',
	['rake'] = 'ruby',
	['raku'] = 'raku',
	['rakudoc'] = 'raku',
	['rakumod'] = 'raku',
	['rakutest'] = 'raku',
	['raml'] = 'raml',
	['rb'] = 'ruby',
	['rbs'] = 'rbs',
	['rbw'] = 'ruby',
	['rc'] = 'rc',
	['rch'] = 'rc',
	['rcp'] = 'pilrc',
	['rd'] = 'rhelp',
	['recipe'] = 'conaryrecipe',
	['ref'] = 'b',
	['rego'] = 'rego',
	['rej'] = 'diff',
	['rem'] = 'remind',
	['remind'] = 'remind',
	['res'] = 'rescript',
	['resi'] = 'rescript',
	['rex'] = 'rexx',
	['rexx'] = 'rexx',
	['rexxj'] = 'rexx',
	['rhtml'] = 'eruby',
	['rib'] = 'rib',
	['rjs'] = 'ruby',
	['rkt'] = 'scheme',
	['rmd'] = 'rmd',
	['rnc'] = 'rnc',
	['rng'] = 'rng',
	['rnw'] = 'rnoweb',
	['rockspec'] = 'lua',
	['roff'] = 'nroff',
	['rpl'] = 'rpl',
	['rq'] = 'sparql',
	['rrst'] = 'rrst',
	['rs'] = 'rust',
	['rss'] = 'xml',
	['rst'] = 'rst',
	['rtf'] = 'rtf',
	['ru'] = 'ruby',
	['run'] = 'ampl',
	['rxj'] = 'rexx',
	['rxml'] = 'ruby',
	['rxo'] = 'rexx',
	['s19'] = 'srec',
	['s28'] = 'srec',
	['s37'] = 'srec',
	['s85'] = 'sinda',
	['sa'] = 'sather',
	['sas'] = 'sas',
	['sass'] = 'sass',
	['sba'] = 'vb',
	['sbt'] = 'sbt',
	['scala'] = 'scala',
	['sce'] = 'scilab',
	['sci'] = 'scilab',
	['scm'] = 'scheme',
	['score'] = 'slrnsc',
	['scpt'] = 'applescript',
	['scss'] = 'scss',
	['sd'] = 'sd',
	['sdc'] = 'sdc',
	['sdl'] = 'sdl',
	['sed'] = 'sed',
	['service'] = 'systemd',
	['sexp'] = 'sexplib',
	['si'] = 'cuplsim',
	['sieve'] = 'sieve',
	['sil'] = 'sil',
	['sim'] = 'simula',
	['sin'] = 'sinda',
	['siv'] = 'sieve',
	['sl'] = 'slang',
	['slt'] = 'tsalt',
	['sol'] = 'solidity',
	['smcl'] = 'smcl',
	['smd'] = 'rmd',
	['smith'] = 'smith',
	['sml'] = 'sml',
	['smt'] = 'smith',
	['sno'] = 'snobol4',
	['snw'] = 'rnoweb',
	['sp'] = 'spice',
	['sparql'] = 'sparql',
	['spd'] = 'spup',
	['spdata'] = 'spup',
	['spec'] = 'spec',
	['speedup'] = 'spup',
	['spi'] = 'spyce',
	['spice'] = 'spice',
	['spt'] = 'snobol4',
	['spy'] = 'spyce',
	['sqi'] = 'sqr',
	['sqlj'] = 'sqlj',
	['sqr'] = 'sqr',
	['srec'] = 'srec',
	['srst'] = 'rrst',
	['ss'] = 'scheme',
	['ssc'] = 'monk',
	['st'] = 'st',
	['stp'] = 'stp',
	['strl'] = 'esterel',
	['sty'] = 'tex',
	['sum'] = 'hercules',
	['sv'] = 'systemverilog',
	['svelte'] = 'svelte',
	['svg'] = 'svg',
	['svh'] = 'systemverilog',
	['swift'] = 'swift',
	['swift.gyb'] = 'swiftgyb',
	['sys'] = 'dosbatch',
	['t.html'] = 'tilde',
	['t6'] = 'raku',
	['tak'] = 'tak',
	['tcc'] = 'cpp',
	['tcl'] = 'tcl',
	['tdf'] = 'ahdl',
	['testGroup'] = 'rexx',
	['testUnit'] = 'rexx',
	['texi'] = 'texinfo',
	['texinfo'] = 'texinfo',
	['text'] = 'text',
	['ti'] = 'terminfo',
	['tk'] = 'tcl',
	['tlh'] = 'cpp',
	['tli'] = 'tli',
	['tmac'] = 'nroff',
	['tmpl'] = 'template',
	['toc'] = 'cdrtoc',
	['toml'] = 'toml',
	['tpl'] = 'smarty',
	['tpm'] = 'xml',
	['tpp'] = 'cpp',
	['tr'] = 'nroff',
	['tsc'] = 'monk',
	['tsx'] = 'typescriptreact',
	['txi'] = 'texinfo',
	['tyb'] = 'sql',
	['tyc'] = 'sql',
	['typ'] = 'sql',
	['uc'] = 'uc',
	['ui'] = 'xml',
	['uil'] = 'uil',
	['uit'] = 'uil',
	['ulpc'] = 'lpc',
	['v'] = 'verilog',
	['va'] = 'verilogams',
	['vams'] = 'verilogams',
	['vb'] = 'vb',
	['vba'] = 'vim',
	['vbe'] = 'vhdl',
	['vbs'] = 'vb',
	['vc'] = 'hercules',
	['vhd'] = 'vhdl',
	['vhdl'] = 'vhdl',
	['vho'] = 'vhdl',
	['vim'] = 'vim',
	['vr'] = 'vera',
	['vrh'] = 'vera',
	['vri'] = 'vera',
	['vroom'] = 'vroom',
	['vst'] = 'vhdl',
	['vue'] = 'vue',
	['wast'] = 'wast',
	['wat'] = 'wast',
	['wbt'] = 'winbatch',
	['webmanifest'] = 'json',
	['wiki'] = 'flexwiki',
	['wm'] = 'webmacro',
	['wml'] = 'wml',
	['wpl'] = 'xml',
	['wrap'] = 'dosini',
	['wrl'] = 'vrml',
	['wrm'] = 'acedb',
	['wsdl'] = 'xml',
	['wsml'] = 'wsml',
	['x'] = 'rpcgen',
	['xht'] = 'xhtml',
	['xhtml'] = 'xhtml',
	['xin'] = 'omnimark',
	['xlf'] = 'xml',
	['xliff'] = 'xml',
	['xmi'] = 'xml',
	['xom'] = 'omnimark',
	['xq'] = 'xquery',
	['xql'] = 'xquery',
	['xqm'] = 'xquery',
	['xquery'] = 'xquery',
	['xqy'] = 'xquery',
	['xs'] = 'xs',
	['xsd'] = 'xsd',
	['xsl'] = 'xslt',
	['xslt'] = 'xslt',
	['xul'] = 'xml',
	['yaml'] = 'yaml',
	['yaws'] = 'erlang',
	['yml'] = 'yaml',
	['z8a'] = 'z8a',
	['zsh'] = 'zsh',
	['zu'] = 'zimbu',
	['zut'] = 'zimbutempl',

	['ms'] = function()
		return detect.nroff() or 'xmath'
	end,
	['xpm'] = function()
		return (util.getline():find('XPM2') and 'xpm2') or 'xpm'
	end,
	['module'] = function()
		return (util.getline():find('%<%?php') and 'php') or 'virata'
	end,
	['pkg'] = function()
		return (util.getline():find('%<%?php') and 'php') or 'virata'
	end,
	['hw'] = function()
		return (util.getline():find('%<%?php') and 'php') or 'virata'
	end,
	['ts'] = function()
		return (util.getline():find('<%?xml') and 'xml') or 'typescript'
	end,
	['ttl'] = function()
		if util.getline():find('^@?(prefix|base)') then
			return 'stata'
		end
	end,
	['t'] = function(args)
		return detect.nroff() or detect.perl(args.file_path, args.file_ext) or 'tads'
	end,
	['class'] = function()
		-- Decimal escape sequence
		-- The original was "^\xca\xfe\xba\xbe"
		if util.getline():find('^\x202\x254\x186\x190') then
			return 'stata'
		end
	end,
	['smi'] = function()
		return (util.getline():find('smil') and 'smil') or 'mib'
	end,
	['smil'] = function()
		return (util.getline():find('<?%s*xml.*?>') and 'xml') or 'smil'
	end,
	['cls'] = function()
		if vim.g.filetype_cls then
			return vim.g.filetype_cls
		end

		local line = util.getline()
		if line:find('^[%%\\]') then
			return 'tex'
		end

		if line:sub(1, 1) == '#' and line:find('rexx') then
			return detect.sh('rexx')
		end

		if line == 'VERSION 1.0 CLASS' then
			return 'vb'
		end

		return 'st'
	end,
	['install'] = function()
		return (util.getline():find('%<%?php') and 'php') or detect.sh('bash')
	end,
	['decl'] = function()
		return util.getlines_as_string(0, detect.line_limit, ' '):find('^%<%!SGML') and 'sgmldecl'
	end,
	['sgm'] = function()
		return detect.sgml()
	end,
	['sgml'] = function()
		return detect.sgml()
	end,
	['reg'] = function()
		if util.getline():find('^REGEDIT[0-9]*%s*$|^Windows Registry Editor Version %d*%.%d*%s*$') then
			return 'registry'
		end
	end,
	['pm'] = function()
		local line = util.getline()
		return (line:find('XPM2') and 'xpm2') or (line:find('XPM') and 'xpm') or 'perl'
	end,
	['me'] = function(args)
		if args.file_name ~= 'read.me' and args.file_name ~= 'click.me' then
			return 'nroff'
		end
	end,
	['m4'] = function(args)
		if not util.findany(args.file_path, { 'html.m4$', 'fvwm2rc' }) then
			return 'm4'
		end
	end,
	['edn'] = function()
		return (util.getline():find('^%s*%(%s*edif') and 'edif') or 'clojure'
	end,
	['rul'] = function()
		return (util.getlines_as_string(0, detect.line_limit):find('InstallShield') and 'ishd') or 'diva'
	end,
	['prg'] = function()
		return (vim.g.filetype_prg and vim.g.filetype_prg) or 'clipper'
	end,
	['cpy'] = function()
		return (util.getline():find('^%#%#') and 'python') or 'cobol'
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
	['asa'] = function()
		return (vim.g.filetype_asa and vim.g.filetype_asa) or 'aspvbs'
	end,
	['cmd'] = function()
		return (util.getline():find('^%/%*') and 'rexx') or 'dosbatch'
	end,
	['cc'] = function()
		return (vim.g.cynlib_syntax_for_cc and 'cynlib') or 'cpp'
	end,
	['cpp'] = function()
		return (vim.g.cynlib_syntax_for_cc and 'cynlib') or 'cpp'
	end,
	['inp'] = function()
		return detect.inp()
	end,
	['asm'] = function()
		return detect.asm()
	end,
	['s'] = function()
		return detect.asm()
	end,
	['S'] = function()
		return detect.asm()
	end,
	['a'] = function()
		return detect.asm()
	end,
	['A'] = function()
		return detect.asm()
	end,
	['mac'] = function()
		return detect.asm()
	end,
	['lst'] = function()
		return detect.asm()
	end,
	['bas'] = function()
		return detect.vbasic()
	end,
	['btm'] = function()
		if vim.g.dosbatch_syntax_for_btm and vim.g.dosbatch_syntax_for_btm ~= 0 then
			return 'dosbatch'
		end

		return 'btm'
	end,
	['db'] = function()
		return detect.bindzone()
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
	['ex'] = function()
		return detect.elixir_check()
	end,
	['eu'] = function()
		return detect.euphoria_check()
	end,
	['ew'] = function()
		return detect.euphoria_check()
	end,
	['exu'] = function()
		return detect.euphoria_check()
	end,
	['exw'] = function()
		return detect.euphoria_check()
	end,
	['EU'] = function()
		return detect.euphoria_check()
	end,
	['EW'] = function()
		return detect.euphoria_check()
	end,
	['EX'] = function()
		return detect.euphoria_check()
	end,
	['EXU'] = function()
		return detect.euphoria_check()
	end,
	['EXW'] = function()
		return detect.euphoria_check()
	end,
	['e'] = function()
		return detect.eiffel_check()
	end,
	['E'] = function()
		return detect.eiffel_check()
	end,
	['ent'] = function()
		return detect.eiffel_check()
	end,
	['d'] = function()
		return detect.dtrace()
	end,
	['com'] = function()
		return detect.bindzone() or 'dcl'
	end,
	['html'] = function()
		return detect.html()
	end,
	['htm'] = function()
		return detect.html()
	end,
	['shtml'] = function()
		return detect.html()
	end,
	['stm'] = function()
		return detect.html()
	end,
	['idl'] = function()
		return detect.idl()
	end,
	['pro'] = function()
		return detect.proto() or 'idlang'
	end,
	['m'] = function()
		return detect.m()
	end,
	['mm'] = function()
		return detect.mm()
	end,
	['mms'] = function()
		return detect.mms()
	end,
	['pp'] = function()
		return detect.pp()
	end,
	['pl'] = function()
		return detect.pl()
	end,
	['PL'] = function()
		return detect.pl()
	end,
	['inc'] = function()
		return detect.inc()
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
	['r'] = function()
		return detect.r()
	end,
	['R'] = function()
		return detect.r()
	end,
	['mc'] = function()
		return detect.mc()
	end,
	['ebuild'] = function()
		return detect.sh('bash')
	end,
	['bash'] = function()
		return detect.sh('bash')
	end,
	['eclass'] = function()
		return detect.sh('bash')
	end,
	['ksh'] = function()
		return detect.sh('ksh')
	end,
	['etc/profile'] = function()
		return detect.sh('sh', true)
	end,
	['sh'] = function()
		return detect.sh('sh', true)
	end,
	['env'] = function()
		return detect.sh('sh', true)
	end,
	['tcsh'] = function()
		return detect.sh('tcsh')
	end,
	['csh'] = function()
		return detect.csh()
	end,
	['rules'] = function(args)
		return detect.rules(args.file_path)
	end,
	['sql'] = function()
		return (vim.g.filetype_sql and vim.g.filetype_sql) or 'sql'
	end,
	['tex'] = function(args)
		return detect.tex(args.file_path)
	end,
	['frm'] = function()
		return detect.vbasic_form()
	end,
	['xml'] = function()
		return detect.xml()
	end,
	['y'] = function()
		return detect.y()
	end,
	['dtml'] = function()
		return detect.html()
	end,
	['pt'] = function()
		return detect.html()
	end,
	['cpt'] = function()
		return detect.html()
	end,
	['zsql'] = function()
		return (vim.g.filetype_sql and vim.g.filetype_sql) or 'sql'
	end,
	['dsl'] = function()
		return (util.getline():find('^%s*<!') and 'dsl') or 'structurizr'
	end,
	['sc'] = function()
		return detect.sc()
	end,
	['sig'] = function()
		return detect.sig()
	end,
	['fs'] = function()
		return detect.fs()
	end,
	['lsl'] = function()
		return detect.lsl()
	end,
	['tf'] = function()
		return detect.tf()
	end,
	['patch'] = function()
		return detect.patch()
	end,
}

return extensions
