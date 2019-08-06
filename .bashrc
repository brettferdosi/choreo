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

# skip the rest of this file if non-interactive
[ -z "$PS1" ] && return

# ignore duplicates in bash history
export HISTCONTROL=ignoredups:erasedups
# append to history file (don't overwrite) on shell exit
shopt -s histappend

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

alias reboot="sudo shutdown -r now"
alias shutdown="sudo shutdown -h now"

################
#### PROMPT ####
################

function prompt {
  local EXITSTATUS=$?
  local NUMJOBS=$(jobs | wc -l | tr -d '[[:space:]]')

  local GREEN="\[\e[32m\]"
  local RED="\[\e[31m\]"
  local YELLOW="\[\e[33m\]"
  local RESET="\[\e[m\]"

  local USERCOLOR="$GREEN"
  local HOSTCOLOR="$GREEN"
  if [ $EUID -eq 0 ]; then USERCOLOR="$RED"; fi
  if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then HOSTCOLOR="$YELLOW"; fi

  local STATUS=""
  if [ $EXITSTATUS -ne 0 ]; then STATUS=" ($EXITSTATUS)"; fi
  local JOBS=""
  if [ $NUMJOBS -ne 0 ]; then JOBS=" [$NUMJOBS]"; fi

  PS1="$USERCOLOR\u$RESET@$HOSTCOLOR\h$RESET$STATUS$JOBS \w$GREEN\nↈ $RESET "
}
export PROMPT_COMMAND="prompt"

###############
#### LOCAL ####
###############

if [ -f ~/.bashlocal ]; then source ~/.bashlocal; fi
