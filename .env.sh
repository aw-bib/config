#!/bin/sh
#
# Environment variables for sh-like shells 
#

# zsh doesn't set HOSTNAME but only HOST
# export HOSTNAME=`hostname`.`dnsdomainname`

# remove coredumps automatically by setting theire maximum size to 0
ulimit -c 0

# set higher stack limit for unison etc.
# breaks recent versions of xine
### ulimit -s 65536

## Use C as default language, but nowadays UTF should be good enough
## export LANG='C'

# Try to set utf locale. Note that depending on the unix it might be
# utf8 or UTF-8 or ...
export LANG=`locale -a | grep -i "en_GB.utf"`

export USERNAME=''
## export TEMP=$HOME/tmp
## export TMP=$HOME/tmp
## export temp=$HOME/tmp
## export tmp=$HOME/tmp

export PAGER=less
export TIME="User: %Us   Kernel: %Ss   Total: %Es   CPU: %P"
export LESSOPEN="|$HOME/bin/generic/lesspipe %s"

if [ -e `which vim` ]; then
	if [ ! $DISPLAY ]; then
		export VISUAL="vim"
		export EDITOR="vim"
	else
		export VISUAL="gvim -f"
		export EDITOR="gvim -f"
	fi
else
	export VISUAL="vi"
	export EDITOR="vi"
fi

export INPUTRC=$HOME/.inputrc
export TEXINPUTS=.:$HOME/tex/inputs:
export BSTINPUTS=.:$HOME/tex/bst:
export BIBINPUTS=.:$HOME/tex/bib:

export CHOICESPATH=$HOME/GNUstep/Choices
# export XDG_CONFIG_HOME="$HOME/GNUstep/Choices"
# export XDG_CONFIG_DIR="$HOME/GNUstep/Choices"

if [ -e /etc/redhat-release ]; then
	export MANPATH=$HOME/man:/usr/local_hp/TeX/man:`/usr/bin/man -w`
fi
export PILOTRATE="57600"
export PILOTRATE="115200"
export PILOTPORT="/dev/ttyUSB1"
# for BlueTooth Sync use net:any and dund
export PILOTPORT="net:any"

export CMAIL_DIR=$HOME/GNUstep/Chess/cmail
export CMAIL_ARCDIR=$HOME/GNUstep/Chess/cmail/archive

export CVS_RSH=ssh
export CVSROOT=$HOME/.cvsroot

# To use CERN-Libraries and programs
export CERN=/usr/local/HEP/cernlib
export CERNLEVEL=pro
export CERN_ROOT='$CERN/$CERNLEVEL'


# FORM Search path for procedures (*.prc)
export FORMPATH="$HOME/lib/form:./:"

# zsh doesn't set HOSTTYPE set something decent
if [ -n $ZSH_VERSION ]; then
	export HOSTTYPE=`uname -m`
fi

# PERL additional libraries
export PERL5LIB="$HOME/lib/perl/site_perl"

##
## Environment for Intel Compilers
##
#source /usr/local/intel/compiler/bin/ifortvars.sh
#source /usr/local/intel/compiler/bin/iccvars.sh
#
##
## Environment for Lahey Fortran Compiler
##
#source /usr/local/OHL/lf9561/bash_setup

if [ -e $HOME/.env.sh.local ]; then 
	source $HOME/.env.sh.local
fi

