#!/bin/bash

dotdir=~/dotfiles
olddir=~/dotfiles_old
dotfiles="
vimrc
zshrc
Xresources
gitconfig
pythonstartup.py
vimrc
xinitrc
xmodmaprc
i3/config
i3/i3status
config/touchegg/touchegg.conf
config/ranger/rc.conf
ssh/config
gtkrc-2.0
screenlayout/one-screen.sh
screenlayout/both-screens.sh
screenlayout/mirror-screens.sh
screenlayout/select-display.sh
"

mkdir -p $olddir
cd $dir

dotfolders="ssh i3 config/touchegg config/ranger screenlayout"
for folder in $dotfolders; do
    mkdir -p ~/.$folder
done

echo "Moving any existing dotfiles from ~ to $olddir"

for file in $dotfiles; do
    [ -f ~/.$file ] && [ ! -L ~/.$file ] && mv ~/.$file ~/$olddir/
    [ -f ~/.$file ] && rm ~/.$file
    echo "Creating symlink to .$file in home directory."
    ln -s $dotdir/$file ~/.$file
done

echo "done"
