#!/bin/tcsh
#
# Environment vor csh-like shells
#
# Last update: Wed, 2004/03/10, 15:31:16
#
setenv LANG     "C"
setenv USERNAME $USER
setenv TEMP     "$HOME/tmp"
setenv TMP      "$HOME/tmp"
setenv temp     "$HOME/tmp"
setenv tmp      "$HOME/tmp"
setenv PAGER    "less"
setenv TIME     "User: %Us   Kernel: %Ss   Total: %Es   CPU: %P"
setenv LESSOPEN "|${HOME}/bin/generic/lesspipe %s"
if ( -e `which vim` ) then
   if ( ${?DISPLAY} ) then
           setenv VISUAL   "vim"
           setenv EDITOR   "vim"
   else
           setenv VISUAL   "vim -X"
           setenv EDITOR   "vim -X"
   endif
else
        setenv VISUAL   "vi"
        setenv EDITOR   "vi"
endif
setenv INPUTRC  "$HOME/.inputrc"
setenv TEXINPUTS ".:$HOME/tex/inputs:"
setenv BSTINPUTS ".:$HOME/tex/bst:"
setenv BIBINPUTS ".:$HOME/tex/bib:"

setenv CHOICESPATH     "$HOME/GNUstep/Choices"
# setenv XDG_CONFIG_HOME "$HOME/GNUstep/Choices"
# setenv XDG_CONFIG_DIR  "$HOME/GNUstep/Choices"

# RedHat Handles the manpath differently
if (-e /etc/redhat-release) then
        setenv MANPATH "$HOME/man:/usr/local_hp/TeX/man":`/usr/bin/man -w`
endif

setenv PILOTRATE "57600"
setenv PILOTRATE "115200"
setenv PILOTPORT "/dev/ttyUSB1"
# for BlueTooth sync use net:any and dund
setenv PILOTPORT "net:any"

setenv CMAIL_DIR "$HOME/GNUstep/Chess/cmail"
setenv CMAIL_ARCDIR "$HOME/GNUstep/Chess/cmail/archive"
# unsetenv LESSOPEN

# setenv CVSROOT :ext:arwagner@wptx44.physik.uni-wuerzburg.de:/users/arwagner/.cvsroot
setenv CVS_RSH "ssh"
setenv CVSROOT  "$HOME/.cvsroot"

# To use CERN-Libraries and programs
setenv CERN /usr/local/HEP/cernlib
setenv CERNLEVEL pro
setenv CERN_ROOT "$CERN/$CERNLEVEL"

# FORM Search path for procedures (*.prc)
setenv FORMPATH "$HOME/lib/form:./:"

# PERL additional libraries
setenv PERL5LIB "$HOME/lib/perl/site_perl"

##
## Environment for Intel Compilers
##
#source /usr/local/intel/compiler/bin/ifortvars.csh
#source /usr/local/intel/compiler/bin/iccvars.csh
#
##
## Environment for Lahey Fortran Compiler
##
#source /usr/local/OHL/lf9561/csh_setup
