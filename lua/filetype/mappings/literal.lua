local util = require("filetype.util")
local detect = require("filetype.detect")

return {
    [".a2psrc"] = "a2ps",
    [".asoundrc"] = "alsaconf",
    [".babelrc"] = "json",
    [".cdrdao"] = "cdrdaoconf",
    [".cvsrc"] = "cvsrc",
    [".dictrc"] = "dictconf",
    [".dir_colors"] = "dircolors",
    [".dircolors"] = "dircolors",
    [".editorconfig"] = "dosini",
    [".emacs"] = "lisp",
    [".eslintrc"] = "json",
    [".exrc"] = "vim",
    [".fetchmailrc"] = "fetchmail",
    [".firebaserc"] = "json",
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
    [".prettierrc"] = "json",
    [".procmail"] = "procmail",
    [".procmailrc"] = "procmail",
    [".pythonrc"] = "python",
    [".pythonstartup"] = "python",
    [".ratpoisonrc"] = "ratpoison",
    [".reminders"] = "remind",
    [".Rprofile"] = "r",
    [".sawfishrc"] = "lisp",
    [".sbclrc"] = "lisp",
    [".screenrc"] = "screen",
    [".slrnrc"] = "slrnrc",
    [".stylelintrc"] = "json",
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
    ["Appfile"] = "ruby",
    ["Brewfile"] = "ruby",
    ["BUILD"] = "bzl",
    ["CMakeLists.txt"] = "cmake",
    ["COMMIT_EDITMSG"] = "gitcommit",
    ["Containerfile"] = "dockerfile",
    ["Dockerfile"] = "dockerfile",
    ["Fastfile"] = "ruby",
    ["Gemfile"] = "ruby",
    ["Kconfig"] = "kconfig",
    ["Kconfig.debug"] = "kconfig",
    ["MERGE_MSG"] = "gitcommit",
    ["Neomuttrc"] = "neomuttrc",
    ["Pipfile"] = "config",
    ["Pipfile.lock"] = "json",
    ["Podfile"] = "ruby",
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
    [".clang-format"] = "yaml",
    ["_clang-format"] = "yaml",
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
    ["gitconfig"] = "gitconfig",
    ["git-rebase-todo"] = "gitrebase",
    ["gitolite.conf"] = "gitolite",
    ["gnashpluginrc"] = "gnash",
    ["gnashrc"] = "gnash",
    ["go.mod"] = "gomod",
    ["gtkrc"] = "gtkrc",
    ["indentrc"] = "indent",
    ["inittab"] = "inittab",
    ["inputrc"] = "readline",
    ["ipf.conf"] = "ipfilter",
    ["ipf.rules"] = "ipfilter",
    ["ipf6.conf"] = "ipfilter",
    ["irbrc"] = "ruby",
    ["Jenkinsfile"] = "groovy",
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

    ["xorg.conf-4"] = function()
        vim.b.xf86conf_xfree86_version = 4
        return "xf86conf"
    end,
    ["xorg.conf"] = function()
        vim.b.xf86conf_xfree86_version = 4
        return "xf86conf"
    end,
    ["XF86Config"] = function()
        if util.getline():find("XConfigurator") then
            vim.b.xf86conf_xfree86_version = 3
        end
        return "xf86conf"
    end,
    ["INDEX"] = function()
        if
            util.getline():find(
                "^%s*(distribution|installed_software|root|bundle|product)%s*$"
            )
        then
            return "psf"
        end
    end,
    ["INFO"] = function()
        if
            util.getline():find(
                "^%s*(distribution|installed_software|root|bundle|product)%s*$"
            )
        then
            return "psf"
        end
    end,
    ["control"] = function()
        if util.getline():find("^Source%:") then
            return "debcontrol"
        end
    end,
    ["NEWS"] = function()
        if util.getline():find("%; urgency%=") then
            return "debchangelog"
        end
    end,
    ["indent.pro"] = function()
        return detect.proto() or "indent"
    end,
    [".bashrc"] = function()
        return detect.sh({ fallback = "bash" })
    end,
    ["bashrc"] = function()
        return detect.sh({ fallback = "bash" })
    end,
    ["bash.bashrc"] = function()
        return detect.sh({ fallback = "bash" })
    end,
    ["PKGBUILD"] = function()
        return detect.sh({ fallback = "bash" })
    end,
    ["APKBUILD"] = function()
        return detect.sh({ fallback = "bash" })
    end,
    [".kshrc"] = function()
        return detect.sh({ fallback = "ksh" })
    end,
    [".profile"] = function()
        return detect.sh({ fallback = "sh", force_shebang_check = true })
    end,
    [".tcshrc"] = function()
        return detect.sh({ fallback = "tcsh" })
    end,
    ["tcsh.tcshrc"] = function()
        return detect.sh({ fallback = "tcsh" })
    end,
    ["tcsh.login"] = function()
        return detect.sh({ fallback = "tcsh" })
    end,
    [".login"] = function()
        return detect.csh()
    end,
    [".cshrc"] = function()
        return detect.csh()
    end,
    ["csh.cshrc"] = function()
        return detect.csh()
    end,
    ["csh.login"] = function()
        return detect.csh()
    end,
    ["csh.logout"] = function()
        return detect.csh()
    end,
    [".alias"] = function()
        return detect.csh()
    end,
    [".d"] = function()
        return detect.sh({ fallback = "bash" })
    end,
}
