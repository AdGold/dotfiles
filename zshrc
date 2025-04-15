# P10k Instant Prompt {{{
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# }}}
# Zinit Setup {{{
# Directoroy where zinit and plugins will be installed
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"

# Download zinit, if not already installed
if [[ ! -d "$ZINIT_HOME" ]]; then
  mkdir -p "$(dirname "$ZINIT_HOME")"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Load zinit
source "$ZINIT_HOME/zinit.zsh"

# }}}
# Plugins {{{
# Load completions
autoload -Uz compinit && compinit

# Add in p10k
zinit ice depth=1; zinit light romkatv/powerlevel10k
# Add other plugins
zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit load MichaelAquilina/zsh-you-should-use
zinit wait lucid for p1r473/zsh-color-logging
zinit load zpm-zsh/colorize
# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::command-not-found

zinit cdreplay -q
# }}}
# Completions {{{

#History
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_save_no_dups
setopt hist_find_no_dups

# PATH 1 {{{
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:$HOME/.local/bin"
export PATH="$HOME/opt/:$PATH"
export PATH="$HOME/.scripts/:$PATH"
if [[ ! "$PATH" == */home/adrian/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/adrian/.fzf/bin"
fi
# }}}
# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:*' switch-group '<' '>'

eval "$(zoxide init --cmd cd zsh)"

source <(fzf --zsh)
enable-fzf-tab
export FZF_DEFAULT_OPS="--extended"
# }}}
# Aliases {{{
alias old_ls='/bin/ls'
alias l='ls'
alias ls='eza -hbro --group-directories-first'
alias la='eza -lhbroa --group-directories-first'
alias ll='eza -lhbro --group-directories-first'
alias lt='eza -lhT --group-directories-first -L 2'
alias copy="xsel -ib"
alias paste="xsel -ob"
alias pacin='sudo apt-get install'
alias pacrem='sudo apt-get purge'
alias mem="free -th"
alias fuck='sudo $(fc -ln -1)'
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
alias di="nvim -d"
alias update_all="sudo apt update; sudo apt upgrade -y; sudo apt dist-upgrade -y; sudo apt autoremove"
alias t="tmux"
alias td="tmux -q has-session -t default && tmux attach -t default || tmux new-session -s default"
alias tq="tmux attach -t queue_daemon"
# Make commands copied from online nice
alias vim=nvim
alias nano=nvim
alias gu='nvidia-htop.py -c -l $((`tput cols`-64))'
alias git-ssh='  git remote set-url origin git@github.com:$(    git remote get-url origin | sed 's/https:\/\/github.com\///' | sed 's/git@github.com://')'

# Kitty's terminfo isn't always available through SSH
if type "kitty" > /dev/null; then
    alias ssh="kitty +kitten ssh"
fi

alias restart_touchpad="_ rmmod hid_multitouch; _ modprobe hid_multitouch"
# }}}
# Keybindings {{{
bindkey -v
# bindkey -M viins '^r' history-incremental-search-backward
# bindkey -M vicmd '^r' history-incremental-search-backward
bindkey -M viins 'jk' vi-cmd-mode
bindkey -M vicmd v edit-command-line

# Use ctrl-f to accept autosuggestion
# bindkey "^f" autosuggest-accept
# Search forwards/backwards with ctrl p/n
# bindkey "^p" history-search-backward
# bindkey "^n" history-search-forward

bindkey '^w' backward-kill-word
# bindkey '^r' history-incremental-search-backward
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search
 
# }}}
# Ranger cd {{{
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
        # With zoxide, we can't use '--' to deal with folders starting with a dash, but zoxide seems to deal fine without this
        # cd -- "$(cat "$tempfile")"
        cd "$(cat "$tempfile")"
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
# }}}
# Misc {{{

# Kitty's terminfo isn't always available through SSH
if type "kitty" > /dev/null; then
    alias ssh="kitty +kitten ssh"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

setopt autocd
setopt correct

export PYTHONSTARTUP=$HOME/.pythonstartup.py
export EDITOR="nvim"

. "$HOME/.cargo/env"
# }}}
# Paths 2 {{{
if [ "$(hostname)" = euclid ]; then
    export GOPATH="$HOME/scratch/installs/go"
else
    export GOPATH="$HOME/go"
fi

export PATH="$GOPATH:$GOPATH/bin:$PATH"
export PATH="$HOME/bin:$PATH"

if [ -z "$LD_LIBRARY_PATH" ]
then
    export LD_LIBRARY_PATH=/usr/local/lib
else
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
WANDB_DIR=~/scratch/wandb

[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

path=('/homes/ag2198/.juliaup/bin' $path)
export PATH

# <<< juliaup initialize <<<

# }}}
