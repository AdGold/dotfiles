#!/bin/bash

dotdir=~/.git_installs/dotfiles
olddir=~/.git_installs/dotfiles_old
dotfiles="
vimrc
zshrc
Xresources
gitconfig
gitignore
pythonstartup.py
xinitrc
config/ranger/rc.conf
config/ranger/colorschemes/dracula.py
config/zathura/zathurarc
config/redshift.conf
tmux.conf
config/tmux/screenline.conf
config/tmux/tmuxline.conf
config/kitty/dracula.conf
config/kitty/kitty.conf
ssh/config
gtkrc-2.0
urxvt/ext/tabbedex
urxvt/ext/clipboard
urxvt/ext/font-size
vim/.ycm_extra_conf.py
scripts/makesymlinks
"


cd $dir

dotfolders="ptpython ssh i3 config/touchegg config/ranger/colorschemes config/zathura config/tmux screenlayout urxvt/ext scripts"
for folder in $dotfolders; do
    mkdir -p ~/.$folder
done

echo "Moving any existing dotfiles from ~ to $olddir"

for file in $dotfiles; do
    [ -f ~/.$file ] && [ ! -L ~/.$file ] && mkdir -p $olddir && mv ~/.$file ~/$olddir/
    rm ~/.$file
    echo "Creating symlink to .$file in home directory."
    ln -s $dotdir/$file ~/.$file
done

xrdb -merge ~/.Xresources

echo "done"
