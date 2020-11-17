# if not interactive, don't do anything
[ -z "$PS1" ] && return

. ~/.shell_env
. ~/.shell_aliases

##################
#### SETTINGS ####
##################

# ignore duplicates in bash history
export HISTCONTROL=ignoredups:erasedups
# append to history file (don't overwrite) on shell exit
shopt -s histappend

# change LINES and COLUMNS after each command if needed
shopt -s checkwinsize

# fix spelling errors in cd
shopt -s cdspell

# ctrl left and right move words
bind '"\e[1;5D" backward-word'
bind '"\e[1;5C" forward-word'

################
#### PROMPT ####
################

function git_status {
  local BRANCH=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/')
  if [ -n "$BRANCH" ]; then BRANCH="$BRANCH "; fi
  echo $BRANCH
  # desc is slow
  #local DESC=$(git describe --tags --always --dirty 2> /dev/null)
  #echo "$BRANCH$DESC"
}

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

  local GIT=$(git_status)
  if [ -n "$GIT" ]; then GIT=" $GIT"; fi

  PS1="$USERCOLOR\u$RESET@$HOSTCOLOR\h$RESET$STATUS$JOBS \w$GREEN$GIT\n>$RESET "
}
export PROMPT_COMMAND="prompt"

###############
#### LOCAL ####
###############

if [ -f ~/.bashlocal ]; then source ~/.bashlocal; fi
