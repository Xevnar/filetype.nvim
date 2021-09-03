local M = {}

M.extensions = {
    [".ch"] = "chill",
    ["4gh"] = "fgl",
    ["4gl"] = "fgl",
    ["8th"] = "8th",
    ["ACE"] = "lace",
    ["BUILD"] = "bzl",
    ["C"] = "cpp",
    ["DEF"] = "modula2",
    ["Dockerfile"] = "dockerfile",
    ["EC"] = "esqlc",
    ["F"] = "fortran",
    ["F03"] = "fortran",
    ["F08"] = "fortran",
    ["F77"] = "fortran",
    ["F90"] = "fortran",
    ["F95"] = "fortran",
    ["FOR"] = "fortran",
    ["FPP"] = "fortran",
    ["FTN"] = "fortran",
    ["H"] = "cpp",
    ["INF"] = "inform",
    ["JAL"] = "jal",
    ["L"] = "lisp",
    ["MOD"] = "modula2",
    ["Rd"] = "rhelp",
    ["Rmd"] = "rmd",
    ["Rnw"] = "rnoweb",
    ["Rrst"] = "rrst",
    ["Smd"] = "rmd",
    ["Snw"] = "rnoweb",
    ["Srst"] = "rrst",
    ["a65"] = "a65",
    ["aap"] = "aap",
    ["abap"] = "abap",
    ["abc"] = "abc",
    ["abl"] = "abel",
    ["ace"] = "lace",
    ["action"] = "privoxy",
    ["ada"] = "ada",
    ["adb"] = "ada",
    ["ado"] = "stata",
    ["adoc"] = "asciidoc",
    ["ads"] = "ada",
    ["afm"] = "postscr",
    ["ahk"] = "autohotkey",
    ["ai"] = "postscr",
    ["aidl"] = "aidl",
    ["al"] = "perl",
    ["aml"] = "aml",
    ["art"] = "art",
    ["as"] = "atlas",
    ["asciidoc"] = "asciidoc",
    ["asn"] = "asn",
    ["asn1"] = "asn",
    ["at"] = "m4",
    ["atg"] = "coco",
    ["atl"] = "atlas",
    ["atom"] = "xml",
    ["au3"] = "autoit",
    ["ave"] = "ave",
    ["awk"] = "awk",
    ["bat"] = "dosbatch",
    ["bbl"] = "tex",
    ["bc"] = "bc",
    ["bdf"] = "bdf",
    ["beancount"] = "beancount",
    ["bi"] = "freebasic",
    ["bib"] = "bib",
    ["bl"] = "blank",
    ["bsdl"] = "bsdl",
    ["bst"] = "bst",
    ["builder"] = "ruby",
    ["cabal"] = "cabal",
    ["cbl"] = "cobol",
    ["cdf"] = "skill",
    ["cdl"] = "cdl",
    ["cdxml"] = "xml",
    ["cfc"] = "cf",
    ["cfg"] = "cfg",
    ["cfi"] = "cf",
    ["cfm"] = "cf",
    ["chf"] = "ch",
    ["cho"] = "chordpro",
    ["chopro"] = "chordpro",
    ["chordpro"] = "chordpro",
    ["chs"] = "chaskell",
    ["cjs"] = "javascript",
    ["cl"] = "lisp",
    ["clj"] = "clojure",
    ["cljc"] = "clojure",
    ["cljs"] = "clojure",
    ["cljx"] = "clojure",
    ["clp"] = "jess",
    ["cm"] = "voscm",
    ["cmake"] = "cmake",
    ["cmake.in"] = "cmake",
    ["cmod"] = "cmod",
    ["cob"] = "cobol",
    ["comp"] = "mason",
    ["con"] = "cterm",
    ["crd"] = "chordpro",
    ["crdpro"] = "chordpro",
    ["crm"] = "crm",
    ["cs"] = "cs",
    ["csc"] = "csc",
    ["csdl"] = "csdl",
    ["csp"] = "csp",
    ["csproj"] = "xml",
    ["csproj.user"] = "xml",
    ["css"] = "css",
    ["ctl"] = "vb",
    ["cu"] = "cuda",
    ["cuh"] = "cuda",
    ["cyn"] = "cynpp",
    ["dat"] = "nastran",
    ["dcd"] = "dcd",
    ["dcl"] = "clean",
    ["def"] = "def",
    ["desc"] = "desc",
    ["desktop"] = "desktop",
    ["diff"] = "diff",
    ["directory"] = "desktop",
    ["do"] = "stata",
    ["dot"] = "dot",
    ["dpr"] = "pascal",
    ["drac"] = "dracula",
    ["drc"] = "dracula",
    ["ds"] = "datascript",
    ["dsl"] = "dsl",
    ["dsm"] = "vb",
    ["dtd"] = "dtd",
    ["dts"] = "dts",
    ["dtsi"] = "dts",
    ["dtx"] = "tex",
    ["dylan"] = "dylan",
    ["ec"] = "esqlc",
    ["ecd"] = "ecd",
    ["el"] = "lisp",
    ["elm"] = "elm",
    ["eni"] = "cl",
    ["epp"] = "epuppet",
    ["eps"] = "postscr",
    ["epsf"] = "postscr",
    ["epsi"] = "postscr",
    ["erb"] = "eruby",
    ["erl"] = "erlang",
    ["errsum"] = "hercules",
    ["es"] = "javascript",
    ["ev"] = "hercules",
    ["exp"] = "expect",
    ["f"] = "fortran",
    ["f03"] = "fortran",
    ["f08"] = "fortran",
    ["f77"] = "fortran",
    ["f90"] = "fortran",
    ["f95"] = "fortran",
    ["factor"] = "factor",
    ["fal"] = "falcon",
    ["fan"] = "fan",
    ["fb"] = "freebasic",
    ["fdr"] = "csp",
    ["feature"] = "cucumber",
    ["fex"] = "focexec",
    ["focexec"] = "focexec",
    ["for"] = "fortran",
    ["fortran"] = "fortran",
    ["fpc"] = "fpcmake",
    ["fpp"] = "fortran",
    ["frt"] = "reva",
    ["fs"] = "forth",
    ["fsl"] = "framescript",
    ["ft"] = "forth",
    ["fth"] = "forth",
    ["ftn"] = "fortran",
    ["fwt"] = "fan",
    ["g"] = "pccts",
    ["gawk"] = "awk",
    ["gdmo"] = "gdmo",
    ["ged"] = "gedcom",
    ["gemspec"] = "ruby",
    ["git/config"] = "gitconfig",
    ["go"] = "go",
    ["gp"] = "gp",
    ["gpi"] = "gnuplot",
    ["gpr"] = "ada",
    ["gradle"] = "groovy",
    ["gretl"] = "gretl",
    ["groovy"] = "groovy",
    ["gs"] = "grads",
    ["gsp"] = "gsp",
    ["gv"] = "dot",
    ["h32"] = "hex",
    ["haml"] = "haml",
    ["hb"] = "hb",
    ["hdl"] = "vhdl",
    ["hex"] = "hex",
    ["hgrc"] = "cfg",
    ["hlp"] = "smcl",
    ["hog"] = "hog",
    ["hrl"] = "erlang",
    ["hsm"] = "hamster",
    ["ht"] = "haste",
    ["htb"] = "httest",
    ["html.m4"] = "htmlm4",
    ["htpp"] = "hastepreproc",
    ["htt"] = "httest",
    ["iba"] = "ibasic",
    ["ibi"] = "ibasic",
    ["ice"] = "slice",
    ["icl"] = "clean",
    ["icn"] = "icon",
    ["ih"] = "ppwiz",
    ["ihlp"] = "smcl",
    ["ii"] = "initng",
    ["ijs"] = "j",
    ["il"] = "skill",
    ["ils"] = "skill",
    ["imata"] = "stata",
    ["imp"] = "b",
    ["inf"] = "inform",
    ["ini"] = "dosini",
    ["ino"] = "arduino",
    ["intr"] = "dylanintr",
    ["ipynb"] = "json",
    ["isc"] = "monk",
    ["iss"] = "iss",
    ["ist"] = "ist",
    ["it"] = "ppwiz",
    ["itcl"] = "tcl",
    ["itk"] = "tcl",
    ["j73"] = "jovial",
    ["jacl"] = "tcl",
    ["jal"] = "jal",
    ["jav"] = "java",
    ["java"] = "java",
    ["javascript"] = "javascript",
    ["jgr"] = "jgraph",
    ["jj"] = "javacc",
    ["jjt"] = "javacc",
    ["jov"] = "jovial",
    ["jovial"] = "jovial",
    ["jpl"] = "jam",
    ["jpr"] = "jam",
    ["jrexx"] = "rexx",
    ["js"] = "javascript",
    ["json"] = "json",
    ["jsonp"] = "json",
    ["jsp"] = "jsp",
    ["jsx"] = "javascriptreact",
    ["k"] = "kwt",
    ["kix"] = "kix",
    ["ks"] = "kscript",
    ["kt"] = "kotlin",
    ["ktm"] = "kotlin",
    ["kts"] = "kotlin",
    ["kv"] = "kivy",
    ["latex"] = "tex",
    ["latte"] = "latte",
    ["ld"] = "ld",
    ["ldif"] = "ldif",
    ["less"] = "less",
    ["lgt"] = "logtalk",
    ["lhs"] = "lhaskell",
    ["lib"] = "cobol",
    ["lid"] = "dylanlid",
    ["liquid"] = "liquid",
    ["lisp"] = "lisp",
    ["lite"] = "lite",
    ["ll"] = "lifelines",
    ["lot"] = "lotos",
    ["lotos"] = "lotos",
    ["lou"] = "lout",
    ["lout"] = "lout",
    ["lpc"] = "lpc",
    ["lpr"] = "pascal",
    ["lsl"] = "lsl",
    ["lsp"] = "lisp",
    ["lss"] = "lss",
    ["lt"] = "lite",
    ["lte"] = "latte",
    ["ltx"] = "tex",
    ["lua"] = "lua",
    ["m2"] = "modula2",
    ["m4gl"] = "fgl",
    ["man"] = "nroff",
    ["map"] = "map",
    ["mar"] = "vmasm",
    ["markdown"] = "markdown",
    ["mas"] = "master",
    ["mason"] = "mason",
    ["master"] = "master",
    ["mat"] = "radiance",
    ["mata"] = "stata",
    ["mch"] = "b",
    ["md"] = "markdown",
    ["mdown"] = "markdown",
    ["mdwn"] = "markdown",
    ["mel"] = "mel",
    ["mf"] = "mf",
    ["mgl"] = "mgl",
    ["mgp"] = "mgp",
    ["mhtml"] = "mason",
    ["mi"] = "modula2",
    ["mib"] = "mib",
    ["mix"] = "mix",
    ["mixal"] = "mix",
    ["mjs"] = "javascript",
    ["mkd"] = "markdown",
    ["mkdn"] = "markdown",
    ["mkii"] = "context",
    ["mkiv"] = "context",
    ["mklx"] = "context",
    ["mkvi"] = "context",
    ["mkxl"] = "context",
    ["ml"] = "ocaml",
    ["ml.cppo"] = "ocaml",
    ["mli"] = "ocaml",
    ["mli.cppo"] = "ocaml",
    ["mlip"] = "ocaml",
    ["mll"] = "ocaml",
    ["mlp"] = "ocaml",
    ["mlt"] = "ocaml",
    ["mly"] = "ocaml",
    ["mmp"] = "mmp",
    ["mo"] = "gdmo",
    ["mof"] = "msidl",
    ["mom"] = "nroff",
    ["monk"] = "monk",
    ["moo"] = "moo",
    ["mot"] = "srec",
    ["mp"] = "mp",
    ["mpl"] = "maple",
    ["msc"] = "xmath",
    ["msf"] = "xmath",
    ["msql"] = "msql",
    ["mst"] = "ist",
    ["mush"] = "mush",
    ["mv"] = "maple",
    ["mws"] = "maple",
    ["my"] = "mib",
    ["mysql"] = "mysql",
    ["nanorc"] = "nanorc",
    ["nb"] = "mma",
    ["ncf"] = "ncf",
    ["ninja"] = "ninja",
    ["nqc"] = "nqc",
    ["nr"] = "nroff",
    ["nse"] = "lua",
    ["nsh"] = "nsis",
    ["nsi"] = "nsis",
    ["obj"] = "obj",
    ["occ"] = "occam",
    ["odl"] = "msidl",
    ["opam"] = "opam",
    ["opam.template"] = "opam",
    ["or"] = "openroad",
    ["ora"] = "ora",
    ["orx"] = "rexx",
    ["p36"] = "plm",
    ["p6"] = "raku",
    ["pac"] = "plm",
    ["page"] = "mallard",
    ["papp"] = "papp",
    ["pas"] = "pascal",
    ["pbtxt"] = "pbtxt",
    ["pc"] = "proc",
    ["pcmk"] = "pcmk",
    ["pdb"] = "prolog",
    ["pde"] = "arduino",
    ["pdf"] = "pdf",
    ["pfa"] = "postscr",
    ["pike"] = "pike",
    ["pk"] = "poke",
    ["pkb"] = "sql",
    ["pks"] = "sql",
    ["pl1"] = "pli",
    ["pld"] = "cupl",
    ["pli"] = "pli",
    ["plm"] = "plm",
    ["plp"] = "plp",
    ["pls"] = "plsql",
    ["plsql"] = "plsql",
    ["plx"] = "perl",
    ["pm6"] = "raku",
    ["pml"] = "promela",
    ["pmod"] = "pike",
    ["po"] = "po",
    ["pod"] = "pod",
    ["pod6"] = "raku",
    ["pot"] = "po",
    ["pov"] = "pov",
    ["ppd"] = "ppd",
    ["pr"] = "sdl",
    ["proto"] = "proto",
    ["ps"] = "postscr",
    ["ps1"] = "ps1",
    ["ps1xml"] = "ps1xml",
    ["psc1"] = "xml",
    ["psd1"] = "ps1",
    ["psf"] = "psf",
    ["psgi"] = "perl",
    ["psl"] = "psl",
    ["psm1"] = "ps1",
    ["pssc"] = "ps1",
    ["ptl"] = "python",
    ["pxd"] = "pyrex",
    ["pxml"] = "papp",
    ["pxsl"] = "papp",
    ["py"] = "python",
    ["pyi"] = "python",
    ["pyw"] = "python",
    ["pyx"] = "pyrex",
    ["qc"] = "c",
    ["quake"] = "m3quake",
    ["rad"] = "radiance",
    ["raku"] = "raku",
    ["rakudoc"] = "raku",
    ["rakumod"] = "raku",
    ["rakutest"] = "raku",
    ["raml"] = "raml",
    ["rb"] = "ruby",
    ["rbs"] = "rbs",
    ["rbw"] = "ruby",
    ["rc"] = "rc",
    ["rch"] = "rc",
    ["rcp"] = "pilrc",
    ["rd"] = "rhelp",
    ["recipe"] = "conaryrecipe",
    ["ref"] = "b",
    ["rego"] = "rego",
    ["rej"] = "diff",
    ["rem"] = "remind",
    ["remind"] = "remind",
    ["rex"] = "rexx",
    ["rexx"] = "rexx",
    ["rexxj"] = "rexx",
    ["rhtml"] = "eruby",
    ["rib"] = "rib",
    ["rjs"] = "ruby",
    ["rkt"] = "scheme",
    ["rmd"] = "rmd",
    ["rnc"] = "rnc",
    ["rng"] = "rng",
    ["rnw"] = "rnoweb",
    ["rockspec"] = "lua",
    ["roff"] = "nroff",
    ["rpl"] = "rpl",
    ["rq"] = "sparql",
    ["rrst"] = "rrst",
    ["rs"] = "rust",
    ["rss"] = "xml",
    ["rst"] = "rst",
    ["rtf"] = "rtf",
    ["ru"] = "ruby",
    ["run"] = "ampl",
    ["rxj"] = "rexx",
    ["rxml"] = "ruby",
    ["rxo"] = "rexx",
    ["s19"] = "srec",
    ["s28"] = "srec",
    ["s37"] = "srec",
    ["s85"] = "sinda",
    ["sa"] = "sather",
    ["sas"] = "sas",
    ["sass"] = "sass",
    ["sba"] = "vb",
    ["sbt"] = "sbt",
    ["sc"] = "scala",
    ["scala"] = "scala",
    ["sce"] = "scilab",
    ["sci"] = "scilab",
    ["scm"] = "scheme",
    ["score"] = "slrnsc",
    ["scpt"] = "applescript",
    ["scss"] = "scss",
    ["sd"] = "sd",
    ["sdc"] = "sdc",
    ["sdl"] = "sdl",
    ["sed"] = "sed",
    ["sexp"] = "sexplib",
    ["si"] = "cuplsim",
    ["sieve"] = "sieve",
    ["sig"] = "lprolog",
    ["sil"] = "sil",
    ["sim"] = "simula",
    ["sin"] = "sinda",
    ["siv"] = "sieve",
    ["sl"] = "slang",
    ["slt"] = "tsalt",
    ["smcl"] = "smcl",
    ["smd"] = "rmd",
    ["smith"] = "smith",
    ["sml"] = "sml",
    ["smt"] = "smith",
    ["sno"] = "snobol4",
    ["snw"] = "rnoweb",
    ["sp"] = "spice",
    ["sparql"] = "sparql",
    ["spd"] = "spup",
    ["spdata"] = "spup",
    ["spec"] = "spec",
    ["speedup"] = "spup",
    ["spi"] = "spyce",
    ["spice"] = "spice",
    ["spt"] = "snobol4",
    ["spy"] = "spyce",
    ["sqi"] = "sqr",
    ["sqlj"] = "sqlj",
    ["sqr"] = "sqr",
    ["srec"] = "srec",
    ["srst"] = "rrst",
    ["ss"] = "scheme",
    ["ssc"] = "monk",
    ["st"] = "st",
    ["stp"] = "stp",
    ["strl"] = "esterel",
    ["sty"] = "tex",
    ["sum"] = "hercules",
    ["sv"] = "systemverilog",
    ["svelte"] = "svelte",
    ["svg"] = "svg",
    ["svh"] = "systemverilog",
    ["swift"] = "swift",
    ["swift.gyb"] = "swiftgyb",
    ["sys"] = "dosbatch",
    ["t.html"] = "tilde",
    ["t6"] = "raku",
    ["tak"] = "tak",
    ["tcl"] = "tcl",
    ["tdf"] = "ahdl",
    ["testGroup"] = "rexx",
    ["testUnit"] = "rexx",
    ["texi"] = "texinfo",
    ["texinfo"] = "texinfo",
    ["text"] = "text",
    ["tf"] = "tf",
    ["ti"] = "terminfo",
    ["tk"] = "tcl",
    ["tlh"] = "cpp",
    ["tli"] = "tli",
    ["tmac"] = "nroff",
    ["tmpl"] = "template",
    ["toc"] = "cdrtoc",
    ["toml"] = "toml",
    ["tpl"] = "smarty",
    ["tpm"] = "xml",
    ["tr"] = "nroff",
    ["tsc"] = "monk",
    ["tsx"] = "typescriptreact",
    ["txi"] = "texinfo",
    ["tyb"] = "sql",
    ["tyc"] = "sql",
    ["typ"] = "sql",
    ["uc"] = "uc",
    ["ui"] = "xml",
    ["uil"] = "uil",
    ["uit"] = "uil",
    ["ulpc"] = "lpc",
    ["v"] = "verilog",
    ["va"] = "verilogams",
    ["vams"] = "verilogams",
    ["vb"] = "vb",
    ["vba"] = "vim",
    ["vbe"] = "vhdl",
    ["vbs"] = "vb",
    ["vc"] = "hercules",
    ["vhd"] = "vhdl",
    ["vhdl"] = "vhdl",
    ["vho"] = "vhdl",
    ["vim"] = "vim",
    ["vr"] = "vera",
    ["vrh"] = "vera",
    ["vri"] = "vera",
    ["vroom"] = "vroom",
    ["vst"] = "vhdl",
    ["vue"] = "vue",
    ["wast"] = "wast",
    ["wat"] = "wast",
    ["wbt"] = "winbatch",
    ["webmanifest"] = "json",
    ["wiki"] = "flexwiki",
    ["wm"] = "webmacro",
    ["wml"] = "wml",
    ["wpl"] = "xml",
    ["wrap"] = "dosini",
    ["wrl"] = "vrml",
    ["wrm"] = "acedb",
    ["wsdl"] = "xml",
    ["wsml"] = "wsml",
    ["x"] = "rpcgen",
    ["xht"] = "xhtml",
    ["xhtml"] = "xhtml",
    ["xin"] = "omnimark",
    ["xlf"] = "xml",
    ["xliff"] = "xml",
    ["xmi"] = "xml",
    ["xom"] = "omnimark",
    ["xq"] = "xquery",
    ["xql"] = "xquery",
    ["xqm"] = "xquery",
    ["xquery"] = "xquery",
    ["xqy"] = "xquery",
    ["xs"] = "xs",
    ["xsd"] = "xsd",
    ["xsl"] = "xslt",
    ["xslt"] = "xslt",
    ["xul"] = "xml",
    ["yaml"] = "yaml",
    ["yaws"] = "erlang",
    ["yml"] = "yaml",
    ["z8a"] = "z8a",
    ["zsh"] = "zsh",
    ["zu"] = "zimbu",
    ["zut"] = "zimbutempl",
}
M.literal = {
    [".a2psrc"] = "a2ps",
    [".asoundrc"] = "alsaconf",
    [".cdrdao"] = "cdrdaoconf",
    [".cvsrc"] = "cvsrc",
    [".dictrc"] = "dictconf",
    [".dir_colors"] = "dircolors",
    [".dircolors"] = "dircolors",
    [".editorconfig"] = "dosini",
    [".emacs"] = "lisp",
    [".exrc"] = "vim",
    [".fetchmailrc"] = "fetchmail",
    [".gdbinit"] = "gdb",
    [".gitconfig"] = "gitconfig",
    [".gitmodules"] = "gitconfig",
    [".gnashpluginrc"] = "gnash",
    [".gnashrc"] = "gnash",
    [".gprc"] = "gp",
    [".gtkrc"] = "gtkrc",
    [".htaccess"] = "apache",
    [".indent.pro"] = "indent",
    [".inputrc"] = "readline",
    [".irbrc"] = "ruby",
    [".lftprc"] = "lftp",
    [".mailcap"] = "mailcap",
    [".mrxvtrc"] = "mrxvtrc",
    [".netrc"] = "netrc",
    [".npmrc"] = "dosini",
    [".ocamlinit"] = "ocaml",
    [".pam_environment"] = "pamenv",
    [".pinerc"] = "pine",
    [".pinercex"] = "pine",
    [".povrayrc"] = "povini",
    [".procmail"] = "procmail",
    [".procmailrc"] = "procmail",
    [".pythonrc"] = "python",
    [".pythonstartup"] = "python",
    [".ratpoisonrc"] = "ratpoison",
    [".reminders"] = "remind",
    [".sawfishrc"] = "lisp",
    [".sbclrc"] = "lisp",
    [".screenrc"] = "screen",
    [".slrnrc"] = "slrnrc",
    [".tfrc"] = "tf",
    [".tidyrc"] = "tidy",
    [".viminfo"] = "viminfo",
    [".wgetrc"] = "wget",
    [".wvdialrc"] = "wvdial",
    [".zcompdump"] = "zsh",
    [".zfbfmarks"] = "zsh",
    [".zlogin"] = "zsh",
    [".zlogout"] = "zsh",
    [".zprofile"] = "zsh",
    [".zshenv"] = "zsh",
    [".zshrc"] = "zsh",
    ["BUILD"] = "bzl",
    ["CMakeLists.txt"] = "cmake",
    ["COMMIT_EDITMSG"] = "gitcommit",
    ["Containerfile"] = "dockerfile",
    ["Dockerfile"] = "dockerfile",
    ["Gemfile"] = "ruby",
    ["Kconfig"] = "kconfig",
    ["Kconfig.debug"] = "kconfig",
    ["MERGE_MSG"] = "gitcommit",
    ["Neomuttrc"] = "neomuttrc",
    ["Pipfile"] = "config",
    ["Pipfile.lock"] = "json",
    ["Puppetfile"] = "ruby",
    ["README"] = "text",
    ["SConstruct"] = "python",
    ["TAG_EDITMSG"] = "gitcommit",
    ["_exrc"] = "vim",
    ["_viminfo"] = "viminfo",
    ["a2psrc"] = "a2ps",
    ["apt.conf"] = "aptconf",
    ["auto.master"] = "conf",
    ["build.xml"] = "ant",
    ["cabal.config"] = "cabalconfig",
    ["cabal.project"] = "cabalproject",
    ["calendar"] = "calendar",
    ["catalog"] = "catalog",
    ["cfengine.conf"] = "cfengine",
    ["cm3.cfg"] = "m3quake",
    ["configure.ac"] = "config",
    ["configure.in"] = "config",
    ["denyhosts.conf"] = "denyhosts",
    ["dict.conf"] = "dictconf",
    ["dictd.conf"] = "dictdconf",
    ["elinks.conf"] = "elinks",
    ["exim.conf"] = "exim",
    ["exports"] = "exports",
    ["fglrxrc"] = "xml",
    ["fstab"] = "fstab",
    ["gitolite.conf"] = "gitolite",
    ["gnashpluginrc"] = "gnash",
    ["gnashrc"] = "gnash",
    ["gtkrc"] = "gtkrc",
    ["indentrc"] = "indent",
    ["inittab"] = "inittab",
    ["inputrc"] = "readline",
    ["ipf.conf"] = "ipfilter",
    ["ipf.rules"] = "ipfilter",
    ["ipf6.conf"] = "ipfilter",
    ["irbrc"] = "ruby",
    ["lftp.conf"] = "lftp",
    ["lilo.conf"] = "lilo",
    ["lltxxxxx.txt"] = "gedcom",
    ["lynx.cfg"] = "lynx",
    ["m3makefile"] = "m3build",
    ["m3overrides"] = "m3build",
    ["mailcap"] = "mailcap",
    ["main.cf"] = "pfmain",
    ["man.config"] = "manconf",
    ["meson.build"] = "meson",
    ["meson_options.txt"] = "meson",
    ["mplayer.conf"] = "mplayerconf",
    ["mrxvtrc"] = "mrxvtrc",
    ["mtab"] = "fstab",
    ["named.root"] = "bindzone",
    ["npmrc"] = "dosini",
    ["opam"] = "opam",
    ["pam_env.conf"] = "pamenv",
    ["pf.conf"] = "pf",
    ["pinerc"] = "pine",
    ["pinercex"] = "pine",
    ["ratpoisonrc"] = "ratpoison",
    ["resolv.conf"] = "resolv",
    ["robots.txt"] = "robots",
    ["sbclrc"] = "lisp",
    ["screenrc"] = "screen",
    ["sendmail.cf"] = "sm",
    ["smb.conf"] = "samba",
    ["snort.conf"] = "hog",
    ["squid.conf"] = "squid",
    ["ssh_config"] = "sshconfig",
    ["sshd_config"] = "sshdconfig",
    ["sudoers.tmp"] = "sudoers",
    ["tags"] = "tags",
    ["texmf.cnf"] = "texmf",
    ["tfrc"] = "tf",
    ["tidy.conf"] = "tidy",
    ["tidyrc"] = "tidy",
    ["trustees.conf"] = "trustees",
    ["vgrindefs"] = "vgrindefs",
    ["vision.conf"] = "hog",
    ["wgetrc"] = "wget",
    ["wvdial.conf"] = "wvdial",
}
-- mapping of lua regex to filetype
M.endswith = {
    ["/%.aptitude/config$"] = "aptconf",
    ["/%.config/git/config$"] = "gitconfig",
    ["/%.gnupg/gpg.conf$"] = "gpg",
    ["/%.gnupg/options$"] = "gpg",
    ["/%.icewm/menu$"] = "icemenu",
    ["/%.libao$"] = "libao",
    ["/%.mplayer/config$"] = "mplayerconf",
    ["/%.pinforc$"] = "pinfo",
    ["/%.ssh/config$"] = "sshconfig",
    ["/boot/grub/grub%.conf$"] = "grub",
    ["/boot/grub/menu%.lst$"] = "grub",
    ["/debian/control$"] = "debcontrol",
    ["/debian/copyright$"] = "debcopyright",
    ["/etc/DIR_COLORS$"] = "dircolors",
    ["/etc/a2ps%.cfg$"] = "a2ps",
    ["/etc/aliases$"] = "mailaliases",
    ["/etc/apt/sources%.list$"] = "debsources",
    ["/etc/asound%.conf$"] = "alsaconf",
    ["/etc/blkid%.tab$"] = "xml",
    ["/etc/blkid%.tab.old$"] = "xml",
    ["/etc/cdrdao%.conf$"] = "cdrdaoconf",
    ["/etc/conf%.modules$"] = "modconf",
    ["/etc/default/cdrdao$"] = "cdrdaoconf",
    ["/etc/defaults/cdrdao$"] = "cdrdaoconf",
    ["/etc/dnsmasq%.conf$"] = "dnsmasq",
    ["/etc/grub%.conf$"] = "grub",
    ["/etc/host%.conf$"] = "hostconf",
    ["/etc/hosts%.allow$"] = "hostsaccess",
    ["/etc/hosts%.deny$"] = "hostsaccess",
    ["/etc/libao%.conf$"] = "libao",
    ["/etc/limits$"] = "limits",
    ["/etc/login%.access$"] = "loginaccess",
    ["/etc/login%.defs$"] = "logindefs",
    ["/etc/mail/aliases$"] = "mailaliases",
    ["/etc/man%.conf$"] = "manconf",
    ["/etc/modules$"] = "modconf",
    ["/etc/modules%.conf$"] = "modconf",
    ["/etc/nanorc$"] = "nanorc",
    ["/etc/pacman%.conf$"] = "dosini",
    ["/etc/pam%.conf$"] = "pamconf",
    ["/etc/pinforc$"] = "pinfo",
    ["/etc/protocols$"] = "protocols",
    ["/etc/sensors%.conf$"] = "sensors",
    ["/etc/sensors3%.conf$"] = "sensors",
    ["/etc/serial%.conf$"] = "setserial",
    ["/etc/services$"] = "services",
    ["/etc/slp%.conf$"] = "slpconf",
    ["/etc/slp%.reg$"] = "slpreg",
    ["/etc/slp%.spi$"] = "slpspi",
    ["/etc/sudoers$"] = "sudoers",
    ["/etc/sysctl%.conf$"] = "sysctl",
    ["/etc/udev/cdsymlinks%.conf$"] = "sh",
    ["/etc/udev/udev%.conf$"] = "udevconf",
    ["/etc/updatedb%.conf$"] = "updatedb",
    ["/etc/xinetd%.conf$"] = "xinetd",
    ["/etc/yum%.conf$"] = "dosini",
    ["/etc/zprofile$"] = "zsh",
    ["/usr/share/alsa/alsa%.conf$"] = "alsaconf",
    ["Xmodmap$"] = "xmodmap",
    ["bsd$"] = "bsdl",
    ["esmtprc$"] = "esmtprc",
    ["hgrc$"] = "cfg",
    ["lftp/rc$"] = "lftp",
    ["lpe$"] = "dracula",
    ["lvs$"] = "dracula",
}

M.complex = {
    [".*%.git/modules/.*/config"] = "gitconfig",
    [".*/%.config/systemd/user/.*%.d/.*%.conf"] = "systemd",
    [".*/%.config/upstart/.*%.conf"] = "upstart",
    [".*/%.config/upstart/.*%.override"] = "upstart",
    [".*/%.init/.*%.conf"] = "upstart",
    [".*/%.init/.*%.override"] = "upstart",
    [".*/LiteStep/.*/.*%.rc"] = "litestep",
    [".*/etc/.*limits%.conf"] = "limits",
    [".*/etc/.*limits%.d/.*%.conf"] = "limits",
    [".*/etc/a2ps/.*%.cfg"] = "a2ps",
    [".*/etc/apt/sources%.list%.d/.*%.list"] = "debsources",
    [".*/etc/httpd/.*%.conf"] = "apache",
    [".*/etc/init/.*%.conf"] = "upstart",
    [".*/etc/init/.*%.override"] = "upstart",
    [".*/etc/initng/.*/.*%.i"] = "initng",
    [".*/etc/ssh/ssh_config%.d/.*%.conf"] = "sshconfig",
    [".*/etc/ssh/sshd_config%.d/.*%.conf"] = "sshdconfig",
    [".*/etc/sysctl%.d/.*%.conf"] = "sysctl",
    ["/etc/gitconfig"] = "gitconfig",
    [".*/etc/systemd/.*%.conf%.d/.*%.conf"] = "systemd",
    [".*/etc/systemd/system/.*%.d/.*%.conf"] = "systemd",
    [".*/etc/udev/permissions%.d/.*%.permissions"] = "udevperm",
    [".*/etc/xdg/menus/.*%.menu"] = "xml",
    [".*/usr/.*/gnupg/options%.skel"] = "gpg",
    [".*/usr/share/upstart/.*%.conf"] = "upstart",
    [".*/usr/share/upstart/.*%.override"] = "upstart",
    [".*Eterm/.*%.cfg"] = "eterm",
    [".*enlightenment/.*%.cfg"] = "c",
    ["bzr_log%..*"] = "bzr",
    ["named.*%.conf"] = "named",
    ["rndc.*%.conf"] = "named",
    ["rndc.*%.key"] = "named",
}

M.star_sets = {
    [".*/etc/Muttrc%.d/.*"] = "muttrc",
    [".*/etc/proftpd/.*%.conf.*,.*/etc/proftpd/conf%..*/.*"] = "apachestyle",
    ["proftpd%.conf.*"] = "apachestyle",
    ["access%.conf.*,apache%.conf.*,apache2%.conf.*,httpd%.conf.*,srm%.conf.*"] = "apache",
    [".*/etc/apache2/.*%.conf.*,.*/etc/apache2/conf%..*/.*,.*/etc/apache2/mods-.*/.*,.*/etc/apache2/sites-.*/.*,.*/etc/httpd/conf%.d/.*%.conf.*"] = "apache",
    [".*asterisk/.*%.conf.*"] = "asterisk",
    [".*asterisk.*/.*voicemail%.conf.*"] = "asteriskvm",
    [".*/named/db%..*,.*/bind/db%..*"] = "bindzone",
    ["cabal%.project%..*"] = "cabalproject",
    ["crontab,crontab%..*,.*/etc/cron%.d/.*"] = "crontab",
    [".*/etc/dnsmasq%.d/.*"] = "dnsmasq",
    ["drac%..*"] = "dracula",
    [".*/%.fvwm/.*"] = "fvwm",
    [".*/tmp/lltmp.*"] = "gedcom",
    [".*/%.gitconfig%.d/.*,/etc/gitconfig%.d/.*"] = "gitconfig",
    [".*/gitolite-admin/conf/.*"] = "gitolite",
    ["%.gtkrc.*,gtkrc.*"] = "gtkrc",
    ["Prl.*%..*,JAM.*%..*"] = "jam",
    [".*%.properties_??_??_.*"] = "jproperties",
    ["Kconfig%..*"] = "kconfig",
    ["lilo%.conf.*"] = "lilo",
    [".*/etc/logcheck/.*%.d.*/.*"] = "logcheck",
    ["[mM]akefile.*"] = "make",
    ["[rR]akefile.*"] = "ruby",
    ["reportbug-.*"] = "mail",
    [".*/etc/modprobe%..*"] = "modconf",
    ["%.mutt{ng,}rc.*,.*/%.mutt{ng,}/mutt{ng,}rc.*"] = "muttrc",
    ["mutt{ng,}rc.*,Mutt{ng,}rc.*"] = "muttrc",
    ["%.neomuttrc.*,.*/%.neomutt/neomuttrc.*"] = "neomuttrc",
    ["neomuttrc.*,Neomuttrc.*"] = "neomuttrc",
    ["tmac%..*"] = "nroff",
    ["/etc/hostname%..*"] = "config",
    [".*/etc/pam%.d/.*"] = "pamconf",
    ["%.reminders.*"] = "remind",
    ["sgml%.catalog.*"] = "catalog",
    [".*%.vhdl_[0-9].*"] = "vhdl",
    [".*vimrc.*"] = "vim",
    ["Xresources.*,.*/app-defaults/.*,.*/Xresources/.*"] = "xdefaults",
    [".*xmodmap.*"] = "xmodmap",
    [".*/etc/xinetd%.d/.*"] = "xinetd",
    [".*/etc/yum%.repos%.d/.*"] = "dosini",
    ["%.zsh.*,%.zlog.*,%.zcompdump.*"] = "zsh",
    ["zsh.*,zlog.*"] = "zsh",
}
M.function_extensions = {
    ["*.inp"] = [[dist#ft#Check_inp()]],
    ["*.asm"] = [[dist#ft#FTasm()]],
    -- ["*.[sS]"] = [[dist#ft#FTasm()]],
    -- ["*.[aA]"] = [[dist#ft#FTasm()]],
    ["*.mac"] = [[dist#ft#FTasm()]],
    ["*.lst"] = [[dist#ft#FTasm()]],
    ["*.bas"] = [[dist#ft#FTVB("basic")]],
    ["*.btm"] = [[dist#ft#FTbtm()]],
    ["*.db"] = [[dist#ft#BindzoneCheck('')]],
    ["*.c"] = [[dist#ft#FTlpc()]],
    ["*.h"] = [[dist#ft#FTheader()]],
    ["*.ch"] = [[dist#ft#FTchange()]],
    ["*.ent"] = [[dist#ft#FTent()]],
    ["*.ex"] = [[dist#ft#ExCheck()]],
    ["*.eu"] = [[dist#ft#EuphoriaCheck()]],
    ["*.ew"] = [[dist#ft#EuphoriaCheck()]],
    ["*.exu"] = [[dist#ft#EuphoriaCheck()]],
    ["*.exw"] = [[dist#ft#EuphoriaCheck()]],
    ["*.EU"] = [[dist#ft#EuphoriaCheck()]],
    ["*.EW"] = [[dist#ft#EuphoriaCheck()]],
    ["*.EX"] = [[dist#ft#EuphoriaCheck()]],
    ["*.EXU"] = [[dist#ft#EuphoriaCheck()]],
    ["*.EXW"] = [[dist#ft#EuphoriaCheck()]],
    ["*.d"] = [[dist#ft#DtraceCheck()]],
    ["*.com"] = [[dist#ft#BindzoneCheck('dcl')]],
    ["*.e"] = [[dist#ft#FTe()]],
    ["*.E"] = [[dist#ft#FTe()]],
    ["*.html"] = [[dist#ft#FThtml()]],
    ["*.htm"] = [[dist#ft#FThtml()]],
    ["*.shtml"] = [[dist#ft#FThtml()]],
    ["*.stm"] = [[dist#ft#FThtml()]],
    ["*.idl"] = [[dist#ft#FTidl()]],
    ["*.pro"] = [[dist#ft#ProtoCheck('idlang')]],
    ["*.m"] = [[dist#ft#FTm()]],
    ["*.mms"] = [[dist#ft#FTmms()]],
    -- ["*.[1-9]"] = [[dist#ft#FTnroff()]],
    ["*.mm"] = [[dist#ft#FTmm()]],
    ["*.pp"] = [[dist#ft#FTpp()]],
    ["*.pl"] = [[dist#ft#FTpl()]],
    ["*.PL"] = [[dist#ft#FTpl()]],
    ["*.inc"] = [[dist#ft#FTinc()]],
    ["*.w"] = [[dist#ft#FTprogress_cweb()]],
    ["*.i"] = [[dist#ft#FTprogress_asm()]],
    ["*.p"] = [[dist#ft#FTprogress_pascal()]],
    ["*.r"] = [[dist#ft#FTr()]],
    ["*.R"] = [[dist#ft#FTr()]],
    ["*.mc"] = [[dist#ft#McSetf()]],
    ["*.ebuild"] = [[dist#ft#SetFileTypeSH("bash")]],
    ["*.bash"] = [[dist#ft#SetFileTypeSH("bash")]],
    ["*.eclass"] = [[dist#ft#SetFileTypeSH("bash")]],
    ["*.ksh"] = [[dist#ft#SetFileTypeSH("ksh")]],
    ["*/etc/profile"] = [[dist#ft#SetFileTypeSH(getline(1))]],
    ["*.sh"] = [[dist#ft#SetFileTypeSH(getline(1))]],
    ["*.env"] = [[dist#ft#SetFileTypeSH(getline(1))]],
    ["*.tcsh"] = [[dist#ft#SetFileTypeShell("tcsh")]],
    ["*.csh"] = [[dist#ft#CSH()]],
    ["*.rules"] = [[dist#ft#FTRules()]],
    ["*.sql"] = [[dist#ft#SQL()]],
    ["*.tex"] = [[dist#ft#FTtex()]],
    ["*.frm"] = [[dist#ft#FTVB("form")]],
    ["*.xml"] = [[dist#ft#FTxml()]],
    ["*.y"] = [[dist#ft#FTy()]],
    ["*.dtml"] = [[dist#ft#FThtml()]],
    ["*.pt"] = [[dist#ft#FThtml()]],
    ["*.cpt"] = [[dist#ft#FThtml()]],
    ["*.zsql"] = [[dist#ft#SQL()]],
}
M.function_simple = {
    ["indent.pro"] = [[dist#ft#ProtoCheck('indent')]],
    [".bashrc"] = [[dist#ft#SetFileTypeSH("bash")]],
    ["bashrc"] = [[dist#ft#SetFileTypeSH("bash")]],
    ["bash.bashrc"] = [[dist#ft#SetFileTypeSH("bash")]],
    ["PKGBUILD"] = [[dist#ft#SetFileTypeSH("bash")]],
    ["APKBUILD"] = [[dist#ft#SetFileTypeSH("bash")]],
    [".kshrc"] = [[dist#ft#SetFileTypeSH("ksh")]],
    [".profile"] = [[dist#ft#SetFileTypeSH(getline(1))]],
    [".tcshrc"] = [[dist#ft#SetFileTypeShell("tcsh")]],
    ["tcsh.tcshrc"] = [[dist#ft#SetFileTypeShell("tcsh")]],
    ["tcsh.login"] = [[dist#ft#SetFileTypeShell("tcsh")]],
    [".login"] = [[dist#ft#CSH()]],
    [".cshrc"] = [[dist#ft#CSH()]],
    ["csh.cshrc"] = [[dist#ft#CSH()]],
    ["csh.login"] = [[dist#ft#CSH()]],
    ["csh.logout"] = [[dist#ft#CSH()]],
    [".alias"] = [[dist#ft#CSH()]],
    [".d"] = [[dist#ft#SetFileTypeSH("bash")]],
}
M.function_complex = {
    [".bashrc*"] = [[dist#ft#SetFileTypeSH("bash")]],
    [".bash[_-]profile"] = [[dist#ft#SetFileTypeSH("bash")]],
    [".bash[_-]logout"] = [[dist#ft#SetFileTypeSH("bash")]],
    [".bash[_-]aliases"] = [[dist#ft#SetFileTypeSH("bash")]],
    [".bash-fc[_-]"] = [[dist#ft#SetFileTypeSH("bash")]],
    ["PKGBUILD*"] = [[dist#ft#SetFileTypeSH("bash")]],
    ["APKBUILD*"] = [[dist#ft#SetFileTypeSH("bash")]],
    [".kshrc*"] = [[dist#ft#SetFileTypeSH("ksh")]],
    [".profile*"] = [[dist#ft#SetFileTypeSH(getline(1))]],
    [".tcshrc*"] = [[dist#ft#SetFileTypeShell("tcsh")]],
    [".login*"] = [[dist#ft#CSH()]],
    [".cshrc*"] = [[dist#ft#CSH()]],
}

return M
