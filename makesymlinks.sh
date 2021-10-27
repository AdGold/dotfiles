#!/bin/bash

dotdir=~/.git_installs/dotfiles
olddir=~/.git_installs/dotfiles_old
dotfiles="
xonshrc
vimrc
zshrc
Xresources
gitconfig
gitignore
pythonstartup.py
xinitrc
xmodmaprc
i3/config
i3/i3status
i3/i3exit
i3/i3statusmod.py
config/touchegg/touchegg.conf
config/ranger/rc.conf
config/zathura/zathurarc
config/redshift.conf
tmux.conf
config/tmux/screenline.conf
config/tmux/tmuxline.conf
ssh/config
gtkrc-2.0
screenlayout/one-screen.sh
screenlayout/both-screens.sh
screenlayout/mirror-screens.sh
screenlayout/select-display.sh
urxvt/ext/tabbedex
urxvt/ext/clipboard
urxvt/ext/font-size
vim/.ycm_extra_conf.py
scripts/move-to-next-monitor
scripts/mm_natural_scroll
scripts/vpn
scripts/makesymlinks
ptpython/config.py
"


cd $dir

dotfolders="ptpython ssh i3 config/touchegg config/ranger config/tmux screenlayout urxvt/ext scripts"
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
