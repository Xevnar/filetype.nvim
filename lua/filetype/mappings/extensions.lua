--- @module 'filetype.util'
local util = require('filetype.util')

--- @module 'filetype.detect'
local detect = require('filetype.detect')

--- @type { [string]: filetype_mapping }
local extensions = {
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
	['sys'] = 'dosbatch',
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
	['MOD'] = 'modula2',
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
	['mp'] = 'mp',
	['mof'] = 'msidl',
	['odl'] = 'msidl',
	['msql'] = 'msql',
	['mu'] = 'mupad',
	['mush'] = 'mush',
	['mysql'] = 'mysql',
	['nanorc'] = 'nanorc',
	['nql'] = 'n1ql',
	['n1ql'] = 'n1ql',
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
	['sil'] = 'sil',
	['sim'] = 'simula',
	['s85'] = 'sinda',
	['sin'] = 'sinda',
	['ssi'] = 'sisu',
	['ssm'] = 'sisu',
	['sst'] = 'sisu',
	['_sst'] = 'sisu',
	['-sst'] = 'sisu',
	['il'] = 'skill',
	['cdf'] = 'skill',
	['ils'] = 'skill',
	['sl'] = 'slang',
	['ice'] = 'slice',
	['score'] = 'slrnsc',
	['tpl'] = 'smarty',
	['hlp'] = 'smcl',
	['ihlp'] = 'smcl',
	['smcl'] = 'smcl',
	['smt'] = 'smith',
	['smith'] = 'smith',
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
		local line = util.getline():lower()
		if line:find('^@?prefix') or line:find('^@?base') then
			return 'turtle'
		end
		return 'teraterm'
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
	['bi'] = function()
		return detect.vbasic()
	end,
	['bm'] = function()
		return detect.vbasic()
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
}

return extensions
