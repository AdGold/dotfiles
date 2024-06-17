#!/bin/bash

dotdir=~/.git_installs/dotfiles
olddir=~/.git_installs/dotfiles_old
dotfiles="
vimrc
zshrc
gitconfig
gitignore
pythonstartup.py
config/ranger/rc.conf
config/ranger/colorschemes/dracula.py
config/zathura/zathurarc
config/kitty/dracula.conf
config/kitty/kitty.conf
tmux.conf
config/kitty/dracula.conf
config/kitty/kitty.conf
ssh/config
scripts/makesymlinks
"

cd $dir

dotfolders="ssh config/ranger/colorschemes config/zathura config/tmux scripts config/kitty"
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
echo "done"
