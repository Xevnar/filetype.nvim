--- @module 'filetype.util'
local util = require('filetype.util')

--- @module 'filetype.detect'
local detect = require('filetype.detect')

--- @type { [string]: filetype_mapping }
local literal = {
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
	['GNUmakefile.am'] = 'automake',
	['named.root'] = 'bindzone',
	['BUILD'] = 'bzl',
	['WORKSPACE'] = 'bzl',
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
	['Pipfile'] = 'config',
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
	['.editorconfig'] = 'dosini',
	['/etc/yum.conf'] = 'dosini',
	['drc'] = 'dracula',
	['dune'] = 'dune',
	['jbuild'] = 'dune',
	['dune-project'] = 'dune',
	['dune-workspace'] = 'dune',
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
	['/var/backups/group.bak'] = 'group',
	['/var/backups/gshadow.bak'] = 'group',
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
	['.babelrc'] = 'json',
	['.eslintrc'] = 'json',
	['json-patch'] = 'json',
	['.firebaserc'] = 'json',
	['.prettierrc'] = 'json',
	['.stylelintrc'] = 'json',
	['Pipfile.lock'] = 'json',
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
	['/var/backups/passwd.bak'] = 'passwd',
	['/var/backups/shadow.bak'] = 'passwd',
	['latexmkrc'] = 'perl',
	['.latexmkrc'] = 'perl',
	['pf.conf'] = 'pf',
	['main.cf'] = 'pfmain',
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

	['xorg.conf-4'] = function()
		vim.b.xf86conf_xfree86_version = 4
		return 'xf86conf'
	end,
	['xorg.conf'] = function()
		vim.b.xf86conf_xfree86_version = 4
		return 'xf86conf'
	end,
	['XF86Config'] = function()
		if util.getline():find('XConfigurator') then
			vim.b.xf86conf_xfree86_version = 3
		end
		return 'xf86conf'
	end,
	['INDEX'] = function()
		if
			util.findand(util.getline(), {
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
	['INFO'] = function()
		if
			util.findand(util.getline(), {
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
	['control'] = function()
		return util.getline():find('^Source%:') and 'debcontrol'
	end,
	['NEWS'] = function()
		return util.getline():find('%; urgency%=') and 'debchangelog'
	end,
	['indent.pro'] = function()
		return detect.proto() or 'indent'
	end,
	['.bashrc'] = function()
		return detect.sh('bash')
	end,
	['bashrc'] = function()
		return detect.sh('bash')
	end,
	['bash.bashrc'] = function()
		return detect.sh('bash')
	end,
	['PKGBUILD'] = function()
		return detect.sh('bash')
	end,
	['APKBUILD'] = function()
		return detect.sh('bash')
	end,
	['.kshrc'] = function()
		return detect.sh('ksh')
	end,
	['.profile'] = function()
		return detect.sh('sh', true)
	end,
	['.tcshrc'] = function()
		return detect.sh('tcsh')
	end,
	['tcsh.tcshrc'] = function()
		return detect.sh('tcsh')
	end,
	['tcsh.login'] = function()
		return detect.sh('tcsh')
	end,
	['.login'] = function()
		return detect.csh()
	end,
	['.cshrc'] = function()
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
	['.alias'] = function()
		return detect.csh()
	end,
	['.d'] = function()
		return detect.sh('bash')
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
	['fvModels'] = function()
		return detect.foam()
	end,
}

return literal
