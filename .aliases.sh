#!/bin/sh
#
# Aliases for sh-like shells
#
# Last update: Wed, 2004/03/10, 15:31:16
#

# get rid of the default stuff:
if test -n "$BASH_VERSION"; then
  unalias -a
elif test -n "$ZSH_VERSION"; then
  unalias -m '*'
fi

xrename() {
# Set the title of an xterm
#	echo -n "]0;$1"
	echo -n "]1;$1"
	echo -n "]2;[$HOST] $1"
}

case "$HOSTTYPE" in
  Linux*alpha*)
    ;;
  *alpha*)
		case "$OSTYPE" in
			*osf1*)
				alias gpi='xrename GNUPlot;gnuplot;xrename "Terminal"'
				set color=ls-F
				alias ls="ls"
				alias ll="ls -ali"
				alias l.="ls -d .[a-zA-Z]*"
				alias n="netscape -install"
				alias make="gmake"
				alias mc="mc -b"
				;;
			*linux*) 
			;;
		esac ;;
  *[ix3456]86*)
		alias ls="ls --color=tty"
		alias ll="ls -ali --color=tty"
		alias l.="ls -d .[a-zA-Z]* --color=tty"
		if [ `hostname` = "ingata.homelinux.net" ]; then 
			alias gpi='xrename GNUplot;/usr/bin/gnuplot;xrename "Terminal"'
		else
			alias gpi='xrename GNUplot;/usr/local/gnuplot40-rh/bin/gnuplot;xrename Terminal'
		fi
		 ;;
  *HP-UX*)
		alias make="gmake"
		;;
  *)
		alias ls="ls"
		alias ll="ls -ali"
		alias l.="ls -d .[a-zA-Z]*"
		alias make="gmake"
		alias build="gmake clean; gmake"
		alias mc="mc -b"
		echo "*"
		 ;;
esac

if [ -n $ZSH_VERSION ]; then
	# history should behave like in all other shells
	alias history='history 1'
fi

# The usual bindings
if [ -e `which vim` ]; then
	alias vi='vim'
	alias gvi='gvim'
	alias se='vim -S Session.vim'
	alias gse='gvim -S Session.vim'
	alias di='vimdiff'
	alias gdi='gvimdiff'
	alias vr='gvim --remote '
fi
alias 2a4='psnup -pA4 -2 '
alias prn='lp -o media=recycled'
alias 2p='prn -od '
alias help='vim -R $HOME/help'
alias lc='wc -l'
alias uni='unison -auto'
alias ff='locate'

# Create a booklet for duplex printing:
alias book='pstops "4:-3L@.7(21cm,0)+0L@.7(21cm,14.85cm),1L@.7(21cm,0)+-2L@.7(21cm,14.85cm)"'

# Some aliases for programming
# Note that these require certain tags within the makefile!
alias build='xrename Building...; make clean; make; xrename "Terminal"'
alias run='xrename Running...;make run; xrename "Terminal"'
alias debug='make debug'
alias plot='xrename Plotting...;make plot; xrename "Terminal"'
alias ,b='build'
alias ,r='run'
alias ,m='xrename Compiling...;make;xrename "Terminal"'

alias ftp='lftp'
alias h='history'
alias d='dirs'
alias pd='pushd'
alias d2='pushd +2'
alias po='popd'

# DOS-style aliases
alias rd='rmdir'
alias md='mkdir'
alias ren='mv'
alias dir='ls'
alias cls='clear'

# some vi style
alias :q="exit"
alias :q!="exit"
alias :e="$EDITOR"

# alias xrwho  'xrwho -a -l -bell -snoop root -geometry 800x1000+1024+0 &'
alias un="uname -smr"
alias gi="grep  -in "
alias sps="paper hep-ph0201233"
alias cpu="ps aux | awk 'NR == 1 || \$3 > 0'"

alias nav="exo-open "

# Change directories
alias pd..='pd ..'

