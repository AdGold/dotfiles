# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="powerlevel9k/powerlevel9k"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

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

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:$HOME/.local/bin"

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

export PATH="$HOME/opt/:$PATH"
export PATH="$HOME/.scripts/:$PATH"

alias copy="xsel -ib"
alias paste="xsel -ob"
alias pacin='sudo apt-get install'
alias pacrem='sudo apt-get purge'
alias mem="free -th"
alias fuck='sudo $(fc -ln -1)'
#alias grep="/usr/bin/grep $GREP_OPTIONS"
alias pip="pip3"
alias py="py3"
alias py3="python3"
alias g14="g++ -std=c++14"
unset GREP_OPTIONS
alias gs="git status"
alias gc="git commit -m"
alias gl="git log --show-notes='*' --graph --abbrev-commit --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --all"
alias rezsh="source ~/.zshrc"
alias r="ranger"
alias sr="sudo ranger"
alias o="xdg-open @0 >/dev/null 2>&1"
alias pi="ping 8.8.8.8"
alias di="vim -d"
#alias vim='vim --servername VIM'
alias update_all="sudo apt update; sudo apt upgrade -y; sudo apt dist-upgrade -y; sudo apt autoremove"
alias ts='xinput set-prop "ELAN Touchscreen" "Device Enabled"'
alias t="tmux"
alias td="tmux -q has-session -t default && tmux attach -t default || tmux new-session -s default"
# Make commands copied from online nice
alias vim=nvim
alias nano=nvim
alias gu='nvidia-htop.py -c -l $((`tput cols`-64))'

# Kitty's terminfo isn't always available through SSH
if type "kitty" > /dev/null; then
    alias ssh="kitty +kitten ssh"
fi

alias restart_touchpad="_ rmmod hid_multitouch; _ modprobe hid_multitouch"

export PYTHONSTARTUP=$HOME/.pythonstartup.py
export EDITOR="nvim"
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && startx

# set -o vi
bindkey -v
bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

bindkey -M viins '^r' history-incremental-search-backward
bindkey -M vicmd '^r' history-incremental-search-backward

bindkey -M viins 'jk' vi-cmd-mode
bindkey -M vicmd v edit-command-line

function zle-line-init zle-keymap-select {
    # VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]%  %{$reset_color%}"
    RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $EPS1"
    zle reset-prompt
}

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
    zle accept-line
}

zle -N carry-ranger-cd
bindkey '^E' carry-ranger-cd
bindkey '^[[2~' carry-ranger-cd

zle -N zle-line-init
zle -N zle-keymap-select
export KEYTIMEOUT=20

if [ -f ~/.git_installs/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]
then
    source ~/.git_installs/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# powerline prompt zsh settings
# POWERLEVEL9K_MODE='awesome-patched'
# shorten directory path
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_SHORTEN_DELIMITER=""
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"
# prompt order
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(status command_execution_time host dir vcs virtualenv)

# See .config/kitty/dracula.conf for colours

# Status red when error, else normal background
POWERLEVEL9K_STATUS_OK_BACKGROUND=0
POWERLEVEL9K_STATUS_OK_FOREGROUND=2
POWERLEVEL9K_STATUS_ERROR_BACKGROUND=9
POWERLEVEL9K_STATUS_ERROR_FOREGROUND=3
POWERLEVEL9K_STATUS_ERROR_CR_BACKGROUND=9
POWERLEVEL9K_STATUS_ERROR_CR_FOREGROUND=3
# Execution time red
POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND=9
POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND=3

POWERLEVEL9K_HOST_LOCAL_BACKGROUND=6
POWERLEVEL9K_HOST_REMOTE_BACKGROUND=6
POWERLEVEL9K_HOST_LOCAL_FOREGROUND=0
POWERLEVEL9K_HOST_REMOTE_FOREGROUND=0

POWERLEVEL9K_DIR_DEFAULT_BACKGROUND=4

POWERLEVEL9K_VCS_CLEAN_BACKGROUND=2
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND=2
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND=2
POWERLEVEL9K_VCS_CLOBBERED_BACKGROUND=2

POWERLEVEL9K_VIRTUALENV_BACKGROUND=12


if [ "$(hostname)" = euclid ]; then
    export GOPATH="$HOME/scratch/installs/go"
else
    export GOPATH="$HOME/go"
fi

export PATH="$GOPATH:$GOPATH/bin:$PATH"
export PATH="$HOME/bin:$PATH"

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
WANDB_DIR=~/scratch/wandb

. "$HOME/.cargo/env"
