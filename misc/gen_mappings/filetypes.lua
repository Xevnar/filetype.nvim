local M = {}

M.filetypes = {
	[''] = {
		endswith = { '/debian/patches/series$' },
	},
	['8th'] = {
		extensions = { '8th' },
	},
	['a2ps'] = {
		complex = { '/etc/a2ps/.*%.cfg$' },
		endswith = { '/etc/a2ps%.cfg$' },
		literals = { 'a2psrc', '.a2psrc', '/etc/a2ps.cfg' },
	},
	['a65'] = {
		extensions = { 'a65' },
	},
	['aap'] = {
		extensions = { 'aap' },
	},
	['abap'] = {
		extensions = { 'abap' },
	},
	['abc'] = {
		extensions = { 'abc' },
	},
	['abel'] = {
		extensions = { 'abl' },
	},
	['acedb'] = {
		extensions = { 'wrm' },
	},
	['ada'] = {
		extensions = { 'ada', 'adb', 'ads', 'gpr' },
	},
	['ahdl'] = {
		extensions = { 'tdf' },
	},
	['aidl'] = {
		extensions = { 'aidl' },
	},
	['alsaconf'] = {
		endswith = { '/etc/asound%.conf$', '/usr/share/alsa/alsa%.conf$' },
		literals = { '.asoundrc', '/etc/asound.conf', '/usr/share/alsa/alsa.conf' },
	},
	['aml'] = {
		extensions = { 'aml' },
	},
	['ampl'] = {
		extensions = { 'run' },
	},
	['ant'] = {
		literals = { 'build.xml' },
	},
	['apache'] = {
		complex = { '/etc/httpd/.*%.conf$', '/etc/apache2/sites%-.*/.*%.com$' },
		literals = { '.htaccess' },
		starsets = {
			'^srm%.conf',
			'^httpd%.conf',
			'^access%.conf',
			'^apache%.conf',
			'^apache2%.conf',
			'/etc/httpd/conf%..*/',
			'/etc/httpd/mods%-.*/',
			'/etc/apache2/.*%.conf',
			'/etc/apache2/mods-.*/',
			'/etc/httpd/sites%-.*/',
			'/etc/apache2/conf%..*/',
			'/etc/apache2/mods%-.*/',
			'/etc/apache2/sites-.*/',
			'/etc/apache2/sites%-.*/',
			'/etc/httpd/conf%.d/.*%.conf',
		},
	},
	['apachestyle'] = {
		starsets = { '^proftpd%.conf', '/etc/proftpd/.*%.conf', '/etc/proftpd/conf%..*/' },
	},
	['applescript'] = {
		extensions = { 'scpt' },
	},
	['aptconf'] = {
		endswith = { '/%.aptitude/config$' },
		literals = { 'apt.conf', '/.aptitude/config' },
	},
	['arch'] = {
		literals = { '.arch-inventory', '=tagging-method' },
	},
	['arduino'] = {
		extensions = { 'ino', 'pde' },
	},
	['art'] = {
		extensions = { 'art' },
	},
	['asciidoc'] = {
		extensions = { 'adoc', 'asciidoc' },
	},
	['asn'] = {
		extensions = { 'asn', 'asn1' },
	},
	['asterisk'] = {
		starsets = { 'asterisk/.*%.conf' },
	},
	['asteriskvm'] = {
		starsets = { 'asterisk.*/.*voicemail%.conf' },
	},
	['astro'] = {
		extensions = { 'astro' },
	},
	['atlas'] = {
		extensions = { 'as', 'atl' },
	},
	['autohotkey'] = {
		extensions = { 'ahk' },
	},
	['autoit'] = {
		extensions = { 'au3' },
	},
	['automake'] = {
		literals = { 'Makefile.am', 'makefile.am', 'GNUmakefile.am' },
	},
	['ave'] = {
		extensions = { 'ave' },
	},
	['awk'] = {
		extensions = { 'awk', 'gawk' },
	},
	['b'] = {
		extensions = { 'imp', 'mch', 'ref' },
	},
	['bass'] = {
		extensions = { 'bass' },
	},
	['bc'] = {
		extensions = { 'bc' },
	},
	['bdf'] = {
		extensions = { 'bdf' },
	},
	['beancount'] = {
		extensions = { 'beancount' },
	},
	['bib'] = {
		extensions = { 'bib' },
	},
	['bicep'] = {
		extensions = { 'bicep' },
	},
	['bindzone'] = {
		literals = { 'named.root' },
		starsets = { '/bind/db%.', '/named/db%.' },
	},
	['bitbake'] = {
		complex = { '/meta/conf/.*%.conf$', '/build/conf/.*%.conf$', '/meta%-.*/conf/.*%.conf$' },
		extensions = { 'bb', 'bbclass', 'bbappend' },
	},
	['blank'] = {
		extensions = { 'bl' },
	},
	['blueprint'] = {
		extensions = { 'blp' },
	},
	['bsdl'] = {
		extensions = { 'bsd', 'bsdl' },
	},
	['bst'] = {
		extensions = { 'bst' },
	},
	['bzl'] = {
		extensions = { 'bzl', 'BUILD', 'bazel' },
		literals = { 'BUILD', 'WORKSPACE', 'WORKSPACE.bzlmod' },
	},
	['bzr'] = {
		starsets = { '^bzr_log%.' },
	},
	['c'] = {
		complex = { 'enlightenment/.*%.cfg$' },
		extensions = { 'qc' },
	},
	['cabal'] = {
		extensions = { 'cabal' },
	},
	['cabalconfig'] = {
		endswith = { '^${HOME}/cabal%.config$' },
		literals = { 'cabal.config' },
	},
	['cabalproject'] = {
		literals = { 'cabal.project' },
		starsets = { '^cabal%.project%.' },
	},
	['calendar'] = {
		literals = { 'calendar' },
		starsets = { '/%.calendar/', '/share/calendar/calendar%.', '/share/calendar/.*/calendar%.' },
	},
	['catalog'] = {
		literals = { 'catalog' },
		starsets = { '^sgml%.catalog' },
	},
	['capnp'] = {
		extensions = { 'capnp' },
	},
	['cdc'] = {
		extensions = { 'cdc' },
	},
	['cdl'] = {
		extensions = { 'cdl' },
	},
	['cdrdaoconf'] = {
		endswith = { '/etc/cdrdao%.conf$', '/etc/default/cdrdao$', '/etc/defaults/cdrdao$' },
		literals = { '.cdrdao', '/etc/cdrdao.conf', '/etc/default/cdrdao', '/etc/defaults/cdrdao' },
	},
	['cdrtoc'] = {
		extensions = { 'toc' },
	},
	['cf'] = {
		extensions = { 'cfc', 'cfi', 'cfm' },
	},
	['cfengine'] = {
		literals = { 'cfengine.conf' },
	},
	['cfg'] = {
		endswith = { 'hgrc$' },
		extensions = { 'hgrc' },
		literals = { 'hgrc' },
	},
	['ch'] = {
		extensions = { 'chf' },
	},
	['chaiscript'] = {
		extensions = { 'chai' },
	},
	['chaskell'] = {
		extensions = { 'chs' },
	},
	['chatito'] = {
		extensions = { 'chatito' },
	},
	['chill'] = {
		endswith = { '%.%.ch$' },
	},
	['chordpro'] = {
		extensions = { 'cho', 'crd', 'chopro', 'crdpro', 'chordpro' },
	},
	['cl'] = {
		extensions = { 'eni' },
	},
	['clean'] = {
		extensions = { 'dcl', 'icl' },
	},
	['clojure'] = {
		extensions = { 'clj', 'cljc', 'cljs', 'cljx' },
	},
	['cmake'] = {
		endswith = { '%.cmake%.in$' },
		extensions = { 'cmake' },
		literals = { 'cmake.in', 'CMakeLists.txt' },
	},
	['cmod'] = {
		extensions = { 'cmod' },
	},
	['cmusrc'] = {
		complex = { '/%.?cmus/.*%.theme$' },
		endswith = { '/%.?cmus/rc$', '/%.cmus/autosave$', '/%.cmus/command%-history$' },
	},
	['cobol'] = {
		extensions = { 'cbl', 'cob', 'lib' },
	},
	['coco'] = {
		extensions = { 'atg' },
	},
	['conaryrecipe'] = {
		extensions = { 'recipe' },
	},
	['conf'] = {
		complex = { '/etc/ufw/.*%.rules' },
		literals = { 'auto.master' },
	},
	['config'] = {
		literals = { 'configure.ac', 'configure.in' },
		starsets = { '/etc/hostname%.' },
	},
	['confini'] = {
		endswith = { '/%.aws/config$', '/etc/pacman%.conf$', '/%.aws/credentials$' },
		extensions = { 'nmconnection' },
		literals = { 'mpv.conf', '/etc/pacman.conf' },
	},
	['context'] = {
		complex = { '/tex/context/.*%.tex$' },
		extensions = { 'mkii', 'mkiv', 'mklx', 'mkvi', 'mkxl' },
	},
	['cook'] = {
		extensions = { 'cook' },
	},
	['cpon'] = {
		extensions = { 'cpon' },
	},
	['cpp'] = {
		extensions = { 'C', 'H', 'hh', 'c++', 'cxx', 'hpp', 'hxx', 'inl', 'ipp', 'moc', 'tcc', 'tlh' },
	},
	['cqlang'] = {
		extensions = { 'cql' },
	},
	['crm'] = {
		extensions = { 'crm' },
	},
	['crontab'] = {
		literals = { 'crontab' },
		starsets = { '^crontab%.', '/etc/cron%.d/' },
	},
	['cs'] = {
		extensions = { 'cs', 'csx' },
	},
	['csc'] = {
		extensions = { 'csc' },
	},
	['csdl'] = {
		extensions = { 'csdl' },
	},
	['csp'] = {
		extensions = { 'csp', 'fdr' },
	},
	['css'] = {
		extensions = { 'css' },
	},
	['csv'] = {
		extensions = { 'csv' },
	},
	['cterm'] = {
		extensions = { 'con' },
	},
	['cucumber'] = {
		extensions = { 'feature' },
	},
	['cuda'] = {
		extensions = { 'cu', 'cuh' },
	},
	['cue'] = {
		extensions = { 'cue' },
	},
	['cupl'] = {
		extensions = { 'pld' },
	},
	['cuplsim'] = {
		extensions = { 'si' },
	},
	['cvs'] = {
		starsets = { '^cvs%d+$' },
	},
	['cvsrc'] = {
		literals = { '.cvsrc' },
	},
	['cynpp'] = {
		extensions = { 'cyn' },
	},
	['dart'] = {
		extensions = { 'drt', 'dart' },
	},
	['datascript'] = {
		extensions = { 'ds' },
	},
	['dcd'] = {
		extensions = { 'dcd' },
	},
	['debchangelog'] = {
		endswith = { '/debian/changelog$' },
		literals = { 'NEWS.dch', 'NEWS.Debian', 'changelog.dch', 'changelog.Debian', '/debian/changelog' },
	},
	['debcontrol'] = {
		endswith = { '/debian/control$' },
		literals = { '/debian/control' },
	},
	['debcopyright'] = {
		endswith = { '/debian/copyright$' },
		literals = { '/debian/copyright' },
	},
	['debsources'] = {
		complex = { '/etc/apt/sources%.list%.d/.*%.list$' },
		endswith = { '/etc/apt/sources%.list$' },
		literals = { '/etc/apt/sources.list' },
	},
	['def'] = {
		extensions = { 'def' },
	},
	['denyhosts'] = {
		literals = { 'denyhosts.conf' },
	},
	['desc'] = {
		extensions = { 'desc' },
	},
	['desktop'] = {
		endswith = { '%.desktop$', '%.directory$' },
		extensions = { 'desktop', 'directory' },
	},
	['dhall'] = {
		extensions = { 'dhall' },
	},
	['dictconf'] = {
		literals = { '.dictrc', 'dict.conf' },
	},
	['dictdconf'] = {
		complex = { '^dictd.*%.conf$' },
		literals = { 'dictd.conf' },
	},
	['diff'] = {
		extensions = { 'rej', 'diff' },
	},
	['dircolors'] = {
		endswith = { '/etc/DIR_COLORS$' },
		literals = { '.dircolors', '.dir_colors', '/etc/DIR_COLORS' },
	},
	['dnsmasq'] = {
		endswith = { '/etc/dnsmasq%.conf$' },
		literals = { '/etc/dnsmasq.conf' },
		starsets = { '/etc/dnsmasq%.d/' },
	},
	['dockerfile'] = {
		extensions = { 'Dockerfile', 'dockerfile' },
		literals = { 'Dockerfile', 'dockerfile', 'Containerfile' },
		starsets = { '^Dockerfile%.', '^Containerfile%.' },
	},
	['dosbatch'] = {
		extensions = { 'bat' },
	},
	['dosini'] = {
		endswith = { '/etc/yum%.conf$' },
		extensions = { 'ini', 'wrap' },
		literals = { 'npmrc', '.npmrc', '/etc/yum.conf' },
		starsets = { '^php%.ini%-', '/etc/yum%.repos%.d/' },
	},
	['dot'] = {
		extensions = { 'gv', 'dot' },
	},
	['dracula'] = {
		endswith = { 'lpe$', 'lvs$' },
		extensions = { 'drc', 'drac' },
		literals = { 'drc' },
		starsets = { '^drac%.' },
	},
	['dtd'] = {
		extensions = { 'dtd' },
	},
	['dtrace'] = {
		complex = { '/dtrace/.*%.d$' },
	},
	['dts'] = {
		extensions = { 'dts', 'dtsi' },
	},
	['dune'] = {
		extensions = { 'dune' },
		literals = { 'dune', 'jbuild', 'dune-project', 'dune-workspace' },
	},
	['dylan'] = {
		extensions = { 'dylan' },
	},
	['dylanintr'] = {
		extensions = { 'intr' },
	},
	['dylanlid'] = {
		extensions = { 'lid' },
	},
	['ecd'] = {
		extensions = { 'ecd' },
	},
	['edif'] = {
		extensions = { 'edf', 'edo', 'edif' },
	},
	['editorconfig'] = {
		literals = { '.editorconfig' },
	},
	['eelixir'] = {
		extensions = { 'eex', 'leex' },
	},
	['elf'] = {
		extensions = { 'am' },
	},
	['elinks'] = {
		literals = { 'elinks.conf' },
	},
	['elixir'] = {
		extensions = { 'exs' },
		literals = { 'mix.lock' },
	},
	['elm'] = {
		extensions = { 'elm' },
	},
	['elmfilt'] = {
		literals = { 'filter-rules' },
	},
	['elsa'] = {
		extensions = { 'lc' },
	},
	['elvish'] = {
		extensions = { 'elv' },
	},
	['epuppet'] = {
		extensions = { 'epp' },
	},
	['erlang'] = {
		extensions = { 'erl', 'hrl', 'yaws' },
	},
	['eruby'] = {
		extensions = { 'erb', 'rhtml' },
	},
	['esmtprc'] = {
		endswith = { 'esmtprc$' },
	},
	['esqlc'] = {
		extensions = { 'EC', 'ec' },
	},
	['esterel'] = {
		extensions = { 'strl' },
	},
	['eterm'] = {
		complex = { 'Eterm/.*%.cfg$' },
	},
	['exim'] = {
		literals = { 'exim.conf' },
	},
	['expect'] = {
		extensions = { 'exp' },
	},
	['exports'] = {
		literals = { 'exports' },
	},
	['factor'] = {
		extensions = { 'factor' },
	},
	['falcon'] = {
		extensions = { 'fal' },
	},
	['fan'] = {
		extensions = { 'fan', 'fwt' },
	},
	['fennel'] = {
		extensions = { 'fnl' },
	},
	['fetchmail'] = {
		literals = { '.fetchmailrc' },
	},
	['fgl'] = {
		extensions = { '4gh', '4gl', 'm4gl' },
	},
	['firrtl'] = {
		extensions = { 'fir' },
	},
	['fish'] = {
		extensions = { 'fish' },
	},
	['flexwiki'] = {
		extensions = { 'wiki' },
	},
	['focexec'] = {
		extensions = { 'fex', 'focexec' },
	},
	['forth'] = {
		extensions = { 'ft', 'fth' },
	},
	['fortran'] = {
		extensions = {
			'F',
			'f',
			'F03',
			'F08',
			'F77',
			'F90',
			'F95',
			'FOR',
			'FPP',
			'FTN',
			'f03',
			'f08',
			'f77',
			'f90',
			'f95',
			'for',
			'fpp',
			'ftn',
			'fortran',
		},
	},
	['fpcmake'] = {
		extensions = { 'fpc' },
	},
	['framescript'] = {
		extensions = { 'fsl' },
	},
	['freebasic'] = {
		extensions = { 'fb' },
	},
	['fsh'] = {
		extensions = { 'fsh' },
	},
	['fsharp'] = {
		extensions = { 'fsi', 'fsx' },
	},
	['fstab'] = {
		literals = { 'mtab', 'fstab' },
	},
	['func'] = {
		extensions = { 'fc' },
	},
	['fusion'] = {
		extensions = { 'fusion' },
	},
	['gdb'] = {
		extensions = { 'gdb' },
		literals = { 'gdbinit', '.gdbinit', 'gdbearlyinit', '.gdbearlyinit' },
	},
	['gdmo'] = {
		extensions = { 'mo', 'gdmo' },
	},
	['gdresource'] = {
		extensions = { 'tres', 'tscn' },
	},
	['gdscript'] = {
		extensions = { 'gd' },
	},
	['gdshader'] = {
		extensions = { 'shader', 'gdshader' },
	},
	['gedcom'] = {
		extensions = { 'ged' },
		literals = { 'lltxxxxx.txt' },
		starsets = { '/tmp/lltmp' },
	},
	['gemtext'] = {
		extensions = { 'gmi', 'gemini' },
	},
	['gift'] = {
		extensions = { 'gift' },
	},
	['gitattributes'] = {
		endswith = {
			'/etc/gitattributes$',
			'%.git/info/attributes$',
			'/%.config/git/attributes$',
			'^${XDG_CONFIG_HOME}/git/attributes$',
		},
		literals = { '.gitattributes' },
	},
	['gitcommit'] = {
		literals = { 'MERGE_MSG', 'TAG_EDITMSG', 'NOTES_EDITMSG', 'COMMIT_EDITMSG', 'EDIT_DESCRIPTION' },
	},
	['gitconfig'] = {
		complex = { 'git/config$', '%.git/modules/.*/config$', '%.git/worktrees/.*/config%.worktree$' },
		endswith = {
			'%.git/config$',
			'/etc/gitconfig$',
			'%.git/modules/config$',
			'/%.config/git/config$',
			'%.git/config%.worktree$',
			'^${XDG_CONFIG_HOME}/git/config$',
		},
		literals = { 'gitconfig', '.gitconfig', '.gitmodules', '/etc/gitconfig' },
		starsets = { '/%.gitconfig%.d/', '/etc/gitconfig%.d/' },
	},
	['gitignore'] = {
		endswith = { '%.git/info/exclude$', '/%.config/git/ignore$', '^${XDG_CONFIG_HOME}/git/ignore$' },
		literals = { '.gitignore' },
	},
	['gitolite'] = {
		literals = { 'gitolite.conf' },
		starsets = { '/gitolite-admin/conf/', '/gitolite%-admin/conf/' },
	},
	['gitrebase'] = {
		literals = { 'git-rebase-todo' },
	},
	['gitsendemail'] = {
		endswith = { '^%.gitsendemail%.msg%.......$' },
	},
	['gkrellmrc'] = {
		endswith = { '^gkrellmrc_.$' },
		literals = { 'gkrellmrc' },
	},
	['gleam'] = {
		extensions = { 'gleam' },
	},
	['glsl'] = {
		extensions = { 'glsl' },
	},
	['gnash'] = {
		literals = { 'gnashrc', '.gnashrc', 'gnashpluginrc', '.gnashpluginrc' },
	},
	['gnuplot'] = {
		extensions = { 'gpi' },
		literals = { '.gnuplot' },
	},
	['go'] = {
		extensions = { 'go' },
	},
	['gomod'] = {
		literals = { 'go.mod' },
	},
	['gosum'] = {
		literals = { 'go.sum', 'go.work.sum' },
	},
	['gowork'] = {
		literals = { 'go.work' },
	},
	['gp'] = {
		extensions = { 'gp' },
		literals = { '.gprc' },
	},
	['gpg'] = {
		complex = { '/usr/.*/gnupg/options%.skel$' },
		endswith = {
			'/%.gnupg/options$',
			'/%.gnupg/gpg.conf$',
			'/%.gnupg/gpg%.conf$',
			'^${GNUPGHOME}/options$',
			'^${GNUPGHOME}/gpg%.conf$',
		},
		literals = { '/.gnupg/options', '/.gnupg/gpg.conf' },
	},
	['grads'] = {
		extensions = { 'gs' },
	},
	['graphql'] = {
		extensions = { 'gql', 'graphql', 'graphqls' },
	},
	['gretl'] = {
		extensions = { 'gretl' },
	},
	['groovy'] = {
		extensions = { 'gradle', 'groovy', 'Jenkinsfile' },
	},
	['group'] = {
		endswith = {
			'/etc/group$',
			'/etc/group%-$',
			'/etc/gshadow$',
			'/etc/gshadow%-$',
			'/etc/group%.edit$',
			'/etc/gshadow%.edit$',
			'/var/backups/group$',
			'/var/backups/gshadow$',
		},
		literals = {
			'/etc/group',
			'/etc/group-',
			'/etc/gshadow',
			'/etc/gshadow-',
			'/etc/group.edit',
			'/etc/gshadow.edit',
			'/var/backups/group',
			'/var/backups/gshadow',
		},
	},
	['grub'] = {
		endswith = { '/etc/grub%.conf$', '/boot/grub/menu%.lst$', '/boot/grub/grub%.conf$' },
		literals = { '/etc/grub.conf', '/boot/grub/menu.lst', '/boot/grub/grub.conf' },
	},
	['gsp'] = {
		extensions = { 'gsp' },
	},
	['gtkrc'] = {
		literals = { 'gtkrc', '.gtkrc' },
		starsets = { '^%.?gtkrc' },
	},
	['gyp'] = {
		extensions = { 'gyp', 'gypi' },
	},
	['hack'] = {
		extensions = { 'hack', 'hackpartial' },
	},
	['haml'] = {
		extensions = { 'haml' },
	},
	['hamster'] = {
		extensions = { 'hsm' },
	},
	['handlebars'] = {
		extensions = { 'hbs' },
	},
	['hare'] = {
		extensions = { 'ha' },
	},
	['haskell'] = {
		extensions = { 'hs', 'hsc', 'hsig', 'hs-boot' },
		literals = { 'hs-boot' },
	},
	['haste'] = {
		extensions = { 'ht' },
	},
	['hastepreproc'] = {
		extensions = { 'htpp' },
	},
	['haxe'] = {
		extensions = { 'hx' },
	},
	['hb'] = {
		extensions = { 'hb' },
	},
	['hcl'] = {
		extensions = { 'hcl' },
	},
	['heex'] = {
		extensions = { 'heex' },
	},
	['help'] = {
		complex = { '^${VIMRUNTIME}/doc/.*%.txt$' },
	},
	['hercules'] = {
		extensions = { 'ev', 'vc', 'sum', 'errsum' },
	},
	['hex'] = {
		extensions = { 'h32', 'hex' },
	},
	['hgcommit'] = {
		complex = { '^hg%-editor%-.*%.txt$' },
	},
	['hjson'] = {
		extensions = { 'hjson' },
	},
	['hlsplaylist'] = {
		extensions = { 'm3u', 'm3u8' },
	},
	['hog'] = {
		extensions = { 'hog' },
		literals = { 'snort.conf', 'vision.conf' },
	},
	['hollywood'] = {
		extensions = { 'hws' },
	},
	['hoon'] = {
		extensions = { 'hoon' },
	},
	['hostconf'] = {
		endswith = { '/etc/host%.conf$' },
		literals = { '/etc/host.conf' },
	},
	['hostsaccess'] = {
		endswith = { '/etc/hosts%.deny$', '/etc/hosts%.allow$' },
		literals = { '/etc/hosts.deny', '/etc/hosts.allow' },
	},
	['html'] = {
		extensions = { 'cshtml' },
	},
	['htmlm4'] = {
		endswith = { '%.html%.m4$' },
		literals = { 'html.m4' },
	},
	['httest'] = {
		extensions = { 'htb', 'htt' },
	},
	['hxml'] = {
		extensions = { 'hxml' },
	},
	['i3config'] = {
		endswith = { '/i3/config$', '/%.i3/config$' },
	},
	['ibasic'] = {
		extensions = { 'iba', 'ibi' },
	},
	['icemenu'] = {
		endswith = { '/%.icewm/menu$' },
		literals = { '/.icewm/menu' },
	},
	['icon'] = {
		extensions = { 'icn' },
	},
	['indent'] = {
		literals = { 'indentrc', '.indent.pro' },
	},
	['inform'] = {
		extensions = { 'INF', 'inf' },
	},
	['initng'] = {
		complex = { '/etc/initng/.*/.*%.i$' },
		extensions = { 'ii' },
	},
	['inittab'] = {
		literals = { 'inittab' },
	},
	['ipfilter'] = {
		literals = { 'ipf.conf', 'ipf.rules', 'ipf6.conf' },
	},
	['iss'] = {
		extensions = { 'iss' },
	},
	['ist'] = {
		extensions = { 'ist', 'mst' },
	},
	['j'] = {
		extensions = { 'ijs' },
	},
	['jal'] = {
		extensions = { 'JAL', 'jal' },
	},
	['jam'] = {
		extensions = { 'jpl', 'jpr' },
		starsets = { '^JAM.*%.', '^Prl.*%.' },
	},
	['java'] = {
		extensions = { 'jav', 'java' },
	},
	['javacc'] = {
		extensions = { 'jj', 'jjt' },
	},
	['javascript'] = {
		complex = { '/etc/polkit%-1/rules%.d/.*%.rules', '/usr/share/polkit%-1/rules%.d/.*%.rules' },
		extensions = { 'es', 'js', 'cjs', 'jsm', 'mjs', 'javascript' },
	},
	['javascript.glimmer'] = {
		extensions = { 'gjs' },
	},
	['javascriptreact'] = {
		extensions = { 'jsx' },
	},
	['jess'] = {
		extensions = { 'clp' },
	},
	['jgraph'] = {
		extensions = { 'jgr' },
	},
	['jovial'] = {
		extensions = { 'j73', 'jov', 'jovial' },
	},
	['jproperties'] = {
		complex = { '^org%.eclipse%..*%.prefs$' },
		endswith = { '%.properties_..$', '%.properties_.._..$' },
		extensions = { 'properties' },
		starsets = { '%.properties_.._.._', '%.properties_??_??_' },
	},
	['jq'] = {
		extensions = { 'jq' },
	},
	['json'] = {
		extensions = { 'json', 'slnf', 'ipynb', 'jsonp', 'json-patch', 'webmanifest' },
		literals = {
			'json-patch',
			'.firebaserc',
			'.prettierrc',
			'.stylelintrc',
			'Pipfile.lock',
		},
	},
	['json5'] = {
		extensions = { 'json5' },
	},
	['jsonc'] = {
		complex = { '^[jt]sconfig.*%.json$' },
		extensions = { 'jsonc' },
		literals = {
			'.swrc',
			'.hintrc',
			'.babelrc',
			'.jsfmtrc',
			'.eslintrc',
			'.jshintrc',
		},
	},
	['jsonnet'] = {
		extensions = { 'jsonnet', 'libsonnet' },
	},
	['jsp'] = {
		extensions = { 'jsp' },
	},
	['julia'] = {
		extensions = { 'jl' },
	},
	['kconfig'] = {
		literals = { 'Kconfig', 'Kconfig.debug' },
		starsets = { '^Kconfig%.' },
	},
	['kdl'] = {
		extensions = { 'kdl' },
	},
	['kivy'] = {
		extensions = { 'kv' },
	},
	['kix'] = {
		extensions = { 'kix' },
	},
	['kotlin'] = {
		extensions = { 'kt', 'ktm', 'kts' },
	},
	['krl'] = {
		extensions = { 'SUB', 'SUb', 'SuB', 'Sub', 'sUB', 'sUb', 'suB', 'sub' },
	},
	['kscript'] = {
		extensions = { 'ks' },
	},
	['kwt'] = {
		extensions = { 'k' },
	},
	['lace'] = {
		extensions = { 'ACE', 'ace' },
	},
	['latte'] = {
		extensions = { 'lte', 'latte' },
	},
	['ld'] = {
		extensions = { 'ld' },
	},
	['ldif'] = {
		extensions = { 'ldif' },
	},
	['ledger'] = {
		extensions = { 'ldg', 'ledger', 'journal' },
	},
	['less'] = {
		extensions = { 'less' },
	},
	['lex'] = {
		extensions = { 'l', 'l++', 'lex', 'lxx' },
	},
	['lftp'] = {
		endswith = { 'lftp/rc$' },
		literals = { '.lftprc', 'lftp.conf' },
	},
	['lhaskell'] = {
		extensions = { 'lhs' },
	},
	['libao'] = {
		endswith = { '/%.libao$', '/etc/libao%.conf$' },
		literals = { '/.libao', '/etc/libao.conf' },
	},
	['lifelines'] = {
		extensions = { 'll' },
	},
	['lilo'] = {
		literals = { 'lilo.conf' },
		starsets = { '^lilo%.conf' },
	},
	['lilypond'] = {
		extensions = { 'ly', 'ily' },
	},
	['limits'] = {
		complex = { '/etc/.*limits%.conf$', '/etc/.*limits%.d/.*%.conf$' },
		endswith = { '/etc/limits$' },
		literals = { '/etc/limits' },
	},
	['liquid'] = {
		extensions = { 'liquid' },
	},
	['lisp'] = {
		extensions = { 'L', 'cl', 'el', 'asd', 'lsp', 'lisp' },
		literals = { '.emacs', 'sbclrc', '.sbclrc', '.sawfishrc' },
	},
	['lite'] = {
		extensions = { 'lt', 'lite' },
	},
	['litestep'] = {
		complex = { '/LiteStep/.*/.*%.rc$' },
	},
	['logcheck'] = {
		starsets = { '/etc/logcheck/.*%.d.*/' },
	},
	['loginaccess'] = {
		endswith = { '/etc/login%.access$' },
		literals = { '/etc/login.access' },
	},
	['logindefs'] = {
		endswith = { '/etc/login%.defs$' },
		literals = { '/etc/login.defs' },
	},
	['logtalk'] = {
		extensions = { 'lgt' },
	},
	['lotos'] = {
		extensions = { 'lot', 'lotos' },
	},
	['lout'] = {
		extensions = { 'lou', 'lout' },
	},
	['lpc'] = {
		extensions = { 'lpc', 'ulpc' },
	},
	['lss'] = {
		extensions = { 'lss' },
	},
	['lua'] = {
		extensions = { 'lua', 'nse', 'rockspec' },
		literals = { '.luacheckrc' },
	},
	['lynx'] = {
		literals = { 'lynx.cfg' },
	},
	['lyrics'] = {
		extensions = { 'lrc' },
		literals = { 'lrc' },
	},
	['m3build'] = {
		literals = { 'm3makefile', 'm3overrides' },
	},
	['m3quake'] = {
		extensions = { 'quake' },
		literals = { 'cm3.cfg' },
	},
	['m4'] = {
		extensions = { 'at', 'm4' },
	},
	['mail'] = {
		complex = { '^mutt%-.*%-%w+$', '^muttng%-.*%-%w+$', '^neomutt%-.*%-%w+$' },
		endswith = {
			'^snd%.%d+$',
			'^pico%.%d+$',
			'^ae%d+%.txt$',
			'^%.letter%.%d+$',
			'^%.article%.%d+$',
			'^/tmp/SLRN[0-9A-Z.]+$',
			'^mutt[%w_-][%w_-][%w_-][%w_-][%w_-][%w_-]$',
			'^neomutt[%w_-][%w_-][%w_-][%w_-][%w_-][%w_-]$',
		},
		extensions = { 'eml' },
		literals = { '.letter', '.article', '.followup' },
		starsets = { '^reportbug-', '^reportbug%-' },
	},
	['mailaliases'] = {
		endswith = { '/etc/aliases$', '/etc/mail/aliases$' },
		literals = { '/etc/aliases', '/etc/mail/aliases' },
	},
	['mailcap'] = {
		literals = { 'mailcap', '.mailcap' },
	},
	['make'] = {
		endswith = { '[mM]akefile$' },
		extensions = { 'mk', 'dsp', 'mak' },
		starsets = { '^[mM]akefile' },
	},
	['mallard'] = {
		extensions = { 'page' },
	},
	['manconf'] = {
		endswith = { '/etc/man%.conf$' },
		literals = { 'man.config', '/etc/man.conf' },
	},
	['map'] = {
		extensions = { 'map' },
	},
	['maple'] = {
		extensions = { 'mv', 'mpl', 'mws' },
	},
	['markdown'] = {
		extensions = { 'md', 'mkd', 'mdwn', 'mkdn', 'mdown', 'markdown' },
	},
	['mason'] = {
		extensions = { 'comp', 'mason', 'mhtml' },
	},
	['master'] = {
		extensions = { 'mas', 'master' },
	},
	['maxima'] = {
		extensions = { 'dm1', 'dm2', 'dm3', 'dmt', 'wxm', 'demo' },
		literals = { 'maxima-init.mac' },
	},
	['mel'] = {
		extensions = { 'mel' },
	},
	['mermaid'] = {
		extensions = { 'mmd', 'mmdc', 'mermaid' },
	},
	['meson'] = {
		literals = { 'meson.build', 'meson_options.txt' },
	},
	['messages'] = {
		endswith = {
			'/log/lpr$',
			'/log/auth$',
			'/log/cron$',
			'/log/kern$',
			'/log/mail$',
			'/log/user$',
			'/log/debug$',
			'/log/daemon$',
			'/log/syslog$',
			'/log/lpr%.err$',
			'/log/lpr%.log$',
			'/log/messages$',
			'/log/auth%.err$',
			'/log/auth%.log$',
			'/log/cron%.err$',
			'/log/cron%.log$',
			'/log/kern%.err$',
			'/log/kern%.log$',
			'/log/lpr%.crit$',
			'/log/lpr%.info$',
			'/log/lpr%.warn$',
			'/log/mail%.err$',
			'/log/mail%.log$',
			'/log/news/news$',
			'/log/user%.err$',
			'/log/user%.log$',
			'/log/auth%.crit$',
			'/log/auth%.info$',
			'/log/auth%.warn$',
			'/log/cron%.crit$',
			'/log/cron%.info$',
			'/log/cron%.warn$',
			'/log/debug%.err$',
			'/log/debug%.log$',
			'/log/kern%.crit$',
			'/log/kern%.info$',
			'/log/kern%.warn$',
			'/log/mail%.crit$',
			'/log/mail%.info$',
			'/log/mail%.warn$',
			'/log/user%.crit$',
			'/log/user%.info$',
			'/log/user%.warn$',
			'/log/daemon%.err$',
			'/log/daemon%.log$',
			'/log/debug%.crit$',
			'/log/debug%.info$',
			'/log/debug%.warn$',
			'/log/lpr%.notice$',
			'/log/syslog%.err$',
			'/log/syslog%.log$',
			'/log/auth%.notice$',
			'/log/cron%.notice$',
			'/log/daemon%.crit$',
			'/log/daemon%.info$',
			'/log/daemon%.warn$',
			'/log/kern%.notice$',
			'/log/mail%.notice$',
			'/log/syslog%.crit$',
			'/log/syslog%.info$',
			'/log/syslog%.warn$',
			'/log/user%.notice$',
			'/log/debug%.notice$',
			'/log/messages%.err$',
			'/log/messages%.log$',
			'/log/daemon%.notice$',
			'/log/messages%.crit$',
			'/log/messages%.info$',
			'/log/messages%.warn$',
			'/log/news/news%.err$',
			'/log/news/news%.log$',
			'/log/syslog%.notice$',
			'/log/news/news%.crit$',
			'/log/news/news%.info$',
			'/log/news/news%.warn$',
			'/log/messages%.notice$',
			'/log/news/news%.notice$',
		},
	},
	['mf'] = {
		extensions = { 'mf' },
	},
	['mgl'] = {
		extensions = { 'mgl' },
	},
	['mgp'] = {
		extensions = { 'mgp' },
	},
	['mib'] = {
		extensions = { 'my', 'mib' },
	},
	['mix'] = {
		extensions = { 'mix', 'mixal' },
	},
	['mma'] = {
		extensions = { 'nb' },
	},
	['mmp'] = {
		extensions = { 'mmp' },
	},
	['modconf'] = {
		endswith = { '/etc/modules$', '/etc/conf%.modules$', '/etc/modules%.conf$' },
		literals = { '/etc/modules', '/etc/conf.modules', '/etc/modules.conf' },
		starsets = { '/etc/modprobe%.' },
	},
	['modula2'] = {
		extensions = { 'm2', 'mi', 'DEF' },
	},
	['modula3'] = {
		extensions = { 'i3', 'ig', 'm3', 'mg', 'lm3' },
	},
	['monk'] = {
		extensions = { 'isc', 'ssc', 'tsc', 'monk' },
	},
	['moo'] = {
		extensions = { 'moo' },
	},
	['moonscript'] = {
		extensions = { 'moon' },
	},
	['move'] = {
		extensions = { 'move' },
	},
	['mplayerconf'] = {
		endswith = { '/%.mplayer/config$' },
		literals = { 'mplayer.conf', '/.mplayer/config' },
	},
	['mrxvtrc'] = {
		literals = { 'mrxvtrc', '.mrxvtrc' },
	},
	['msidl'] = {
		extensions = { 'mof', 'odl' },
	},
	['msql'] = {
		extensions = { 'msql' },
	},
	['mupad'] = {
		extensions = { 'mu' },
	},
	['mush'] = {
		extensions = { 'mush' },
	},
	['muttrc'] = {
		complex = { '/etc/Muttrc%.d/.*%.rc$' },
		literals = { 'Muttrc', 'Muttngrc' },
		starsets = {
			'^Muttrc',
			'^Muttngrc',
			'^%.?muttrc',
			'^%.?muttngrc',
			'/%.mutt/muttrc',
			'/etc/Muttrc%.d/',
			'/%.muttng/muttrc',
			'/%.muttng/muttngrc',
		},
	},
	['mysql'] = {
		extensions = { 'mysql' },
	},
	['n1ql'] = {
		extensions = { 'nql', 'n1ql' },
	},
	['named'] = {
		complex = { '^rndc.*%.key$', '^rndc.*%.conf$', '^named.*%.conf$' },
	},
	['nanorc'] = {
		endswith = { '/etc/nanorc$' },
		extensions = { 'nanorc' },
		literals = { 'nanorc', '/etc/nanorc' },
	},
	['natural'] = {
		endswith = { '%.NS[ACGLMNPS]$' },
	},
	['ncf'] = {
		extensions = { 'ncf' },
	},
	['neomuttrc'] = {
		literals = { 'Neomuttrc' },
		starsets = { '^Neomuttrc', '^%.?neomuttrc', '/%.neomutt/neomuttrc' },
	},
	['netrc'] = {
		literals = { '.netrc' },
	},
	['nginx'] = {
		complex = { '^nginx.*%.conf$', '/nginx/.*%.conf$' },
		endswith = { 'nginx%.conf$' },
		extensions = { 'nginx' },
		starsets = { '/etc/nginx/', '/usr/local/nginx/conf/' },
	},
	['nim'] = {
		extensions = { 'nim', 'nims', 'nimble' },
	},
	['ninja'] = {
		extensions = { 'ninja' },
	},
	['nix'] = {
		extensions = { 'nix' },
	},
	['nqc'] = {
		extensions = { 'nqc' },
	},
	['nroff'] = {
		extensions = { 'nr', 'tr', 'man', 'mom', 'roff', 'tmac' },
		starsets = { '^tmac%.' },
	},
	['nsis'] = {
		extensions = { 'nsh', 'nsi' },
	},
	['obj'] = {
		extensions = { 'obj' },
	},
	['obse'] = {
		extensions = { 'obl', 'obse', 'oblivion', 'obscript' },
	},
	['ocaml'] = {
		endswith = { '%.ml%.cppo$', '%.mli%.cppo$', '%.mli?%.cppo$' },
		extensions = { 'ml', 'mli', 'mll', 'mlp', 'mlt', 'mly', 'mlip' },
		literals = { '.ocamlinit' },
	},
	['occam'] = {
		extensions = { 'occ' },
	},
	['octave'] = {
		literals = { 'octaverc', '.octaverc', 'octave.conf' },
	},
	['odin'] = {
		extensions = { 'odin' },
	},
	['omnimark'] = {
		extensions = { 'xin', 'xom' },
	},
	['opam'] = {
		endswith = { '%.opam%.template$' },
		extensions = { 'opam' },
		literals = { 'opam', 'opam.template' },
	},
	['openroad'] = {
		extensions = { 'or' },
	},
	['openscad'] = {
		extensions = { 'scad' },
	},
	['openvpn'] = {
		complex = { '/openvpn/.*/.*%.conf$' },
		extensions = { 'ovpn' },
	},
	['opl'] = {
		extensions = { 'OPL', 'OPl', 'OpL', 'Opl', 'oPL', 'oPl', 'opL', 'opl' },
	},
	['ora'] = {
		extensions = { 'ora' },
	},
	['org'] = {
		extensions = { 'org', 'org_archive' },
		literals = { 'org_archive' },
	},
	['pamconf'] = {
		endswith = { '/etc/pam%.conf$' },
		literals = { '/etc/pam.conf' },
		starsets = { '/etc/pam%.d/' },
	},
	['pamenv'] = {
		literals = { 'pam_env.conf', '.pam_environment' },
	},
	['papp'] = {
		extensions = { 'papp', 'pxml', 'pxsl' },
	},
	['pascal'] = {
		extensions = { 'dpr', 'lpr', 'pas' },
	},
	['passwd'] = {
		endswith = {
			'/etc/passwd$',
			'/etc/shadow$',
			'/etc/passwd%-$',
			'/etc/shadow%-$',
			'/etc/passwd%.edit$',
			'/etc/shadow%.edit$',
			'/var/backups/passwd$',
			'/var/backups/shadow$',
		},
		literals = {
			'/etc/passwd',
			'/etc/shadow',
			'/etc/passwd-',
			'/etc/shadow-',
			'/etc/passwd.edit',
			'/etc/shadow.edit',
			'/var/backups/passwd',
			'/var/backups/shadow',
		},
	},
	['pbtxt'] = {
		extensions = { 'pbtxt' },
	},
	['pccts'] = {
		extensions = { 'g' },
	},
	['pcmk'] = {
		extensions = { 'pcmk' },
	},
	['pdf'] = {
		extensions = { 'pdf' },
	},
	['perl'] = {
		endswith = { '^%.?gitolite%.rc$', '^example%.gitolite%.rc$' },
		extensions = { 'al', 'plx', 'psgi' },
		literals = { 'latexmkrc', '.latexmkrc' },
	},
	['pf'] = {
		literals = { 'pf.conf' },
	},
	['pfmain'] = {
		literals = { 'main.cf', 'main.cf.proto' },
	},
	['php'] = {
		extensions = {
			'ctp',
			'php',
			'php0',
			'php1',
			'php2',
			'php3',
			'php4',
			'php5',
			'php6',
			'php7',
			'php8',
			'php9',
			'phpt',
			'phtml',
			'theme',
		},
	},
	['pike'] = {
		extensions = { 'pike', 'pmod' },
	},
	['pilrc'] = {
		extensions = { 'rcp' },
	},
	['pine'] = {
		literals = { 'pinerc', '.pinerc', 'pinercex', '.pinercex' },
	},
	['pinfo'] = {
		endswith = { '/%.pinforc$', '/etc/pinforc$' },
		literals = { '/.pinforc', '/etc/pinforc' },
	},
	['pli'] = {
		extensions = { 'pl1', 'pli' },
	},
	['plm'] = {
		extensions = { 'p36', 'pac', 'plm' },
	},
	['plp'] = {
		extensions = { 'plp' },
	},
	['plsql'] = {
		extensions = { 'pls', 'plsql' },
	},
	['po'] = {
		extensions = { 'po', 'pot' },
	},
	['pod'] = {
		extensions = { 'pod' },
	},
	['poefilter'] = {
		extensions = { 'filter' },
	},
	['poke'] = {
		extensions = { 'pk' },
	},
	['postscr'] = {
		extensions = { 'ai', 'ps', 'afm', 'eps', 'pfa', 'epsf', 'epsi' },
	},
	['pov'] = {
		extensions = { 'pov' },
	},
	['povini'] = {
		literals = { '.povrayrc' },
	},
	['ppd'] = {
		extensions = { 'ppd' },
	},
	['ppwiz'] = {
		extensions = { 'ih', 'it' },
	},
	['prisma'] = {
		extensions = { 'prisma' },
	},
	['privoxy'] = {
		extensions = { 'action' },
	},
	['proc'] = {
		extensions = { 'pc' },
	},
	['procmail'] = {
		literals = { '.procmail', '.procmailrc' },
	},
	['prolog'] = {
		extensions = { 'pdb' },
	},
	['promela'] = {
		extensions = { 'pml' },
	},
	['proto'] = {
		extensions = { 'proto' },
	},
	['protocols'] = {
		endswith = { '/etc/protocols$' },
		literals = { '/etc/protocols' },
	},
	['prql'] = {
		extensions = { 'prql' },
	},
	['ps1'] = {
		extensions = { 'ps1', 'psd1', 'psm1', 'pssc' },
	},
	['ps1xml'] = {
		extensions = { 'ps1xml' },
	},
	['psf'] = {
		extensions = { 'psf' },
	},
	['psl'] = {
		extensions = { 'psl' },
	},
	['pug'] = {
		extensions = { 'pug' },
	},
	['pyret'] = {
		extensions = { 'arr' },
	},
	['pyrex'] = {
		extensions = { 'pxd', 'pyx' },
	},
	['python'] = {
		extensions = { 'py', 'ptl', 'pyi', 'pyw' },
		literals = { '.pythonrc', 'SConstruct', '.pythonstartup' },
	},
	['ql'] = {
		extensions = { 'ql', 'qll' },
	},
	['quake'] = {
		complex = { 'id1/.*%.cfg$', 'baseq[2-3]/.*%.cfg$', 'quake[1-3]/.*%.cfg$' },
	},
	['quarto'] = {
		extensions = { 'qmd' },
	},
	['query'] = {
		complex = { '/queries/.*%.scm$' },
	},
	['r'] = {
		literals = { 'Rprofile', '.Rprofile', 'Rprofile.site' },
	},
	['radiance'] = {
		extensions = { 'mat', 'rad' },
	},
	['raku'] = {
		extensions = { 'p6', 't6', 'pm6', 'pod6', 'raku', 'rakudoc', 'rakumod', 'rakutest' },
	},
	['raml'] = {
		extensions = { 'raml' },
	},
	['ratpoison'] = {
		literals = { 'ratpoisonrc', '.ratpoisonrc' },
	},
	['rbs'] = {
		extensions = { 'rbs' },
	},
	['rc'] = {
		extensions = { 'rc', 'rch' },
	},
	['rcs'] = {
		endswith = { ',v$' },
	},
	['readline'] = {
		literals = { 'inputrc', '.inputrc' },
	},
	['rego'] = {
		extensions = { 'rego' },
	},
	['remind'] = {
		extensions = { 'rem', 'remind' },
		literals = { '.reminders' },
		starsets = { '^%.reminders' },
	},
	['rescript'] = {
		extensions = { 'res', 'resi' },
	},
	['resolv'] = {
		literals = { 'resolv.conf' },
	},
	['reva'] = {
		extensions = { 'frt' },
	},
	['rexx'] = {
		extensions = { 'orx', 'rex', 'rxj', 'rxo', 'rexx', 'jrexx', 'rexxj', 'testUnit', 'testGroup' },
	},
	['rhelp'] = {
		extensions = { 'Rd', 'rd' },
	},
	['rib'] = {
		extensions = { 'rib' },
	},
	['rmd'] = {
		extensions = { 'Rmd', 'Smd', 'rmd', 'smd' },
	},
	['rnc'] = {
		extensions = { 'rnc' },
	},
	['rng'] = {
		extensions = { 'rng' },
	},
	['rnoweb'] = {
		extensions = { 'Rnw', 'Snw', 'rnw', 'snw' },
	},
	['robot'] = {
		extensions = { 'robot', 'resource' },
	},
	['robots'] = {
		literals = { 'robots.txt' },
	},
	['ron'] = {
		extensions = { 'ron' },
	},
	['routeros'] = {
		extensions = { 'rsc' },
	},
	['rpcgen'] = {
		extensions = { 'x' },
	},
	['rpgle'] = {
		extensions = { 'rpgle', 'rpgleinc' },
	},
	['rpl'] = {
		extensions = { 'rpl' },
	},
	['rrst'] = {
		extensions = { 'Rrst', 'Srst', 'rrst', 'srst' },
	},
	['rst'] = {
		extensions = { 'rst' },
	},
	['rtf'] = {
		extensions = { 'rtf' },
	},
	['ruby'] = {
		endswith = {},
		extensions = {
			'rb',
			'ru',
			'rbw',
			'rjs',
			'rake',
			'rant',
			'rxml',
			'Appfile',
			'Podfile',
			'builder',
			'gemspec',
			'Brewfile',
			'Fastfile',
		},
		literals = {
			'irbrc',
			'.irbrc',
			'Gemfile',
			'Rakefile',
			'Rantfile',
			'rakefile',
			'rantfile',
			'Puppetfile',
			'Vagrantfile',
		},
		starsets = { '^[rR]akefile' },
	},
	['rust'] = {
		extensions = { 'rs' },
	},
	['samba'] = {
		literals = { 'smb.conf' },
	},
	['sas'] = {
		extensions = { 'sas' },
	},
	['sass'] = {
		extensions = { 'sass' },
	},
	['sather'] = {
		extensions = { 'sa' },
	},
	['sbt'] = {
		extensions = { 'sbt' },
	},
	['scala'] = {
		extensions = { 'scala' },
	},
	['scheme'] = {
		extensions = { 'ss', 'rkt', 'scm', 'sld', 'rktd', 'rktl' },
	},
	['scilab'] = {
		extensions = { 'sce', 'sci' },
	},
	['screen'] = {
		literals = { 'screenrc', '.screenrc' },
	},
	['scss'] = {
		extensions = { 'scss' },
	},
	['sd'] = {
		extensions = { 'sd' },
	},
	['sdc'] = {
		extensions = { 'sdc' },
	},
	['sdl'] = {
		extensions = { 'pr', 'sdl' },
	},
	['sed'] = {
		extensions = { 'sed' },
	},
	['sensors'] = {
		endswith = { '/etc/sensors%.conf$', '/etc/sensors3%.conf$' },
		literals = { '/etc/sensors.conf', '/etc/sensors3.conf' },
		starsets = { '/etc/sensors%.d/[^.]' },
	},
	['services'] = {
		endswith = { '/etc/services$' },
		literals = { '/etc/services' },
	},
	['setserial'] = {
		endswith = { '/etc/serial%.conf$' },
		literals = { '/etc/serial.conf' },
	},
	['sexplib'] = {
		extensions = { 'sexp' },
	},
	['sh'] = {
		endswith = { '/etc/udev/cdsymlinks%.conf$' },
		literals = { '/etc/udev/cdsymlinks.conf' },
	},
	['sieve'] = {
		extensions = { 'siv', 'sieve' },
	},
	['simula'] = {
		extensions = { 'sim' },
	},
	['sinda'] = {
		extensions = { 's85', 'sin' },
	},
	['sisu'] = {
		endswith = { '%.[_%-]?sst%.meta$' },
		extensions = { 'ssi', 'ssm', 'sst', '-sst', '_sst' },
	},
	['skill'] = {
		extensions = { 'il', 'cdf', 'ils' },
	},
	['slang'] = {
		extensions = { 'sl' },
	},
	['slice'] = {
		extensions = { 'ice' },
	},
	['slpconf'] = {
		endswith = { '/etc/slp%.conf$' },
		literals = { '/etc/slp.conf' },
	},
	['slpreg'] = {
		endswith = { '/etc/slp%.reg$' },
		literals = { '/etc/slp.reg' },
	},
	['slpspi'] = {
		endswith = { '/etc/slp%.spi$' },
		literals = { '/etc/slp.spi' },
	},
	['slrnrc'] = {
		literals = { '.slrnrc' },
	},
	['slrnsc'] = {
		extensions = { 'score' },
	},
	['sm'] = {
		literals = { 'sendmail.cf' },
	},
	['smali'] = {
		extensions = { 'smali' },
	},
	['smarty'] = {
		extensions = { 'tpl' },
	},
	['smcl'] = {
		extensions = { 'hlp', 'ihlp', 'smcl' },
	},
	['smith'] = {
		extensions = { 'smt', 'smith' },
	},
	['smithy'] = {
		extensions = { 'smithy' },
	},
	['sml'] = {
		extensions = { 'sml' },
	},
	['snobol4'] = {
		extensions = { 'sno', 'spt' },
	},
	['solidity'] = {
		extensions = { 'sol' },
	},
	['solution'] = {
		extensions = { 'sln' },
	},
	['sparql'] = {
		extensions = { 'rq', 'sparql' },
	},
	['spec'] = {
		extensions = { 'spec' },
	},
	['spice'] = {
		extensions = { 'sp', 'spice' },
	},
	['spup'] = {
		extensions = { 'spd', 'spdata', 'speedup' },
	},
	['spyce'] = {
		extensions = { 'spi', 'spy' },
	},
	['sql'] = {
		extensions = { 'pkb', 'pks', 'tyb', 'tyc', 'typ' },
	},
	['sqlj'] = {
		extensions = { 'sqlj' },
	},
	['sqr'] = {
		extensions = { 'sqi', 'sqr' },
	},
	['squid'] = {
		literals = { 'squid.conf' },
	},
	['squirrel'] = {
		extensions = { 'nut' },
	},
	['srec'] = {
		extensions = { 'mot', 's19', 's28', 's37', 'srec' },
	},
	['srt'] = {
		extensions = { 'srt' },
	},
	['ssa'] = {
		extensions = { 'ass', 'ssa' },
	},
	['sshconfig'] = {
		complex = { '/%.ssh/.*%.conf$', '/etc/ssh/ssh_config%.d/.*%.conf$' },
		endswith = { '/%.ssh/config$' },
		literals = { 'ssh_config' },
	},
	['sshdconfig'] = {
		complex = { '/etc/ssh/sshd_config%.d/.*%.conf$' },
		literals = { 'sshd_config' },
	},
	['st'] = {
		extensions = { 'st' },
	},
	['starlark'] = {
		extensions = { 'ipd', 'star', 'starlark' },
	},
	['stata'] = {
		extensions = { 'do', 'ado', 'mata', 'imata' },
	},
	['stp'] = {
		extensions = { 'stp' },
	},
	['sudoers'] = {
		endswith = { '/etc/sudoers$' },
		literals = { 'sudoers.tmp', '/etc/sudoers' },
		starsets = { '/etc/sudoers%.d/' },
	},
	['supercollider'] = {
		extensions = { 'quark' },
	},
	['surface'] = {
		extensions = { 'sface' },
	},
	['svelte'] = {
		extensions = { 'svelte' },
	},
	['svg'] = {
		extensions = { 'svg' },
	},
	['svn'] = {
		complex = { '^svn%-commit.*%.tmp$' },
	},
	['swayconfig'] = {
		endswith = { '/sway/config$', '/%.sway/config$' },
	},
	['swift'] = {
		extensions = { 'swift' },
	},
	['swiftgyb'] = {
		endswith = { '%.swift%.gyb$' },
		literals = { 'swift.gyb' },
	},
	['sysctl'] = {
		complex = { '/etc/sysctl%.d/.*%.conf$' },
		endswith = { '/etc/sysctl%.conf$' },
		literals = { '/etc/sysctl.conf' },
	},
	['systemd'] = {
		complex = {
			'/systemd/.*%.link$',
			'/systemd/.*%.path$',
			'/systemd/.*%.swap$',
			'/systemd/.*%.dnssd$',
			'/systemd/.*%.mount$',
			'/systemd/.*%.slice$',
			'/systemd/.*%.timer$',
			'/systemd/.*%.netdev$',
			'/systemd/.*%.nspawn$',
			'/systemd/.*%.socket$',
			'/systemd/.*%.target$',
			'/systemd/.*%.network$',
			'/systemd/.*%.service$',
			'/systemd/.*%.automount$',
			'/etc/systemd/.*%.conf%.d/.*%.conf$',
			'/etc/systemd/system/.*%.d/.*%.conf$',
			'/%.config/systemd/user/.*%.d/.*%.conf$',
		},
		extensions = { 'service' },
		starsets = {
			'/etc/systemd/system/%.#',
			'/%.config/systemd/user/%.#',
			'/etc/systemd/system/.*%.d/%.#',
			'/%.config/systemd/user/.*%.d/%.#',
		},
	},
	['systemverilog'] = {
		extensions = { 'sv', 'svh' },
	},
	['tags'] = {
		literals = { 'tags' },
	},
	['tak'] = {
		extensions = { 'tak' },
	},
	['tal'] = {
		extensions = { 'tal' },
	},
	['taskdata'] = {
		literals = { 'undo.data', 'pending.data', 'completed.data' },
	},
	['taskedit'] = {
		extensions = { 'task' },
	},
	['tcl'] = {
		extensions = { 'tk', 'tm', 'itk', 'tcl', 'itcl', 'jacl' },
		literals = { '.wishrc', '.tclshrc', 'tclsh.rc' },
	},
	['teal'] = {
		extensions = { 'tl' },
	},
	['template'] = {
		extensions = { 'tmpl' },
	},
	['terminfo'] = {
		extensions = { 'ti' },
	},
	['terraform-vars'] = {
		extensions = { 'tfvars' },
	},
	['tex'] = {
		extensions = { 'bbl', 'dtx', 'ltx', 'sty', 'latex' },
	},
	['texinfo'] = {
		extensions = { 'txi', 'texi', 'texinfo' },
	},
	['texmf'] = {
		literals = { 'texmf.cnf' },
	},
	['text'] = {
		extensions = { 'txt', 'text' },
		literals = { 'README', 'AUTHORS', 'COPYING', 'LICENSE' },
	},
	['tf'] = {
		literals = { 'tfrc', '.tfrc' },
	},
	['thrift'] = {
		extensions = { 'thrift' },
	},
	['tidy'] = {
		literals = { 'tidyrc', '.tidyrc', 'tidy.conf' },
	},
	['tilde'] = {
		endswith = { '%.t%.html$' },
		literals = { 't.html' },
	},
	['tla'] = {
		extensions = { 'tla' },
	},
	['tli'] = {
		extensions = { 'tli' },
	},
	['tmux'] = {
		complex = { '^%.tmux.*%.conf$', '^%.?tmux.*%.conf$' },
		literals = { '.tmux.conf' },
		starsets = { '^%.?tmux.*%.conf' },
	},
	['toml'] = {
		endswith = { '/%.cargo/config$', '/%.cargo/credentials$' },
		extensions = { 'lock', 'toml' },
		literals = { 'Pipfile', 'Cargo.lock', 'Gopkg.lock', '/.cargo/config', '/.cargo/credentials' },
	},
	['tpp'] = {
		extensions = { 'tpp' },
	},
	['treetop'] = {
		extensions = { 'treetop' },
	},
	['trustees'] = {
		literals = { 'trustees.conf' },
	},
	['tsalt'] = {
		extensions = { 'slt' },
	},
	['tsscl'] = {
		extensions = { 'tsscl' },
	},
	['tssgm'] = {
		extensions = { 'tssgm' },
	},
	['tssop'] = {
		extensions = { 'tssop' },
	},
	['tsv'] = {
		extensions = { 'tsv' },
	},
	['tutor'] = {
		extensions = { 'tutor' },
	},
	['twig'] = {
		extensions = { 'twig' },
	},
	['typescript'] = {
		extensions = { 'cts', 'mts' },
	},
	['typescript.glimmer'] = {
		extensions = { 'gts' },
	},
	['typescriptreact'] = {
		extensions = { 'tsx' },
	},
	['uc'] = {
		extensions = { 'uc' },
	},
	['udevconf'] = {
		endswith = { '/etc/udev/udev%.conf$' },
		literals = { '/etc/udev/udev.conf' },
	},
	['udevperm'] = {
		complex = { '/etc/udev/permissions%.d/.*%.permissions$' },
	},
	['udevrules'] = {
		complex = { '/etc/udev/.*%.rules$', '/lib/udev/.*%.rules$' },
	},
	['uil'] = {
		extensions = { 'uil', 'uit' },
	},
	['ungrammar'] = {
		extensions = { 'ungram' },
	},
	['updatedb'] = {
		endswith = { '/etc/updatedb%.conf$' },
		literals = { '/etc/updatedb.conf' },
	},
	['upstart'] = {
		complex = {
			'/%.init/.*%.conf$',
			'/etc/init/.*%.conf$',
			'/%.init/.*%.override$',
			'/etc/init/.*%.override$',
			'/%.config/upstart/.*%.conf$',
			'/usr/share/upstart/.*%.conf$',
			'/%.config/upstart/.*%.override$',
			'/usr/share/upstart/.*%.override$',
		},
	},
	['upstreamdat'] = {
		complex = {
			'%.?[uU][pP][sS][tT][rR][eE][aA][mM]%.[dD][aA][tT]$',
			'[uU][pP][sS][tT][rR][eE][aA][mM]%..*%.[dD][aA][tT]$',
		},
	},
	['upstreaminstalllog'] = {
		complex = {
			'%.?[uU][pP][sS][tT][rR][eE][aA][mM][iI][nN][sS][tT][aA][lL][lL]%.[lL][oO][gG]$',
			'[uU][pP][sS][tT][rR][eE][aA][mM][iI][nN][sS][tT][aA][lL][lL]%..*%.[lL][oO][gG]$',
		},
	},
	['upstreamlog'] = {
		complex = {
			'%.?[uU][pP][sS][tT][rR][eE][aA][mM]%.[lL][oO][gG]$',
			'[uU][pP][sS][tT][rR][eE][aA][mM]%-.*%.[lL][oO][gG]$',
			'[uU][pP][sS][tT][rR][eE][aA][mM]%..*%.[lL][oO][gG]$',
		},
		literals = { 'fdrupstream.log' },
	},
	['usserverlog'] = {
		complex = {
			'%.?[uU][sS][sS][eE][rR][vV][eE][rR]%.[lL][oO][gG]$',
			'[uU][sS][sS][eE][rR][vV][eE][rR]%..*%.[lL][oO][gG]$',
		},
	},
	['usw2kagtlog'] = {
		complex = {
			'%.?[uU][sS][wW]2[kK][aA][gG][tT]%.[lL][oO][gG]$',
			'[uU][sS][wW]2[kK][aA][gG][tT]%..*%.[lL][oO][gG]$',
		},
	},
	['vala'] = {
		extensions = { 'vala' },
	},
	['vb'] = {
		extensions = { 'vb', 'ctl', 'dsm', 'sba', 'vbs' },
	},
	['vdf'] = {
		extensions = { 'vdf' },
	},
	['vdmpp'] = {
		extensions = { 'vpp', 'vdmpp' },
	},
	['vdmrt'] = {
		extensions = { 'vdmrt' },
	},
	['vdmsl'] = {
		extensions = { 'vdm', 'vdmsl' },
	},
	['vera'] = {
		extensions = { 'vr', 'vrh', 'vri' },
	},
	['verilog'] = {
		extensions = { 'v' },
	},
	['verilogams'] = {
		extensions = { 'va', 'vams' },
	},
	['vgrindefs'] = {
		literals = { 'vgrindefs' },
	},
	['vhdl'] = {
		extensions = { 'hdl', 'vbe', 'vhd', 'vho', 'vst', 'vhdl' },
		starsets = { '%.vhdl_[0-9]' },
	},
	['vhs'] = {
		extensions = { 'tape' },
	},
	['vim'] = {
		extensions = { 'vba', 'vim' },
		literals = { '.exrc', '_exrc' },
		starsets = { 'vimrc' },
	},
	['viminfo'] = {
		literals = { '.viminfo', '_viminfo' },
	},
	['vmasm'] = {
		extensions = { 'mar' },
	},
	['voscm'] = {
		extensions = { 'cm' },
	},
	['vrml'] = {
		extensions = { 'wrl' },
	},
	['vroom'] = {
		extensions = { 'vroom' },
	},
	['vue'] = {
		extensions = { 'vue' },
	},
	['wast'] = {
		extensions = { 'wat', 'wast' },
	},
	['wdl'] = {
		extensions = { 'wdl' },
	},
	['webmacro'] = {
		extensions = { 'wm' },
	},
	['wget'] = {
		literals = { 'wgetrc', '.wgetrc' },
	},
	['wget2'] = {
		literals = { 'wget2rc', '.wget2rc' },
	},
	['winbatch'] = {
		extensions = { 'wbt' },
	},
	['wml'] = {
		extensions = { 'wml' },
	},
	['wsh'] = {
		extensions = { 'wsc', 'wsf' },
	},
	['wsml'] = {
		extensions = { 'wsml' },
	},
	['wvdial'] = {
		literals = { '.wvdialrc', 'wvdial.conf' },
	},
	['xdefaults'] = {
		extensions = { 'ad' },
		literals = { '.Xdefaults', 'xdm-config', '.Xpdefaults', '.Xresources' },
		starsets = { '^Xresources', '/Xresources/', '/app-defaults/', '/app%-defaults/' },
	},
	['xhtml'] = {
		extensions = { 'xht', 'xhtml' },
	},
	['xinetd'] = {
		endswith = { '/etc/xinetd%.conf$' },
		literals = { '/etc/xinetd.conf' },
		starsets = { '/etc/xinetd%.d/' },
	},
	['xmath'] = {
		extensions = { 'msc', 'msf' },
	},
	['xml'] = {
		complex = { '/etc/xdg/menus/.*%.menu$' },
		endswith = {
			'%.csproj%.user$',
			'%.fsproj%.user$',
			'%.vbproj%.user$',
			'/etc/blkid%.tab$',
			'/etc/blkid%.tab.old$',
			'/etc/blkid%.tab%.old$',
		},
		extensions = {
			'ui',
			'mpd',
			'rss',
			'tpm',
			'wpl',
			'xlf',
			'xmi',
			'xul',
			'atom',
			'psc1',
			'wsdl',
			'cdxml',
			'xliff',
			'csproj',
			'fsproj',
			'vbproj',
		},
		literals = { 'fglrxrc', '/etc/blkid.tab', '/etc/blkid.tab.old' },
	},
	['xmodmap'] = {
		endswith = { 'Xmodmap$' },
		starsets = { 'xmodmap' },
	},
	['xpm2'] = {
		extensions = { 'xpm2' },
	},
	['xquery'] = {
		extensions = { 'xq', 'xql', 'xqm', 'xqy', 'xquery' },
	},
	['xs'] = {
		extensions = { 'xs' },
	},
	['xsd'] = {
		extensions = { 'xsd' },
	},
	['xslt'] = {
		extensions = { 'xsl', 'xslt' },
	},
	['yacc'] = {
		extensions = { 'yy', 'y++', 'yxx' },
	},
	['yaml'] = {
		extensions = { 'bu', 'yml', 'yaml' },
		literals = { '.clangd', '.clang-tidy', '.clang-format', '_clang-format' },
	},
	['yang'] = {
		extensions = { 'yang' },
	},
	['yuck'] = {
		extensions = { 'yuck' },
	},
	['z8a'] = {
		extensions = { 'z8a' },
	},
	['zig'] = {
		extensions = { 'zig' },
	},
	['zimbu'] = {
		extensions = { 'zu' },
	},
	['zimbutempl'] = {
		extensions = { 'zut' },
	},
	['zir'] = {
		extensions = { 'zir' },
	},
	['zsh'] = {
		endswith = { '/etc/zprofile$' },
		extensions = { 'zsh' },
		literals = {
			'.zshrc',
			'.zlogin',
			'.zshenv',
			'.zlogout',
			'.zprofile',
			'.zcompdump',
			'.zfbfmarks',
			'/etc/zprofile',
		},
		starsets = { '^%.?zsh', '^%.?zlog', '^%.?zcompdump' },
	},
}

-- This table stores filetype that require a function to detect
M.conflicts = {
	-- {
	-- 	 -- For documentation, not neccassary
	-- 	 conflicting_filetypes = {},

	-- 	 -- Conflicts
	-- 	 complex = { },
	-- 	 endswith = { },
	-- 	 extensions = { },
	-- 	 literals = { },
	-- 	 starsets = { },

	-- 	 -- Resolution function, must be a function formatted as a string
	-- 	 resolution = [[]],
	-- },

	{
		conflicting_filetypes = { 'sh' },

		endswith = { '/etc/profile$' },
		extensions = { 'sh', 'env' },
		literals = { '.profile', '/etc/profile' },
		starsets = { '^%.profile' },

		resolution = [[function()
		return detect.sh('sh', true)
	end]],
	},

	{
		conflicting_filetypes = { 'bash' },

		extensions = { 'ebuild', 'bash', 'eclass' },
		literals = {
			'.d',
			'bashrc',
			'.bashrc',
			'.bash_profile',
			'.bash-profile',
			'.bash_logout',
			'.bash-logout',
			'.bash_aliases',
			'.bash-aliases',
			'.bash-fc_',
			'.bash-fc-',
			'bash.bashrc',
			'PKGBUILD',
			'APKBUILD',
		},
		starsets = { '^%.bashrc', '^PKGBUILD', '^APKBUILD' },

		resolution = [[function()
		return detect.sh('bash')
	end]],
	},

	{
		conflicting_filetypes = { 'sh', 'csh', 'tcsh' },

		extensions = { 'csh' },
		literals = { '.alias', '.cshrc', '.login', 'csh.cshrc', 'csh.login', 'csh.logout' },
		starsets = { '^%.login', '^%.cshrc' },

		resolution = [[function()
		return detect.csh()
	end]],
	},

	{
		conflicting_filetypes = { 'ksh' },

		extensions = { 'ksh' },
		literals = { '.kshrc' },
		starsets = { '^%.kshrc' },

		resolution = [[function()
		return detect.sh('ksh')
	end]],
	},

	{
		conflicting_filetypes = { 'tcsh' },

		extensions = { 'tcsh' },
		literals = { '.tcshrc', 'tcsh.login', 'tcsh.tcshrc' },
		starsets = { '^%.tcshrc' },

		resolution = [[function()
		return detect.sh('tcsh')
	end]],
	},

	{
		conflicting_filetypes = { 'abaqus', 'trasys' },

		extensions = { 'inp' },

		resolution = [[function()
		return detect.inp()
	end]],
	},

	{
		conflicting_filetypes = { 'asm', 'vasm' },

		extensions = { 'a', 'A', 's', 'S', 'asm', 'lst', 'mac' },

		resolution = [[function()
		return detect.asm()
	end]],
	},

	{
		conflicting_filetypes = { 'asm', 'php', 'pov', 'vasm', 'aspvbs', 'pascal', 'aspperl', 'bitbake' },

		extensions = { 'inc' },

		resolution = [[function()
		return detect.inc()
	end]],
	},

	{
		conflicting_filetypes = { 'aspvbs' },

		extensions = { 'asa' },

		resolution = [[function()
		return (vim.g.filetype_asa and vim.g.filetype_asa) or 'aspvbs'
	end]],
	},

	{
		conflicting_filetypes = { 'aspvbs', 'aspperl' },

		extensions = { 'asp' },

		resolution = [[function()
		if vim.g.filetype_asp then
			return vim.g.filetype_asp
		end

		if util.getlines_as_string(0, detect.line_limit, ' '):find('perlscript') then
			return 'aspperl'
		end

		return 'aspvbs'
	end]],
	},

	{
		conflicting_filetypes = { 'bindzone' },

		extensions = { 'db' },

		resolution = [[function()
		return detect.bindzone()
	end]],
	},

	{
		conflicting_filetypes = { 'dcl', 'bindzone' },

		extensions = { 'com' },

		resolution = [[function()
		return detect.bindzone() or 'dcl'
	end]],
	},

	{
		conflicting_filetypes = { 'btm', 'dosbatch' },

		extensions = { 'btm' },

		resolution = [[function()
		if vim.g.dosbatch_syntax_for_btm and vim.g.dosbatch_syntax_for_btm ~= 0 then
			return 'dosbatch'
		end

		return 'btm'
	end]],
	},

	{
		conflicting_filetypes = { 'c', 'lpc' },

		extensions = { 'c' },

		resolution = [[function()
		return detect.lpc()
	end]],
	},

	{
		conflicting_filetypes = { 'c', 'ch', 'cpp', 'objc', 'objcpp' },

		extensions = { 'h' },

		resolution = [[function()
		return detect.header()
	end]],
	},

	{
		conflicting_filetypes = { 'ch', 'chill', 'change' },

		extensions = { 'ch' },

		resolution = [[function()
		return detect.change()
	end]],
	},

	{
		conflicting_filetypes = { 'changelog', 'debchangelog' },

		literals = { 'NEWS' },
		starsets = { '^[cC]hange[lL]og' },

		resolution = [[function()
		return (util.getline():find('%; urgency%=') and 'debchangelog') or 'changelog'
	end]],
	},

	{
		conflicting_filetypes = { 'cobol', 'python' },

		extensions = { 'cpy' },

		resolution = [[function()
		return (util.getline():find('^##') and 'python') or 'cobol'
	end]],
	},

	{
		conflicting_filetypes = { 'conf' },

		extensions = { 'hook' },

		resolution = [[function()
		return util.getline() == '[Trigger]' and 'conf'
	end]],
	},

	{

		conflicting_filetypes = { 'cpp', 'cynlib' },

		extensions = { 'cc', 'cpp' },

		resolution = [[function()
		return (vim.g.cynlib_syntax_for_cc and 'cynlib') or 'cpp'
	end]],
	},

	{
		conflicting_filetypes = { 'cpp', 'idlang', 'prolog' },

		extensions = { 'pro' },

		resolution = [[function()
		return detect.proto() or 'idlang'
	end]],
	},

	{
		conflicting_filetypes = { 'cpp', 'indent', 'prolog' },

		literals = { 'indent.pro' },

		resolution = [[function()
		return detect.proto() or 'indent'
	end]],
	},

	{
		conflicting_filetypes = { 'd', 'dtrace' },

		extensions = { 'd' },

		resolution = [[function()
		return detect.dtrace()
	end]],
	},

	{
		conflicting_filetypes = { 'debcontrol' },

		literals = { 'control' },

		resolution = [[function()
		return util.getline():find('^Source%:') and 'debcontrol'
	end]],
	},

	{
		conflicting_filetypes = { 'dep3patch' },

		starsets = { '/debian/patches/' },

		resolution = [[function()
		return detect.dep3patch()
	end]],
	},

	{
		conflicting_filetypes = { 'diff', 'gitsendmail' },

		extensions = { 'patch' },

		resolution = [[function()
		return detect.patch()
	end]],
	},

	{
		conflicting_filetypes = { 'diva', 'ishd' },

		extensions = { 'rul' },

		resolution = [[function()
		return (util.getlines_as_string(0, detect.line_limit):find('InstallShield') and 'ishd') or 'diva'
	end]],
	},

	{
		conflicting_filetypes = { 'dsl', 'structurizr' },

		extensions = { 'dsl' },

		resolution = [[function()
		return (util.getline():find('^%s*<!') and 'dsl') or 'structurizr'
	end]],
	},

	{
		conflicting_filetypes = { 'edif', 'clojure' },

		extensions = { 'edn' },

		resolution = [[function()
		return (util.getline():find('^%s*%(%s*edif') and 'edif') or 'clojure'
	end]],
	},

	{
		conflicting_filetypes = { 'eiffel', 'specman' },

		extensions = { 'e', 'E', 'ent' },

		resolution = [[function()
		return detect.eiffel_check()
	end]],
	},

	{
		conflicting_filetypes = { 'elixir', 'euphoria3' },

		extensions = { 'ex' },

		resolution = [[function()
		return detect.elixir_check()
	end]],
	},

	{
		conflicting_filetypes = { 'euphoria3' },

		extensions = { 'eu', 'ew', 'exu', 'exw', 'EU', 'EW', 'EX', 'EXU', 'EXW' },

		resolution = [[function()
		return (vim.g.filetype_euphoria and vim.g.filetype_euphoria) or 'euphoria3'
	end]],
	},

	{
		conflicting_filetypes = { 'foam' },

		literals = { 'fvModels', 'fvSchemes', 'fvSolution', 'fvConstraints' },
		complex = { '/constant/g$', '^[a-zA-Z0-9].*Dict$', '^[a-zA-Z].*Properties$' },
		starsets = { '/0/', '/0%.orig/', '^[a-zA-Z0-9].*Dict%.', '^[a-zA-Z].*Properties%.', 'Transport%.' },

		resolution = [[function()
		return detect.foam()
	end]],
	},

	{
		conflicting_filetypes = { 'forth', 'fsharp' },

		extensions = { 'fs' },

		resolution = [[function()
		return detect.fs()
	end]],
	},

	{
		conflicting_filetypes = { 'fvwm' },

		endswith = { 'fvwmrc$', 'fvwm95%.hook$' },
		extensions = { 'fvwmrc' },
		literals = { 'fvwmrc' },
		starsets = { 'fvwmrc', '/%.fvwm/' },

		resolution = [[function()
		vim.b.fvwm_version = 1
		return 'fvwm'
	end]],
	},

	{
		conflicting_filetypes = { 'fvwm' },

		endswith = { 'fvwm2rc$' },
		extensions = { 'fvwm2rc' },
		literals = { 'fvwm2rc' },
		starsets = { 'fvwm2rc' },

		resolution = [[function()
		vim.b.fvwm_version = 2
		return 'fvwm'
	end]],
	},

	{
		conflicting_filetypes = { 'fvwm2m4' },

		complex = { 'fvwm2rc.*%.m4$' },

		resolution = [[function()
		return 'fvwm2m4'
	end]],
	},

	{
		conflicting_filetypes = { 'git' },

		starsets = { '%.git/' },

		resolution = [=[function()
		local line = util.getline()
		if util.match_vim_regex(line, [[^\x\{40,\}\>\|^ref: ]]) then
			return 'git'
		end
	end]=],
	},

	{
		conflicting_filetypes = { 'hog', 'udevrules' },

		extensions = { 'rules' },

		resolution = [[function(args)
		return detect.rules(args.file_path)
	end]],
	},

	{
		conflicting_filetypes = { 'html', 'xhtml', 'htmldjango' },

		extensions = { 'pt', 'cpt', 'htm', 'stm', 'dtml', 'html', 'shtml' },

		resolution = [[function()
		return detect.html()
	end]],
	},

	{
		conflicting_filetypes = { 'idl', 'msidl' },

		extensions = { 'idl' },

		resolution = [[function()
		return detect.idl()
	end]],
	},

	{
		conflicting_filetypes = { 'krl' },

		extensions = { 'src', 'srC', 'sRc', 'sRC', 'Src', 'SrC', 'SRc', 'SRC' },

		resolution = [[function()
		return detect.src()
	end]],
	},

	{
		conflicting_filetypes = { 'krl' },

		extensions = { 'dat', 'daT', 'dAt', 'dAT', 'Dat', 'DaT', 'DAt', 'DAT' },

		resolution = [[function()
		return detect.dat()
	end]],
	},

	{
		conflicting_filetypes = { 'lsl', 'larch' },

		extensions = { 'lsl' },

		resolution = [[function()
		return detect.lsl()
	end]],
	},

	{
		conflicting_filetypes = { 'm4', 'msmessages' },

		extensions = { 'mc' },

		resolution = [[function()
		return detect.mc()
	end]],
	},

	{
		conflicting_filetypes = { 'make', 'mmix' },

		extensions = { 'mms' },

		resolution = [[function()
		return detect.mms()
	end]],
	},

	{
		conflicting_filetypes = { 'mib', 'smil' },

		extensions = { 'smi' },

		resolution = [[function()
		return (util.getline():find('smil') and 'smil') or 'mib'
	end]],
	},

	{
		conflicting_filetypes = { 'mma', 'objc', 'matlab', 'murphi', 'octave' },

		extensions = { 'm' },

		resolution = [[function()
		return detect.m()
	end]],
	},

	{
		conflicting_filetypes = { 'mp' },

		extensions = { 'mp', 'mpiv', 'mpvi', 'mpxl' },

		resolution = [[function()
		vim.b.mp_metafun = 1
		return 'mp'
	end]],
	},

	{
		conflicting_filetypes = { 'nroff' },

		extensions = { 'me' },

		resolution = [[function(args)
		if args.file_name ~= 'read.me' and args.file_name ~= 'click.me' then
			return 'nroff'
		end
	end]],
	},

	{
		conflicting_filetypes = { 'nroff', 'xmath' },

		extensions = { 'ms' },

		resolution = [[function()
		return detect.nroff() or 'xmath'
	end]],
	},

	{
		conflicting_filetypes = { 'nroff', 'objcpp' },

		extensions = { 'mm' },

		resolution = [[function()
		return detect.mm()
	end]],
	},

	{
		conflicting_filetypes = { 'tads', 'perl', 'nroff' },

		extensions = { 't' },

		resolution = [[function(args)
		return detect.nroff() or detect.perl(args.file_path, args.file_ext) or 'tads'
	end]],
	},

	{
		conflicting_filetypes = { 'pascal', 'puppet' },

		extensions = { 'pp' },

		resolution = [[function()
		return detect.pp()
	end]],
	},

	{
		conflicting_filetypes = { 'perl', 'prolog' },

		extensions = { 'pl', 'PL' },

		resolution = [[function()
		return detect.pl()
	end]],
	},

	{
		conflicting_filetypes = { 'php', 'bash' },

		extensions = { 'install' },

		resolution = [[function()
		return (util.getline():find('%<%?php') and 'php') or detect.sh('bash')
	end]],
	},

	{
		conflicting_filetypes = { 'php', 'virata' },

		extensions = { 'hw', 'pkg', 'module' },

		resolution = [[function()
		return (util.getline():find('%<%?php') and 'php') or 'virata'
	end]],
	},

	{
		conflicting_filetypes = { 'cweb', 'progress' },

		extensions = { 'w' },

		resolution = [[function()
		return detect.progress_cweb()
	end]],
	},

	{
		conflicting_filetypes = { 'asm', 'vasm', 'progress' },

		extensions = { 'i' },

		resolution = [[function()
		return detect.progress_asm()
	end]],
	},

	{
		conflicting_filetypes = { 'pascal', 'progress' },

		extensions = { 'p' },

		resolution = [[function()
		return detect.progress_pascal()
	end]],
	},

	{
		conflicting_filetypes = { 'psf' },

		literals = { 'INFO', 'INDEX' },

		resolution = [[function()
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
	end]],
	},

	{
		conflicting_filetypes = { 'ptcap' },

		literals = { 'printcap' },
		starsets = { 'printcap' },

		resolution = [[function()
		vim.b.ptcap_type = 'print'
		return 'ptcap'
	end]],
	},

	{
		conflicting_filetypes = { 'ptcap' },

		literals = { 'termcap' },
		starsets = { 'termcap' },

		resolution = [[function()
		vim.b.ptcap_type = 'term'
		return 'ptcap'
	end]],
	},

	{
		conflicting_filetypes = { 'r', 'rexx', 'rebol' },

		extensions = { 'r', 'R' },

		resolution = [[function()
		return detect.r()
	end]],
	},

	{
		conflicting_filetypes = { 'racc', 'yacc' },

		extensions = { 'y' },

		resolution = [[function()
		return detect.y()
	end]],
	},

	{
		conflicting_filetypes = { 'rapid', 'lprolog', 'modsim3', 'modula2' },

		extensions = { 'mod', 'moD', 'mOd', 'mOD', 'Mod', 'MoD', 'MOd', 'MOD' },

		resolution = [[function()
		return detect.mod()
	end]],
	},

	{
		conflicting_filetypes = { 'rapid', 'clipper' },

		extensions = { 'prg', 'prG', 'pRg', 'pRG', 'Prg', 'PrG', 'PRg', 'PRG' },

		resolution = [[function()
		return detect.prg()
	end]],
	},

	{
		conflicting_filetypes = { 'registry' },

		extensions = { 'reg' },

		resolution = [[function()
		if util.getline():find('^REGEDIT[0-9]*%s*$|^Windows Registry Editor Version %d*%.%d*%s*$') then
			return 'registry'
		end
	end]],
	},

	{
		conflicting_filetypes = { 'rexx', 'dosbatch' },

		extensions = { 'cmd' },

		resolution = [[function()
		return (util.getline():find('^%/%*') and 'rexx') or 'dosbatch'
	end]],
	},

	{
		conflicting_filetypes = { 'scala', 'supercollider' },

		extensions = { 'sc' },

		resolution = [[function()
		return detect.sc()
	end]],
	},

	{
		conflicting_filetypes = { 'scdoc', 'supercollider' },

		extensions = { 'scd' },

		resolution = [[function()
		return detect.scd()
	end]],
	},

	{
		conflicting_filetypes = { 'sgml', 'docbk', 'sgmlnx' },

		extensions = { 'sgm', 'sgml' },

		resolution = [[function()
		return detect.sgml()
	end]],
	},

	{
		conflicting_filetypes = { 'sgmldecl' },

		extensions = { 'decl' },

		resolution = [[function()
		return util.getlines_as_string(0, detect.line_limit, ' '):find('^%<%!SGML') and 'sgmldecl'
	end]],
	},

	{
		conflicting_filetypes = { 'sil', 'sile' },

		extensions = { 'sil' },

		resolution = [[function()
		return detect.sil()
	end]],
	},

	{
		conflicting_filetypes = { 'sml', 'lprolog' },

		extensions = { 'sig' },

		resolution = [[function()
		return detect.sig()
	end]],
	},

	{
		conflicting_filetypes = { 'st', 'vb', 'tex', 'rexx' },

		extensions = { 'cls' },

		resolution = [[function()
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
	end]],
	},

	{
		conflicting_filetypes = { 'stata' },

		extensions = { 'class' },

		resolution = [[function()
		-- Decimal escape sequence
		-- The original was "^\xca\xfe\xba\xbe"
		if util.getline():find('^\x202\x254\x186\x190') then
			return 'stata'
		end
	end]],
	},

	{
		conflicting_filetypes = { 'sql' },

		extensions = { 'sql', 'zsql' },

		resolution = [[function()
		return (vim.g.filetype_sql and vim.g.filetype_sql) or 'sql'
	end]],
	},

	{
		conflicting_filetypes = { 'sys', 'rapid' },

		extensions = { 'sys', 'syS', 'sYs', 'sYS', 'Sys', 'SyS', 'SYs', 'SYS' },

		resolution = [[function()
		return detect.sys()
	end]],
	},

	{
		conflicting_filetypes = { 'tex', 'context', 'plaintex' },

		extensions = { 'tex' },

		resolution = [[function(args)
		return detect.tex()
	end]],
	},

	{
		conflicting_filetypes = { 'tf', 'terraform' },

		extensions = { 'tf' },

		resolution = [[function()
		return detect.tf()
	end]],
	},

	{
		conflicting_filetypes = { 'turtle', 'teraterm' },

		extensions = { 'ttl' },

		resolution = [[function()
		local line = util.getline():lower()
		if line:find('^@?prefix') or line:find('^@?base') then
			return 'turtle'
		end
		return 'teraterm'
	end]],
	},

	{
		conflicting_filetypes = { 'vb', 'qb64', 'basic', 'freebasic' },

		extensions = { 'bi', 'bm', 'bas' },

		resolution = [[function()
		return detect.vbasic()
	end]],
	},

	{
		conflicting_filetypes = { 'vb', 'form' },

		extensions = { 'frm' },

		resolution = [[function()
		return detect.vbasic_form()
	end]],
	},

	{
		extensions = { 'xbl', 'xml', 'docbk' },

		resolution = [[function()
		return detect.xml()
	end]],
	},

	{
		conflicting_filetypes = { 'xf86conf' },

		literals = { 'xorg.conf', 'xorg.conf-4' },
		complex = { '/xorg%.conf%.d/.*%.conf$' },

		resolution = [[function()
		vim.b.xf86conf_xfree86_version = 4
		return 'xf86conf'
	end]],
	},

	{
		conflicting_filetypes = { 'xf86conf' },

		literals = { 'XF86Config' },

		resolution = [[function()
		if util.getline():find('XConfigurator') then
			vim.b.xf86conf_xfree86_version = 3
		end
		return 'xf86conf'
	end]],
	},

	{
		conflicting_filetypes = { 'xml', 'smil' },

		extensions = { 'smil' },

		resolution = [[function()
		return (util.getline():find('<?%s*xml.*?>') and 'xml') or 'smil'
	end]],
	},

	{
		conflicting_filetypes = { 'xml', 'typescript' },

		extensions = { 'ts' },

		resolution = [[function()
		return (util.getline():find('<%?xml') and 'xml') or 'typescript'
	end]],
	},

	{
		conflicting_filetypes = { 'xpm', 'xpm2' },

		extensions = { 'xpm' },

		resolution = [[function()
		return (util.getline():find('XPM2') and 'xpm2') or 'xpm'
	end]],
	},

	{
		conflicting_filetypes = { 'xpm', 'perl', 'xpm2' },

		extensions = { 'pm' },

		resolution = [[function()
		local line = util.getline()
		return (line:find('XPM2') and 'xpm2') or (line:find('XPM') and 'xpm') or 'perl'
	end]],
	},

	{
		conflicting_filetypes = { 'cfg', 'rapid' },

		-- .cfg has many conflicting file patterns and names
		starsets = { '%.[cC][fF][gG]$' },

		resolution = [[function()
		return detect.cfg()
	end]],
	},
}

return M
