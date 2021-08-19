# git
alias gs='git status'
alias ga='git add .'
alias gpom='git push origin master'
alias gpo='git push origin'
alias gch='git checkout'
alias gb='git branch'
alias gla='git log --oneline --graph --decorate --all'
alias gl="git log --color=always --graph --all \
            --format='format:%C(yellow)%h%Cblue %cr %Cred%d %Creset%s' \
            --date=relative \
            | sed -re 's/([^/ ])(HEAD)/\\1\x1b[48;5;53;38;5;15;1m \\2 \x1b[0;31m/' \
            | sed -re 's/ ago //' \
            | less -RSX"
alias gd='git diff'
alias gcp='git cherry-pick'
alias gpl='git pull'
alias gcn='git commit -m'
alias gcn!='git commit --amend'
alias gcnae='git commit --amend --no-edit'
alias gfh='git fetch'
alias gr='git rebase'
alias gcp='git cherry-pick'
alias gcl='git clone'
# reload zsh
alias zr='source ~/.zshrc && print "zsh config has been reloaded"'
# golang
alias gt.='go test ./...'
alias gtr='go test -run'
alias gob='go build'
alias goi='go install'
# linux
alias pms='sudo pacman -S'
alias ys='yay -S'
alias wh='which'
alias uz=':unzip'
alias pk='sudo kill -9'
# docker
alias ds='sudo systemctl start docker'
alias ds!='sudo systemctl stop docker'
alias dsc='docker stop'
alias drm='docker rm -f'
alias dils='docker image ls'
alias dilsnonerm='docker rmi $(docker images -f "dangling=true" -q)'
alias din='docker inspect'
alias dps='docker ps'
alias dex='docker exec -it'
# mongo
alias ms='sudo systemctl start mongodb'
alias ms!='sudo systemctl stop mongodb'
alias expdb='export TEST_DATABASE_URI="mongodb://localhost:27017'
# systemctl
alias sc='sudo systemctl'
alias scr='sudo systemctl restart'
alias scs='sudo systemctl start'
alias sce='sudo systemctl enable'
alias sct='sudo systemctl stop'
alias scd='sudo systemctl disable'
alias scu='sudo systemctl status'
alias scl='sudo systemctl list-units'
alias t='task'




# if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
#   exec startx
# fi

if [ ! -d ~/.zgen ]; then
	git clone https://github.com/tarjoilija/zgen ~/.zgen
fi


source ~/.zgen/zgen.zsh


if ! zgen saved; then
	zgen load seletskiy/zsh-prompt-lambda17
    zgen oh-my-zsh plugins/sudo
	zgen save
fi


autoload -Uz promptinit
promptinit

prompt lambda17

:prompt-pwd() {
    if [[ "$PWD" == "$HOME" || "$PWD" == "$HOME/" ]]; then
        lambda17:print ''
        return
    fi

    local dir=$PWD
    local basename=${dir/*\/}
    local relative=$(realpath --relative-to=$HOME $dir/.. \
        | sed -r 's@([^/]{1})[^/]{2,}@\1@g'
    )
    if [[ "$relative" =~ ^\\.\\. ]]; then
        echo "$dir"
    else
        echo "~/$relative/$basename"
    fi
}

zstyle -d "lambda17:00-main" transform
zstyle -d "lambda17>00-tty>00-root>00-main>00-status>00-banner" 01-git-stash
zstyle -d "lambda17:20-git" transform
zstyle -d "lambda17:25-head" when
zstyle -d "lambda17:91-exit-code" fg
zstyle -d "lambda17:91-exit-code" text
zstyle -d "lambda17:91-exit-code" when
zstyle -d "lambda17::async" pre-draw
zstyle "lambda17:00-banner" right " "
zstyle "lambda17:01-git-stash" fg "black"
zstyle "lambda17:05-sign" text "∞"
zstyle "lambda17:09-arrow" transition ""
zstyle "lambda17:15-pwd" text '$(:prompt-pwd)'
zstyle "lambda17:20-git" left " "
zstyle "lambda17:25-head" fg-branch "green"
zstyle "lambda17:25-head" fg-detached "red"
zstyle "lambda17:25-head" fg-empty "blue"
zstyle "lambda17:25-head" fg-tag "yellow"
zstyle "lambda17:26-git-clean" fg "green"
zstyle "lambda17:26-git-dirty" fg "red"
zstyle "lambda17:26-git-dirty" text "↕"

:lambda17:read-terminal-background () {
    :
}

zstyle "lambda17:00-banner" bg 'white'
zstyle "lambda17:05-sign" fg 'black'


zle -N :favor
:favor() {
    local favor_dir="$(favor --quiet)"
    if [[ ! "$favor_dir" ]]; then
        return
    fi

    eval cd "$favor_dir"
    unset favor_dir

    #clear
    zle -R
    lambda17:update
    zle reset-prompt
}

stty -ixon

# binds
bindkey -v "^S" sudo-command-line
bindkey -v '^N' :favor


:unzip() {
    local name=$(sed -r 's/\.(zip|jar)$//' <<< "$1")
    unzip $1 -d "$name"
}
