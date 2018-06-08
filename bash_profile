[[ -s ~/.bashrc ]] && source ~/.bashrc

alias ls="ls -FA"
alias dirsize="du -hs"
alias npmplease="rm -rf node_modules/ package-lock.json && npm install"
alias killflow="killall -9 flow"
alias sha256sum="shasum -a 256"

alias totarbz2="tar cjvf"
alias fromtarbz2="tar xjvf"

alias gpg="LANG=en gpg"
alias git="LANG=en git"

alias start_postgres="pg_ctl -D /usr/local/var/postgres start"
alias stop_postgres="pg_ctl -D /usr/local/var/postgres stop"

alias start_redis="redis-server /usr/local/etc/redis.conf"

export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
#export LSCOLORS=GxFxCxDxBxegedabagaced

export GPG_TTY=$(tty)
export LESSCHARSET=utf-8
export HISTCONTROL=ignoreboth

function prompt {
  local BLACK="\[\033[0;30m\]"
  local BLACKBOLD="\[\033[1;30m\]"
  local RED="\[\033[0;31m\]"
  local REDBOLD="\[\033[1;31m\]"
  local GREEN="\[\033[0;32m\]"
  local GREENBOLD="\[\033[1;32m\]"
  local YELLOW="\[\033[0;33m\]"
  local YELLOWBOLD="\[\033[1;33m\]"
  local BLUE="\[\033[0;34m\]"
  local BLUEBOLD="\[\033[1;34m\]"
  local PURPLE="\[\033[0;35m\]"
  local PURPLEBOLD="\[\033[1;35m\]"
  local CYAN="\[\033[0;36m\]"
  local CYANBOLD="\[\033[1;36m\]"
  local WHITE="\[\033[0;37m\]"
  local WHITEBOLD="\[\033[1;37m\]"
  local RESETCOLOR="\[\e[00m\]"

  local git_branch='`git branch 2> /dev/null | grep ^* | sed -e "s/* \(.*\)/ (\1)/"`'

  export PS1="$GREEN\u $YELLOW\w$CYAN$git_branch$RESETCOLOR \\$ "
}

prompt

source ~/dotfiles/git-completion.bash

[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

# added by Anaconda2 4.3.1 installer
#export PATH="/Users/`whoami`/anaconda2/bin:$PATH"
