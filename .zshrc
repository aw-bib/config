#!/bin/zsh
#
# Last change: <Wed, 2005/11/30 11:19:07 arwagner wptx44>
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
compinit
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

### # some (useful) completions
###  compctl -g '*.(mp3|MP3|ogg|OGG|temp|TEMP)' + -g '*(-/)' xmms 
###  compctl -g "*.html *.htm" + -g "*(-/) .*(-/)" + -H 0 '' galeon w3m lynx links wget
###  compctl -g '*.(pdf|PDF)' + -g '*(-/)'  arcoread
###  compctl -g '*(-/)' + -g '.*(/)' cd chdir dirs pushd rmdir dircmp cl
###  compctl -g '*.(jpg|JPG|jpeg|JPEG|gif|GIF|png|PNG|bmp)' + -g '*(-/)' gimp xv pornview
###  compctl -g '*.(e|E|)(ps|PS)' + -g '*(-/)' gs ghostview nup psps pstops psmulti psnup psselect gv
###  compctl -g '*.tex*' + -g '*(-/)' {,la,gla,ams{la,},{g,}sli}tex texi2dvi
###  compctl -g '*.dvi' + -g '*(-/)' dvips
###  compctl -g '/var/db/pkg/*(/:t)' pkg_delete pkg_info
###  compctl -g '[^.]*(-/) *.(c|C|cc|c++|cxx|cpp)' + -f cc CC c++ gcc g++
###  compctl -g '[^.]*(-/) *(*)' + -f strip ldd gdb


source $HOME/.env.sh
source $HOME/.path.sh
source $HOME/.aliases.sh

typeset -U path cdpath manpath fpath
