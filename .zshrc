#!/bin/zsh
#
# Last change: <Thu, 2015/08/20 10:15:38 arwagner l00slwagner>
#

if [ $USERNAME = "arwagner" ]; then
    bindkey -v               # vi key bindings
    # ^R like like bash in vi-mode
    bindkey "^R"  history-incremental-search-backward
    # some emacs mappings in vi-mode
    bindkey "^A"  beginning-of-line
    bindkey "^E"  end-of-line
fi

# also do history expansion on space
bindkey ' ' magic-space

# --------------------------------------
# Some usual bindings not set by default
if [ $OSTYPE = 'linux-gnu' ]; then
    # home
    bindkey '\e[1~'   beginning-of-line
    # end
    bindkey '\e[4~'   end-of-line
    # ctrl-left
    bindkey '\eOd'    backward-word
    # ctrl-right
    bindkey '\eOc'    forward-word
fi
# --------------------------------------

# Set prompts
PROMPT='(%h) %B%~%b> '   # default prompt
RPROMPT='[%m]'           # prompt for right side of screen

# Enable git/svn/cvs branch info
setopt prompt_subst
autoload -Uz vcs_info
zstyle ':vcs_info:*' actionformats \
    '%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f'
zstyle ':vcs_info:*' formats       \
    '%F{5}[%F{2}%b%F{5}]%f'
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'

zstyle ':vcs_info:*' enable git cvs svn

# or use pre_cmd, see man zshcontrib
vcs_info_wrapper() {
  vcs_info
  if [ -n "$vcs_info_msg_0_" ]; then
    echo "%{$fg[grey]%}${vcs_info_msg_0_}%{$reset_color%}$del"
  else
    echo "[%m]"
  fi
}
RPROMPT=$'$(vcs_info_wrapper)'


# setup backspace correctly
stty erase `tput kbs`

HISTSIZE=2048
SAVEHIST=2048
HISTFILE=~/.zshhistory

watch=(notme)
LOGCHECK=30
DIRSTACKSIZE=10

ZBEEP='\e[?5h\e[?5l'

REPORTTIME=5
TIMEFMT='User: %U   Kernel: %S   Total: %E CPU: %P%'

case $TERM in
        xterm*)
                 chpwd() {print -Pn "\e]0;[$HOST] %~\a"}
                ;;
esac

# visible bell (like in vim)
set bell-style visible

setopt AUTO_PUSHD
# ! history expansion like tcsh
setopt BANG_HIST
setopt BEEP
# nice background jobs automatically
setopt BG_NICE
setopt CHECK_JOBS
setopt CLOBBER
# set some options to work like tcsh
setopt CSH_JUNKIE_HISTORY
setopt CSH_JUNKIE_LOOPS
setopt EXTENDED_HISTORY
setopt HASH_CMDS
setopt HASH_DIRS
setopt HASH_LIST_ALL
# history handling like in tcsh + the best of bash
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY
setopt INC_APPEND_HISTORY
setopt MARK_DIRS
setopt MENU_COMPLETE
setopt MONITOR
setopt NOTIFY
# don't warn about bg processes when exiting
setopt nocheckjobs
# automatically disown jobs form the shell like tcsh
setopt NOHUP
setopt PROMPT_BANG
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
setopt PUSHD_TO_HOME
# rm * should ask. like tcsh
unsetopt RM_STAR_SILENT
setopt SHARE_HISTORY
setopt SH_FILE_EXPANSION

autoload -U compinit

# Completion so "cd ..<TAB>" -> "cd ../"
zstyle ':completion:*' special-dirs ..
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''

# Shell functions
setenv() { export $1=$2 }  # csh compatibility

function getrfc()
{
  if [[ $# = 0 ]]
   then
     echo "Usage   : getrfc RFC-Number"
     echo "Example : getrfc 822"
   else
   lynx -dump http://www.ietf.org/rfc/rfc"$1".txt | $PAGER
 fi
}

# adds a directory to the PATH, without making duplicate entries
function add_to_path()
{
 if [[ "$1" == "" ]]
   then
     echo "Usage: add_to_path directory"
   else
     unset SPACEPATH
     local SPACEPATH
   for i in `echo ${PATH:gs/:/ /}`
     do
       SPACEPATH=( $SPACEPATH $i )
     done
   typeset -U SPACEPATH
 if [[ -d "$1" ]]; then; SPACEPATH=( $SPACEPATH "$1" ); fi
    PATH="`echo $SPACEPATH`"
    PATH=${PATH:gs/ /:/}
    export PATH
    rehash
 fi
}

# Display current directory as a 'tree'.
function tree() { find . | sed -e 's/[^\/]*\//|----/g' -e 's/---- |/    |/g' | $PAGER }

source $HOME/.env.sh
source $HOME/.path.sh
source $HOME/.aliases.sh

typeset -U path cdpath manpath fpath
