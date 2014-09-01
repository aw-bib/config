# Set up the path for sh-style shells

append () {
  var="$1"
  shift
  while test $# -gt 0; do
    if test -d "$1"; then
      eval "$var"="\$$var:$1"
      break
    fi
    shift
  done
}

case "$HOSTTYPE" in
	*alpha*)
		case "$OSTYPE" in
			*osf1*)
				# OSF1 == Tru64 on an Alpha:
				PATH="$HOME/bin/osf1"
				LD_RUN_PATH="$HOME/lib/osf1"
				LD_LIBRARY_PATH="$HOME/lib/osf1"
			;;
			*linux*)
				# linux == Linux on an Alpha:
				PATH="$HOME/bin/axp"
				LD_RUN_PATH="$HOME/lib/axp"
				LD_LIBRARY_PATH="$HOME/lib/axp"
			;;
		esac ;;
	*x86_64*)
		# linux on a 64-bit PC
		PATH="$HOME/bin/x86_64"
		LD_RUN_PATH="$HOME/lib/x86_64"
		LD_LIBRARY_PATH="$HOME/lib/x86_64"
	;;
	*i[3456]86*)
		# linux on a x86 PC
		PATH="$HOME/bin/i386:/usr/local/j2sdk/bin"
		LD_RUN_PATH="$HOME/lib/i386:/usr/local/intel/compiler/lib"
		LD_LIBRARY_PATH="$HOME/lib/i386:/usr/local/intel/compiler/lib"
		# Add Chess software from local scratch if available
		if [ -e /etc/redhat-release ]; then
			PATH=$HOME/bin/i386/rh:$PATH
		fi
		if [ -e /etc/SuSE-release ]; then
			PATH=$HOME/bin/i386/SuSE:$PATH
		fi
#		if [ -e /scratch/arwagner/chess ]; then
#			PATH=$PATH:/scratch/arwagner/chess/bin
#		fi
		# Instead of Xaw3d or Athena use neXtaw
		## export LD_PRELOAD=$HOME/lib/i386/libneXtaw.so.0
	;;
	*hp*)
		# HP-UX on a PaRISC-Workstation
		PATH=$HOME/bin/hpux
		LD_RUN_PATH=$HOME/lib/hpux
		LD_LIBRARY_PATH=$HOME/lib/hpux
	;;
esac

#
# None of the above. In generic there should go only shell scripts
# else
# 	setenv PATH "${HOME}/bin/generic"
# fi
#
#----------------------------------------------------------------------

PATH=$PATH:$HOME/bin
PATH=$PATH:$HOME/bin/generic
PATH=$PATH:$HOME/bin/ROX
PATH=$PATH:/usr/local/HEP/bin

# Check wether TeX-Live lives in /usr/local/alternatives
if [ -d /usr/local/alternatives/TeX-Live/bin ]; then
	PATH=$PATH:/usr/local/alternatives/TeX-Live/bin
fi
if [ -d /usr/local/texlive/2014/bin/x86_64-linux ]; then
	PATH=$PATH:/usr/local/texlive/2014/bin/x86_64-linux
fi

# Replace systems Wine installation by a self compiled edition
if [ -h /opt/wine ] || [ -d /opt/wine ]; then
	PATH=$PATH:/opt/wine/bin
	LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/wine/lib:/opt/wine/lib/wine
	LD_RUN_PATH=$LD_RUN_PATH:/opt/wine/lib:/opt/wine/lib/wine
fi

if [ -d /opt/chess ]; then
	LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/chess/lib
	LD_RUN_PATH=$LD_RUN_PATH:/opt/chess/lib
	PATH=$PATH:/opt/chess/bin
fi

if [ -d /opt/photo ]; then
	LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/photo/lib
	LD_RUN_PATH=$LD_RUN_PATH:/opt/photo/lib
	PATH=$PATH:/opt/photo/bin
fi

PATH=$PATH:/bin
PATH=$PATH:/usr/bin
PATH=$PATH:/usr/X11R6/bin
PATH=$PATH:/usr/bin/X11
PATH=$PATH:/usr/games
PATH=$PATH:/opt/bin
PATH=$PATH:/opt/Go/bin

if [ -f /etc/PATH ]; then
	PATH=$PATH:`cat /etc/PATH`
fi 


# MuPAD needs this, it will not run otherwise!!!
MuPAD_ROOT_PATH="/usr/local/mupad25"
PATH=$MuPAD_ROOT_PATH/share/bin:$PATH

export PATH 
export LD_RUN_PATH
export LD_LIBRARY_PATH 
export MuPAD_ROOT_PATH

