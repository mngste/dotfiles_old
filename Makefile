stow = cd config && stow -v -t ~

install:
	xargs -d '\n' -a packages/package.list pkg add

dotfiles:
	$(stow) git
	$(stow) termux
	$(stow) fonts
