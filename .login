#!/bin/tcsh
#
# Last update: Fri, 2004/03/05, 17:01:51
#
# Login-Script for .(t)csh
#   This script is exectued on every login even in noninteractive
#   shells. It sets only platformdependend stuff needed there as well
#   and may be superseeded by .tcsh. (Especially true for the
#   PATH-statements.)
#
#eval `tset -s -Q`
#stty  kill "^U" erase "^H" intr "^C" eof "^D" susp "^Z" hupcl ixon ixoff 
# tabs
# echo "DISPLAY auf $DISPLAY gesetzt"


# Set the LANG-variable to a sensitive value. RedHat/gdm has a bug here...
# setenv LANG C # en_US.ISO-8859-1
# setenv LANG en_GB.utf-8 # en_US.ISO-8859-1
export LANG=`locale -a | grep -i "en_GB.utf"`
## setenv LANG de_DE
## setenv LC_CTYPE de_DE


set noclobber
umask 022
date
mesg n

source $HOME/.path
mkdir /tmp/$USER
chmod 700 /tmp/$USER
mkdir /tmp/$USER/xvpics
mkdir /tmp/$USER/thumbnails

if ( $HOSTTYPE == "hp9000s700" ) then
  # So we are on a HP-UX: 
  setenv PATH "${PATH}:${HOME}/bin/hpux"

else if ( $HOSTTYPE == "alpha" ) then
  # So we are on a DEC:
  setenv PATH "${PATH}:${HOME}/bin/osf1"
  setenv language german

else if ( $HOSTTYPE == "i386-linux" ) then
  # So we are on a PC:
  setenv PATH "${PATH}:${HOME}/bin/i386"
  # For Linux' X: set the backspace correctly
endif
