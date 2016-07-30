if [ -f ~/.bashlocal ]; then source ~/.bashlocal; fi

# skip this if non-interactive
[ -z "$PS1" ] && return

##################
#### SETTINGS ####
##################

VIM_PATH=$(which vim)
if [ $? -eq 0 ]; then
  export EDITOR=$VIM_PATH
  export SVN_EDITOR=$VIM_PATH
  export GIT_EDITOR=$VIM_PATH
fi

LESS_PATH=$(which less)
if [ $? -eq 0 ]; then
  export PAGER=$LESS_PATH
fi

# ignore duplicates in bash history
export HISTCONTROL=ignoredups:erasedups
# append to history file (don't overwrite) on shell exit
shopt -s histappend
# append and reread history after each command from each shell
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# change LINES and COLUMNS after each command if needed
shopt -s checkwinsize

# fix spelling errors in cd
shopt -s cdspell

#################
#### ALIASES ####
#################

# coloring for BSD and GNU
if ls --color=auto -d / >/dev/null 2>&1; then
  alias ls="ls --color=auto"
else
  alias ls="ls -G"
fi
# hidden
alias la="ls -A"
# list and hidden
alias ll="ls -lhA"

function cdl { cd "$1" && ls; } 

# create and report parent directories
alias mkdir="mkdir -pv"

# continue download in case of problems
alias wget="wget -c"

alias grep="grep --color=always --line-number"

# coloring
alias less="less -R"

# aliases after sudo (http://askubuntu.com/a/22043)
alias sudo='sudo '

alias reboot="sudo shutdown -r now"
alias shutdown="sudo shutdown -h now"

################
#### PROMPT ####
################

function prompt {
  local COLOR="\[\e[32m\]"
  if [ $EUID -eq 0 ]; then COLOR="\[\e[31m\]"; fi
  echo "$COLOR\u@\h\[\e[m\] \w$COLOR\n🐊 \[\e[m\] "
}
PS1=$(prompt)
