#!/usr/bin/zonsh

# Change directory with ranger
def run_ranger(args, stdin=None):
    ranger "--choosedir=$HOME/.rangerdir"
    end_dir = $(cat "$HOME/.rangerdir")
    cd @(end_dir)
aliases['c'] = run_ranger

# Repeat last command with priviliges
def sudo_last_cmd(args, stdin=None):
     cmd = $(history -1).split(maxsplit=1)[1].strip()
     sudo @(cmd)

aliases['fuck'] = sudo_last_cmd

aliases['~'] = 'cd ~'
aliases['..'] = 'cd ..'
aliases['...'] = 'cd ../..'
aliases['-'] = 'cd -'
aliases['_'] = 'sudo'
aliases['addp'] = 'smplayer -add-to-playlist'
aliases['copy'] = 'xsel -ib'
aliases['deploy'] = 'git checkout live; git merge --ff-only master; git checkout master; git push --all'
aliases['g'] = 'git'
aliases['ga'] = 'git add'
aliases['gap'] = 'git add -p'
aliases['gc'] = 'git commit'
aliases['gcm'] = 'git commit -m'
aliases['gd'] = 'git diff'
aliases['gl'] = "git log --show-notes='\''*'\'' --graph --abbrev-commit --pretty=format:'\''%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'' --all"
aliases['gp'] = 'git push'
aliases['gs'] = 'git status'
aliases['l'] = 'ls -lah'
aliases['la'] = 'ls -lAh'
aliases['ll'] = 'ls -lh'
aliases['ls'] = 'ls --color=tty'
aliases['md'] = 'mkdir -p'
aliases['mem'] = 'free -th'
aliases['nvlc'] = 'vlc -I ncurses'
aliases['o'] = 'xdg-open @0 >/dev/null 2>&1'
aliases['pacin'] = 'sudo apt-get install'
aliases['pacrem'] = 'sudo apt-get purge'
aliases['paste'] = 'xsel -ob'
aliases['pi'] = 'ping 8.8.8.8'
aliases['please'] = 'sudo'
aliases['py'] = 'python'
aliases['python'] = 'python3'
aliases['r'] = 'ranger'
aliases['rd'] = 'rmdir'
aliases['sr'] = 'sudo ranger'
aliases['unmount'] = 'devmon --unmount-all'
aliases['untar'] = 'tar -xvf'
aliases['xrc'] = 'source ~/.xonshrc'
def _whichap(args, stdin=None):
    ap = $(iwconfig wlan0 | grep Access).split()[-1].lower()
    cat ~/Dropbox/Uploads/WifiAnalyzer_Alias.txt | grep @(ap) || echo @(ap)
    
aliases['whichap'] = _whichap
# aliases['whichap'] = 'ap = $(iwconfig wlan0 | grep Access).split()[-1].lower();cat ~/Dropbox/Uploads/WifiAnalyzer_Alias.txt | grep @(ap) || echo @(ap)'
# aliases['whichap'] = 'ap=`iwconfig wlan0 | grep Access | tr " " "\n" | grep -1 Point | tail -n1 | tr A-Z a-z` && cat ~/Dropbox/Uploads/WifiAnalyzer_Alias.txt | grep "$ap" || echo $ap'
