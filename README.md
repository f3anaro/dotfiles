# Personal dotfiles

This repository contains my personal dotfiles for all my Posix working stations.
A bare git repository with a different working directory is used to manage the
file. For detailed explanation see [1] and [2].


## Customizations

 * bash prompt
    - color
    - git support
    - virtualenv support
 * aliases with bash completion support via [complete-alias][3]
 * include common local directories to `$PATH` env variable
 * git configuration
 * ssh configuration
 * Modded i3 configuration with [polybar][4]


## Installation

```bash
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
echo ".dotfiles" >> .gitignore
git clone --bare git@git.square-src.de:lucas/dotfiles.git $HOME/.dotfiles

config checkout
config config --local status.showUntrackedFiles no
```

## systemd-managed window manager

Managing your service with a systemd user session is quite handy. So handy,
that I let systemd manage my whole window manager.

```bash
# Copy menu entry for Gnome Display Manager (GDM)
sudo cp ~/.config/xsessions/systemd.desktop /usr/share/xsessions/

# Enable i3 service
systemctl --user enable i3wm.service

# Enable tray applications
systemctl --user enable nextcloud.service network-manager-applet.service
```

<!-- References -->

[1]: https://www.atlassian.com/git/tutorials/dotfiles
[2]: https://news.ycombinator.com/item?id=11071754
[3]: https://github.com/cykerway/complete-alias
[4]: https://github.com/jaagr/polybar
