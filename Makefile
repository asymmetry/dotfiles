all: chrome conky fcitx emacs git i3 picom pylint x11 yapf zsh

chrome: .config/chrome-flags.conf
	[ -d $(HOME)/.config ] || mkdir -p $(HOME)/.config
	ln -srf $(PWD)/.config/chrome-flags.conf $(HOME)/.config/chrome-flags.conf

conky: .config/conky/conky.conf
	[ -d $(HOME)/.config/conky ] || mkdir -p $(HOME)/.config/conky
	ln -srf $(PWD)/.config/conky/conky.conf $(HOME)/.config/conky/conky.conf

emacs: .emacs
	ln -srf $(PWD)/.emacs $(HOME)/.emacs

fcitx: .pam_environment
	ln -srf $(PWD)/.pam_environment $(HOME)/.pam_environment

git: .gitconfig .gitignore
	ln -srf $(PWD)/.gitconfig $(HOME)/.gitconfig
	ln -srf $(PWD)/.gitignore $(HOME)/.gitignore

i3: .config/i3/config .config/i3status/config
	[ -d $(HOME)/.config/i3 ] || mkdir -p $(HOME)/.config/i3
	ln -srf $(PWD)/.config/i3/config $(HOME)/.config/i3/config
	[ -d $(HOME)/.config/i3status ] || mkdir -p $(HOME)/.config/i3status
	ln -srf $(PWD)/.config/i3status/config $(HOME)/.config/i3status/config

picom: .config/picom.conf
	[ -d $(HOME)/.config ] || mkdir -p $(HOME)/.config
	ln -srf $(PWD)/.config/picom.conf $(HOME)/.config/picom.conf

pylint: .config/pylintrc
	[ -d $(HOME)/.config ] || mkdir -p $(HOME)/.config
	ln -srf $(PWD)/.config/pylintrc $(HOME)/.config/pylintrc

x11: .Xresources .xprofile .config/user-dirs.dirs
	ln -srf $(PWD)/.Xresources $(HOME)/.Xresources
	ln -srf $(PWD)/.xprofile $(HOME)/.xprofile
	[ -d $(HOME)/.config ] || mkdir -p $(HOME)/.config
	ln -srf $(PWD)/.config/user-dirs.dirs $(HOME)/.config/user-dirs.dirs

yapf: .config/yapf/style
	[ -d $(HOME)/.config/yapf ] || mkdir -p $(HOME)/.config/yapf
	ln -srf $(PWD)/.config/yapf/style $(HOME)/.config/yapf/style

zsh: .zshrc .antigenrc
	ln -srf $(PWD)/.zshrc $(HOME)/.zshrc
	ln -srf $(PWD)/.antigenrc $(HOME)/.antigenrc
