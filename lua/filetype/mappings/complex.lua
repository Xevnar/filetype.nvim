--- @module 'filetype.util'
local util = require('filetype.util')

--- @module 'filetype.detect'
local detect = require('filetype.detect')

--- @type table<string, { [string]: filetype_mapping }>
local M = {}

M.endswith = {
	['/%.aptitude/config$'] = 'aptconf',
	['/%.config/git/config$'] = 'gitconfig',
	['/%.gnupg/gpg.conf$'] = 'gpg',
	['/%.gnupg/options$'] = 'gpg',
	['/%.icewm/menu$'] = 'icemenu',
	['/%.libao$'] = 'libao',
	['/%.mplayer/config$'] = 'mplayerconf',
	['/%.pinforc$'] = 'pinfo',
	['/%.ssh/config$'] = 'sshconfig',
	['/boot/grub/grub%.conf$'] = 'grub',
	['/boot/grub/menu%.lst$'] = 'grub',
	['/debian/control$'] = 'debcontrol',
	['/debian/copyright$'] = 'debcopyright',
	['/etc/DIR_COLORS$'] = 'dircolors',
	['/etc/a2ps%.cfg$'] = 'a2ps',
	['/etc/aliases$'] = 'mailaliases',
	['/etc/apt/sources%.list$'] = 'debsources',
	['/etc/asound%.conf$'] = 'alsaconf',
	['/etc/blkid%.tab$'] = 'xml',
	['/etc/blkid%.tab.old$'] = 'xml',
	['/etc/cdrdao%.conf$'] = 'cdrdaoconf',
	['/etc/conf%.modules$'] = 'modconf',
	['/etc/default/cdrdao$'] = 'cdrdaoconf',
	['/etc/defaults/cdrdao$'] = 'cdrdaoconf',
	['/etc/dnsmasq%.conf$'] = 'dnsmasq',
	['/etc/grub%.conf$'] = 'grub',
	['/etc/host%.conf$'] = 'hostconf',
	['/etc/hosts%.allow$'] = 'hostsaccess',
	['/etc/hosts%.deny$'] = 'hostsaccess',
	['/etc/libao%.conf$'] = 'libao',
	['/etc/limits$'] = 'limits',
	['/etc/login%.access$'] = 'loginaccess',
	['/etc/login%.defs$'] = 'logindefs',
	['/etc/mail/aliases$'] = 'mailaliases',
	['/etc/man%.conf$'] = 'manconf',
	['/etc/modules$'] = 'modconf',
	['/etc/modules%.conf$'] = 'modconf',
	['/etc/nanorc$'] = 'nanorc',
	['/etc/pacman%.conf$'] = 'dosini',
	['/etc/pam%.conf$'] = 'pamconf',
	['/etc/pinforc$'] = 'pinfo',
	['/etc/protocols$'] = 'protocols',
	['/etc/sensors%.conf$'] = 'sensors',
	['/etc/sensors3%.conf$'] = 'sensors',
	['/etc/serial%.conf$'] = 'setserial',
	['/etc/services$'] = 'services',
	['/etc/slp%.conf$'] = 'slpconf',
	['/etc/slp%.reg$'] = 'slpreg',
	['/etc/slp%.spi$'] = 'slpspi',
	['/etc/sudoers$'] = 'sudoers',
	['/etc/sysctl%.conf$'] = 'sysctl',
	['/etc/udev/cdsymlinks%.conf$'] = 'sh',
	['/etc/udev/udev%.conf$'] = 'udevconf',
	['/etc/updatedb%.conf$'] = 'updatedb',
	['/etc/xinetd%.conf$'] = 'xinetd',
	['/etc/yum%.conf$'] = 'dosini',
	['/etc/zprofile$'] = 'zsh',
	['/usr/share/alsa/alsa%.conf$'] = 'alsaconf',
	['Xmodmap$'] = 'xmodmap',
	['bsd$'] = 'bsdl',
	['esmtprc$'] = 'esmtprc',
	['hgrc$'] = 'cfg',
	['lftp/rc$'] = 'lftp',
	['lpe$'] = 'dracula',
	['lvs$'] = 'dracula',
	['/debian/patches/series$'] = '',

	['.*printcap'] = function()
		vim.b.ptcap_type = 'print'
		return 'ptcap'
	end,
	['.*termcap'] = function()
		vim.b.ptcap_type = 'term'
		return 'ptcap'
	end,
	['[cC]hange[lL]og'] = function()
		return (util.getline():find('%; urgency%=') and 'debchangelog') or 'changelog'
	end,
	['%.bash[_-]profile'] = function()
		return detect.sh('bash')
	end,
	['%.bash[_-]logout'] = function()
		return detect.sh('bash')
	end,
	['%.bash[_-]aliases'] = function()
		return detect.sh('bash')
	end,
	['%.bash%-fc[_-]'] = function()
		return detect.sh('bash')
	end,
	['%.[cC][fF][gG]$'] = function()
		return detect.cfg()
	end,
	['%.[dD][aA][tT]$'] = function(args)
		return detect.dat(args.file_name)
	end,
}

M.complex = {
	['%.tmux.*%.conf'] = 'tmux',
	['.*%.git/modules/.*/config'] = 'gitconfig',
	['.*git/config'] = 'gitconfig',
	['.*/%.config/systemd/user/.*%.d/.*%.conf'] = 'systemd',
	['.*/%.config/upstart/.*%.conf'] = 'upstart',
	['.*/%.config/upstart/.*%.override'] = 'upstart',
	['.*/%.init/.*%.conf'] = 'upstart',
	['.*/%.init/.*%.override'] = 'upstart',
	['.*/LiteStep/.*/.*%.rc'] = 'litestep',
	['.*/etc/.*limits%.conf'] = 'limits',
	['.*/etc/.*limits%.d/.*%.conf'] = 'limits',
	['.*/etc/a2ps/.*%.cfg'] = 'a2ps',
	['.*/etc/apt/sources%.list%.d/.*%.list'] = 'debsources',
	['.*/etc/httpd/.*%.conf'] = 'apache',
	['.*/etc/init/.*%.conf'] = 'upstart',
	['.*/etc/init/.*%.override'] = 'upstart',
	['.*/etc/initng/.*/.*%.i'] = 'initng',
	['.*/etc/ssh/ssh_config%.d/.*%.conf'] = 'sshconfig',
	['.*/etc/ssh/sshd_config%.d/.*%.conf'] = 'sshdconfig',
	['.*/etc/sysctl%.d/.*%.conf'] = 'sysctl',
	['/etc/gitconfig'] = 'gitconfig',
	['.*/etc/systemd/.*%.conf%.d/.*%.conf'] = 'systemd',
	['.*/etc/systemd/system/.*%.d/.*%.conf'] = 'systemd',
	['.*/etc/udev/permissions%.d/.*%.permissions'] = 'udevperm',
	['.*/etc/xdg/menus/.*%.menu'] = 'xml',
	['.*/usr/.*/gnupg/options%.skel'] = 'gpg',
	['.*/usr/share/upstart/.*%.conf'] = 'upstart',
	['.*/usr/share/upstart/.*%.override'] = 'upstart',
	['.*Eterm/.*%.cfg'] = 'eterm',
	['.*enlightenment/.*%.cfg'] = 'c',
	['bzr_log%..*'] = 'bzr',
	['named.*%.conf'] = 'named',
	['rndc.*%.conf'] = 'named',
	['rndc.*%.key'] = 'named',
	['.*/tex/context/.*/.*%.tex'] = 'context',

	['.*/xorg%.conf%.d/.*%.conf'] = function()
		vim.b.xf86conf_xfree86_version = 4
		return 'xf86conf'
	end,
}

M.star_sets = {
	['.*/etc/Muttrc%.d/.*'] = [[muttrc]],
	['.*/etc/proftpd/.*%.conf.*'] = [[apachestyle]],
	['.*/etc/proftpd/conf%..*/.*'] = [[apachestyle]],
	['proftpd%.conf.*'] = [[apachestyle]],
	['access%.conf.*'] = [[apache]],
	['apache%.conf.*'] = [[apache]],
	['apache2%.conf.*'] = [[apache]],
	['httpd%.conf.*'] = [[apache]],
	['srm%.conf.*'] = [[apache]],
	['.*/etc/apache2/.*%.conf.*'] = [[apache]],
	['.*/etc/apache2/conf%..*/.*'] = [[apache]],
	['.*/etc/apache2/mods-.*/.*'] = [[apache]],
	['.*/etc/apache2/sites-.*/.*'] = [[apache]],
	['.*/etc/httpd/conf%.d/.*%.conf.*'] = [[apache]],
	['.*asterisk/.*%.conf.*'] = [[asterisk]],
	['.*asterisk.*/.*voicemail%.conf.*'] = [[asteriskvm]],
	['.*/named/db%..*'] = [[bindzone]],
	['.*/bind/db%..*'] = [[bindzone]],
	['cabal%.project%..*'] = [[cabalproject]],
	['crontab'] = [[crontab]],
	['crontab%..*'] = [[crontab]],
	['.*/etc/cron%.d/.*'] = [[crontab]],
	['.*/etc/dnsmasq%.d/.*'] = [[dnsmasq]],
	['drac%..*'] = [[dracula]],
	['.*/%.fvwm/.*'] = [[fvwm]],
	['.*/tmp/lltmp.*'] = [[gedcom]],
	['.*/%.gitconfig%.d/.*'] = [[gitconfig]],
	['/etc/gitconfig%.d/.*'] = [[gitconfig]],
	['.*/gitolite-admin/conf/.*'] = [[gitolite]],
	['%.gtkrc.*'] = [[gtkrc]],
	['gtkrc.*'] = [[gtkrc]],
	['Prl.*%..*'] = [[jam]],
	['JAM.*%..*'] = [[jam]],
	['.*%.properties_??_??_.*'] = [[jproperties]],
	['Kconfig%..*'] = [[kconfig]],
	['lilo%.conf.*'] = [[lilo]],
	['.*/etc/logcheck/.*%.d.*/.*'] = [[logcheck]],
	['[mM]akefile.*'] = [[make]],
	['mk'] = [[make]],
	['mak'] = [[make]],
	['dsp'] = [[make]],
	['[rR]akefile.*'] = [[ruby]],
	['reportbug-.*'] = [[mail]],
	['.*/etc/modprobe%..*'] = [[modconf]],
	['%.muttrc.*'] = [[muttrc]],
	['%.muttngrc.*'] = [[muttrc]],
	['.*/%.mutt/mutt.*rc.*'] = [[muttrc]],
	['.*/%.muttng/mutt.*rc.*'] = [[muttrc]],
	['[mM]uttrc.*'] = [[muttrc]],
	['[mM]uttngrc.*'] = [[muttrc]],
	['%.neomuttrc.*'] = [[neomuttrc]],
	['.*/%.neomutt/neomuttrc.*'] = [[neomuttrc]],
	['neomuttrc.*'] = [[neomuttrc]],
	['Neomuttrc.*'] = [[neomuttrc]],
	['tmac%..*'] = [[nroff]],
	['/etc/hostname%..*'] = [[config]],
	['.*/etc/pam%.d/.*'] = [[pamconf]],
	['%.reminders.*'] = [[remind]],
	['sgml%.catalog.*'] = [[catalog]],
	['.*%.vhdl_[0-9].*'] = [[vhdl]],
	['.*vimrc.*'] = [[vim]],
	['Xresources.*'] = [[xdefaults]],
	['.*/app-defaults/.*'] = [[xdefaults]],
	['.*/Xresources/.*'] = [[xdefaults]],
	['.*xmodmap.*'] = [[xmodmap]],
	['.*/etc/xinetd%.d/.*'] = [[xinetd]],
	['.*/etc/yum%.repos%.d/.*'] = [[dosini]],
	['%.zsh.*'] = [[zsh]],
	['%.zlog.*'] = [[zsh]],
	['%.zcompdump.*'] = [[zsh]],
	['zsh.*'] = [[zsh]],
	['zlog.*'] = [[zsh]],

	['%.bashrc.*'] = function()
		return detect.sh('bash')
	end,
	['PKGBUILD.*'] = function()
		return detect.sh('bash')
	end,
	['APKBUILD.*'] = function()
		return detect.sh('bash')
	end,
	['%.kshrc.*'] = function()
		return detect.sh('ksh')
	end,
	['%.profile.*'] = function()
		return detect.sh('sh', true)
	end,
	['%.tcshrc.*'] = function()
		return detect.sh('tcsh')
	end,
	['%.login.*'] = function()
		return detect.csh()
	end,
	['%.cshrc.*'] = function()
		return detect.csh()
	end,
	['.*/debian/patches/.*'] = function()
		return detect.dep3patch()
	end,
}

return M
