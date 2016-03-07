#!/bin/bash

dotdir=~/dotfiles
olddir=~/dotfiles_old
dotfiles="vimrc zshrc Xresources gitconfig pythonstartup.py vimrc xinitrc xmodmaprc i3/config i3/i3status config/touchegg/touchegg.conf ssh/config"

mkdir -p $olddir
cd $dir

dotfolders="ssh i3 config/touchegg"
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
