stow = cd config && stow -v -t ~

install:
	xargs -d '\n' -a packages/package.list pkg install -y

dotfiles:
	$(stow) git
	$(stow) termux
	$(stow) fonts
