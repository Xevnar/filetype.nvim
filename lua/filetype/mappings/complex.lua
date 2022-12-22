--- @module 'filetype.util'
local util = require('filetype.util')

--- @module 'filetype.detect'
local detect = require('filetype.detect')

--- @type table<string, { [string]: filetype_mapping }>
local M = {}

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

	local fkey = 'f' .. key
	for pat, val in pairs(map) do
		-- Check if pattern contains an env var
		if M.contains_env_var[pat] == nil then
			M.contains_env_var[pat] = pat:find('%${') ~= nil
		end

		if pat:find('/') then
			if not self[key] then
				self[key] = {}
			end

			self[key][pat] = val
		else
			if not self[fkey] then
				self[fkey] = {}
			end

			self[fkey][pat] = val
		end
	end
end

--- Cache table that stores if the pattern contains an en enviroment variable that must
--- be expanded
---
--- @type { [string]: boolean } A table of lua pattern mappings
M.contains_env_var = {
	['^${HOME}/cabal%.config$'] = true,
	['^${XDG_CONFIG_HOME}/git/attributes$'] = true,
	['^${XDG_CONFIG_HOME}/git/config$'] = true,
	['^${XDG_CONFIG_HOME}/git/ignore$'] = true,
	['^${GNUPGHOME}/options$'] = true,
	['^${GNUPGHOME}/gpg%.conf$'] = true,
	['^${VIMRUNTIME}/doc/.*%.txt$'] = true,
}

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
	end
}

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

}

M.complex = {
	['/etc/a2ps/.*%.cfg$'] = 'a2ps',
	['/etc/httpd/.*%.conf$'] = 'apache',
	['/etc/apache2/sites%-.*/.*%.com$'] = 'apache',
	['/meta/conf/.*%.conf$'] = 'bitbake',
	['/build/conf/.*%.conf$'] = 'bitbake',
	['/meta%-.*/conf/.*%.conf$'] = 'bitbake',
	['enlightenment/.*%.cfg$'] = 'c',
	['/%.?cmus/.*%.theme$'] = 'cmusrc',
	['/tex/context/.*/.*%.tex$'] = 'context',
	['/etc/apt/sources%.list%.d/.*%.list$'] = 'debsources',
	['/dtrace/.*%.d$'] = 'dtrace',
	['Eterm/.*%.cfg$'] = 'eterm',
	['git/config$'] = 'gitconfig',
	['%.git/modules/.*/config$'] = 'gitconfig',
	['%.git/worktrees/.*/config%.worktree$'] = 'gitconfig',
	['/usr/.*/gnupg/options%.skel$'] = 'gpg',
	['^${VIMRUNTIME}/doc/.*%.txt$'] = 'help',
	['/etc/initng/.*/.*%.i$'] = 'initng',
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
	['/%.init/.*%.conf$'] = 'upstart',
	['/etc/init/.*%.conf$'] = 'upstart',
	['/%.init/.*%.override$'] = 'upstart',
	['/etc/init/.*%.override$'] = 'upstart',
	['/%.config/upstart/.*%.conf$'] = 'upstart',
	['/usr/share/upstart/.*%.conf$'] = 'upstart',
	['/%.config/upstart/.*%.override$'] = 'upstart',
	['/usr/share/upstart/.*%.override$'] = 'upstart',
	['/etc/xdg/menus/.*%.menu$'] = 'xml',

	['/xorg%.conf%.d/.*%.conf$'] = function()
		vim.b.xf86conf_xfree86_version = 4
		return 'xf86conf'
	end,
	['/constant/g$'] = function()
		return detect.foam()
	end,
}

M.fcomplex = {
	['^dictd.*%.conf$'] = 'dictdconf',
	['^hg%-editor%-.*%.txt$'] = 'hgcommit',
	['^org%.eclipse%..*%.prefs$'] = 'jproperties',
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
	[util.to_case_insensitive('%.?upstream%.dat$')] = 'upstreamdat',
	[util.to_case_insensitive('upstream%..*%.dat$')] = 'upstreamdat',
	[util.to_case_insensitive('%.?upstreaminstall%.log$')] = 'upstreaminstalllog',
	[util.to_case_insensitive('upstreaminstall%..*%.log$')] = 'upstreaminstalllog',
	[util.to_case_insensitive('upstream%-.*%.log$')] = 'upstreamlog',
	[util.to_case_insensitive('%.?upstream%.log$')] = 'upstreamlog',
	[util.to_case_insensitive('upstream%..*%.log$')] = 'upstreamlog',
	[util.to_case_insensitive('%.?usserver%.log$')] = 'usserverlog',
	[util.to_case_insensitive('usserver%..*%.log$')] = 'usserverlog',
	[util.to_case_insensitive('%.?usw2kagt%.log$')] = 'usw2kagtlog',
	[util.to_case_insensitive('usw2kagt%..*%.log$')] = 'usw2kagtlog',

	['^[a-zA-Z0-9].*Dict$'] = function()
		return detect.foam()
	end,
	['^[a-zA-Z].*Properties$'] = function()
		return detect.foam()
	end,
}

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
	['/%.fvwm/'] = 'fvwm',
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
	['%.git/'] = function()
		local line = util.getline()
		if util.match_vim_regex(line, [[^\x\{40,\}\>\|^ref: ]]) then
			return 'git'
		end
	end,
	['/0/'] = function()
		return detect.foam()
	end,
	['/0%.orig/'] = function()
		return detect.foam()
	end,
}

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

	['^%.bashrc'] = function()
		return detect.sh('bash')
	end,
	['^PKGBUILD'] = function()
		return detect.sh('bash')
	end,
	['^APKBUILD'] = function()
		return detect.sh('bash')
	end,
	['^%.kshrc'] = function()
		return detect.sh('ksh')
	end,
	['^%.profile'] = function()
		return detect.sh('sh', true)
	end,
	['^%.tcshrc'] = function()
		return detect.sh('tcsh')
	end,
	['^%.login'] = function()
		return detect.csh()
	end,
	['^%.cshrc'] = function()
		return detect.csh()
	end,
	['^[a-zA-Z0-9].*Dict%.'] = function()
		return detect.foam()
	end,
	['^[a-zA-Z].*Properties%.'] = function()
		return detect.foam()
	end,
	['Transport%.'] = function()
		return detect.foam()
	end,
	['printcap'] = function()
		vim.b.ptcap_type = 'print'
		return 'ptcap'
	end,
	['termcap'] = function()
		vim.b.ptcap_type = 'term'
		return 'ptcap'
	end,
	['^[cC]hange[lL]og'] = function()
		return (util.getline():find('%; urgency%=') and 'debchangelog') or 'changelog'
	end,

	-- .cfg has many conflicting file patterns and names
	[util.to_case_insensitive('%.cfg$')] = function()
		return detect.cfg()
	end,
}

return M
