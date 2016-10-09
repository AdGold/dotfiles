# Path to your oh-my-zsh installation.
  export ZSH=/home/adrian/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# User configuration

  export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

function ranger-cd {
    tempfile=$(mktemp)
    \ranger --choosedir="$tempfile" "${@:-$(pwd)}" < $TTY
    test -f "$tempfile" &&
    if [[ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]]; then
        cd -- "$(cat "$tempfile")"
    fi
    rm -f -- "$tempfile"
}

function carry-ranger-cd {
    ranger-cd
    VISUAL=true zle edit-command-line
}

export PATH="$HOME/.cabal/bin:/opt/cabal/1.22/bin:/opt/ghc/7.10.3/bin:$PATH"

alias copy="xsel -ib"
alias paste="xsel -ob"
alias pacin='sudo apt-get install'
alias pacrem='sudo apt-get purge'
alias nvlc="vlc -I ncurses"
alias mem="free -th"
alias addp="smplayer -add-to-playlist"
alias fuck='sudo zsh -c "$(fc -ln -1)"'
#alias grep="/usr/bin/grep $GREP_OPTIONS"
alias py="python"
unset GREP_OPTIONS
alias gl="git log --show-notes='*' --graph --abbrev-commit --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --all"
alias deploy='git checkout live; git merge --ff-only master; git checkout master; git push --all'
alias unmount="devmon --unmount-all"
alias rezsh="source ~/.zshrc"
alias vmp="vblank_mode=0 vmplayer"
alias r="ranger"
alias sr="sudo ranger"
alias o="xdg-open @0 >/dev/null 2>&1"
alias pi="ping 8.8.8.8"
alias whichap='ap=`iwconfig wlan0 | grep Access | tr " " "\n" | grep -1 Point | tail -n1 | tr A-Z a-z` && cat ~/Dropbox/Uploads/WifiAnalyzer_Alias.txt | grep "$ap" || echo $ap'

if [ -f /usr/share/virtualenvwrapper/virtualenvwrapper_lazy.sh ]
then
    source /usr/share/virtualenvwrapper/virtualenvwrapper_lazy.sh
fi

[[ -n $DISPLAY ]] && xmodmap ~/.xmodmaprc
export PYTHONSTARTUP=$HOME/.pythonstartup.py
# export PATH=$PATH:/home/adrian/.gem/ruby/2.1.0/bin
export PATH=$PATH:/opt/os161/bin
export EDITOR="vim"
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && startx

zle -N carry-ranger-cd
bindkey '^E' carry-ranger-cd

# Robocup stuff
export RUNSWIFT_CHECKOUT_DIR="/home/adrian/rUNSWift"
export PATH="$RUNSWIFT_CHECKOUT_DIR/bin:$PATH"
export CTC_DIR="/home/adrian/rUNSWift/ctc/ctc-linux64-atom-2.1.3.3"
# export LIBGL_DEBUG=verbose
# expport MESA_DEBUG=1 # doesn't actually change anything
# export LIBGL_DRIVERS_PATH=/home/adrian/rUNSWift/ctc/sysroot_legacy/usr/lib/dri
