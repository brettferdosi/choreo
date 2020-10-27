disable which
. ~/.shell_env
. ~/.shell_aliases
enable which

####################
#### COMPLETION ####
####################

# don't beep when showing suggestions
unsetopt list_beep

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' format 'completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt %Sat %p: hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}'
zstyle ':completion:*' menu select=1
zstyle ':completion:*' select-prompt %Sscrolling active: current selection at %p%s
autoload -Uz compinit && compinit

#################
#### HISTORY ####
#################

# single history across sessions
setopt share_history

# append to history rather than overwriting
setopt append_history

# add commands as they are typed
setopt inc_append_history

# don't store duplicates
setopt hist_ignore_dups

# don't store lines starting with space
setopt hist_ignore_space

# save timestamp and runtime
setopt extended_history

# confirm before running a command from history (e.g. !!)
setopt hist_verify

# where does the history file go
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history

# number of commands in history file
SAVEHIST=5000

# number of commands loaded into memory
HISTSIZE=2000

##################
#### SETTINGS ####
##################

# change directory even if you forget cd
setopt auto_cd

# free up ^S for forward history search
stty -ixon

# emacs key bindings (like bash default)
bindkey -e

# ctrl left and right move words
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word

################
#### PROMPT ####
################

autoload -U colors && colors

function git_status {
  local BRANCH=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/')
  if [ -n "$BRANCH" ]; then BRANCH="$BRANCH "; fi
  echo $BRANCH
  # desc is slow
  #local DESC=$(git describe --tags --always --dirty 2> /dev/null)
  #echo "$BRANCH$DESC"
}

# TODO improve this
function prompt {
  local EXITSTATUS=$?

  local GREEN="%{$fg[green]%}"
  local RED="%{$fg[red]%}"
  local YELLOW="%{$fg[yellow]%}"
  local RESET="%{$reset_color%}"

  local USERCOLOR="$GREEN"
  local HOSTCOLOR="$GREEN"
  if [ $EUID -eq 0 ]; then USERCOLOR="$RED"; fi
  if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then HOSTCOLOR="$YELLOW"; fi

  local STATUS=""
  if [ $EXITSTATUS -ne 0 ]; then STATUS=" ($EXITSTATUS)"; fi

  local GIT=$(git_status)
  if [ -n "$GIT" ]; then GIT=" $GIT"; fi

  local NEWLINE=$'\n'

  PS1="$USERCOLOR%n$RESET@$HOSTCOLOR%m$RESET$STATUS%(1j. [%j].) %~$GREEN$GIT${NEWLINE}>$RESET "
}
precmd_functions=(prompt)

##############
#### TMUX ####
##############

tmux ls &> /dev/null
RET=$?
if [ $RET -eq 0 ] && [ -z "$TMUX" ]; then
  echo "tmux session active"
fi

###############
#### LOCAL ####
###############

if [ -f ~/.zshlocal ]; then source ~/.zshlocal; fi
