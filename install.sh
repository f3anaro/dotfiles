#!/bin/bash

# directory in which this script is located
__file__="$(readlink -f ${BASH_SOURCE[0]})"
__dir__="$(dirname $__file__)"

cd $HOME

# Bash
if [ -L ".bashrc" ]; then rm -fv .bashrc; else [ -e ".bashrc" ] && mv .bashrc .bashrc.old; fi
ln -vs $__dir__/.bashrc


# Git
if [ -L ".gitconfig" ]; then rm -fv .gitconfig; else [ -e ".gitconfig" ] && mv .gitconfig .gitconfig.old; fi
ln -vs $__dir__/.gitconfig


# Vim
if [ -L ".vimrc" ]; then rm -fv .vimrc; else [ -e ".vimrc" ] && mv .vimrc .vimrc.old; fi
ln -vs $__dir__/.vimrc

[ -d ".vim" ] &&  [ ! -L ".vim" ] && mv .vim .vim.old
[ -L ".vim" ] && rm -fv .vim
ln -vs $__dir__/.vim


# Virtual environments (Python)
[ ! -d ".virtualenvs/" ] && mkdir .virtualenvs/
# Remove existing postactive hook
if [ -L ".virtualenvs/postactivate" ]; then
    rm -fv .virtualenvs/postactivate
else
    [ -e ".virtualenvs/postactivate" ] && mv .virtualenvs/postactivate .virtualenvs/postactivate.old
fi
ln -vs $__dir__/.virtualenvs/postactivate .virtualenvs/

[ ! -d ".config" ] && mkdir -p .config/

for file in $__dir__/.config/*; do
    ln -vsf $file $HOME/.config/
done

# create .ssh/ config directory
[ ! -d ".ssh" ] && mkdir -p .ssh/
# backup current ssh config if it is not alreayd a symlink
[ ! -L ".ssh/config" ] && mv .ssh/config .ssh/config.old
# remove old symlink
[ -L ".ssh/config" ] && rm -fv .ssh/config
ln -vs $__dir__/.ssh/config .ssh/config
