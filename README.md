# Installation

## fish

To change your login shell to fish:

Add the shell to /etc/shells with:

```bash
echo ../usr/bin/fish | sudo tee -a /etc/shells
```

Change your default shell with:

```bash
chsh -s fish
```

Again, substitute the path to fish for /usr/local/bin/fish - see 
```
command -s
```
fish inside fish. To change it back to another shell, just substitute /usr/local/bin/fish with /bin/bash, /bin/tcsh or /bin/zsh as appropriate in the steps above.

# install fisher 
```
curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs https://git.io/fisher
```
