#!/bin/tcsh
#
# Set up the path source it from .login and .tcshrc
if ( $HOSTTYPE == "alpha" ) then
	if ($OSTYPE == "osf1") then
	# OSF1 == Tru64 on an Alpha:
		setenv PATH            "${HOME}/bin/osf1"
		setenv LD_RUN_PATH     "${HOME}/lib/osf1"
		setenv LD_LIBRARY_PATH "${HOME}/lib/osf1"
	else if ($OSTYPE == "linux") then
	# linux == Linux on an Alpha:
		setenv PATH            "${HOME}/bin/axp"
		# setenv LD_RUN_PATH     "${HOME}/lib/axp"
		# setenv LD_LIBRARY_PATH "${HOME}/lib/axp"
	endif
#
# Linux on a intel-PC
	else if ( $HOSTTYPE == "x86_64" ) then
		setenv PATH            "${HOME}/bin/x86_64"
		setenv LD_RUN_PATH     "${HOME}/lib/x86_64"
		setenv LD_LIBRARY_PATH "${HOME}/lib/x86_64"
	else if (( $HOSTTYPE == "i386-linux" ) || ( $HOSTTYPE == "i586-linux")) then
		setenv PATH            "${HOME}/bin/i386:/usr/local/j2sdk/bin"
		setenv LD_RUN_PATH     "${HOME}/lib/i386"
		setenv LD_LIBRARY_PATH "${HOME}/lib/i386:/usr/local/intel/compiler80/lib"
		if (-e /etc/redhat-release) then
			setenv PATH "${HOME}/bin/i386/rh9:${PATH}"
		endif
		if (-e /etc/SuSE-release) then
			setenv PATH "${HOME}/bin/i386/SuSE:${PATH}"
		endif
# HP-UX on a HP-RISC-Workstation
else if ( $HOSTTYPE == "hp9000s700" ) then
	setenv PATH            "${HOME}/bin/hpux"
	setenv LD_RUN_PATH     "${HOME}/lib/hpux"
	setenv LD_LIBRARY_PATH "${HOME}/lib/hpux"
	alias make       "gmake"

endif
#
# None of the above. In generic there should go only shell scripts
# else
# 	setenv PATH "${HOME}/bin/generic"
# endif
#
#----------------------------------------------------------------------

setenv PATH "${PATH}:${HOME}/bin"
setenv PATH "${PATH}:${HOME}/bin/generic"
setenv PATH "${PATH}:${HOME}/bin/ROX"

if ( -d /usr/local/alternatives/TeX-Live/bin ) then
	PATH=$PATH:/usr/local/alternatives/TeX-Live/bin
fi
if ( -d /usr/local/texlive/2014/bin/x86_64-linux ) then
	PATH=$PATH:/usr/local/texlive/2014/bin/x86_64-linux
fi

setenv PATH "${PATH}:/usr/local/bin"

if ( -d /opt/wine ) then
	setenv LD_LIBRARY_PATH ${LD_LIBRARY_PATH}:/opt/wine/lib
	setenv LD_RUN_PATH     ${LD_RUN_PATH}:/opt/wine/lib
	setenv PATH /opt/wine/bin:${PATH}
endif

if ( -d /opt/chess ) then
	setenv LD_LIBRARY_PATH ${LD_LIBRARY_PATH}:/opt/chess/lib
	setenv LD_RUN_PATH     ${LD_RUN_PATH}:/opt/chess/lib
	setenv PATH "${PATH}:/opt/chess/bin"
fi

if ( -d /opt/photo ) then
	setenv LD_LIBRARY_PATH ${LD_LIBRARY_PATH}:/opt/photo/lib
	setenv LD_RUN_PATH     ${LD_RUN_PATH}:/opt/photo/lib
	setenv PATH "${PATH}:/opt/photo/bin"
fi

setenv PATH "${PATH}:/usr/local/bin"
setenv PATH "${PATH}:/bin"
setenv PATH "${PATH}:/usr/bin"
setenv PATH "${PATH}:/usr/X11R6/bin"
setenv PATH "${PATH}:/usr/bin/X11"
setenv PATH "${PATH}:/usr/games"
setenv PATH "${PATH}:/opt/bin"

# If /etc/PATH exists append it to the current search path
if ( -e /etc/PATH ) then
	setenv PATH "${PATH}:`cat /etc/PATH`"
endif
#
# MuPAD needs this, it will not run otherwise!!!
#
setenv MuPAD_ROOT_PATH "/usr/local/mupad25"
setenv PATH "$MuPAD_ROOT_PATH/share/bin:${PATH}"


