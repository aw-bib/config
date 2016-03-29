#!/bin/tcsh
#
# Aliases for csh-like shells
#
# Last update: Wed, 2004/03/10, 15:31:16
#
if ( $HOSTTYPE == "alpha" ) then
        if ($OSTYPE == "osf1") then
        # OSF1 == Tru64 on an Alpha:
                alias gpi        "/usr/local_dec/arwagner/gnuplot38/bin/gnuplot"
                # set color=ls-F
                # alias ls         "ls-F"
                alias ll         "ls -ali"
                alias l.         "ls -d .[a-zA-Z]*"
                alias make       "gmake"
                alias mc         "mc -b"
        else if ($OSTYPE == "linux") then
        # linux == Linux on an Alpha:
                alias ls         "ls --color=tty"
                alias ll         "ls -ali --color=tty"
                alias l.         "ls -d .[a-zA-Z]* --color=tty"
        endif
#
# Linux on a intel-PC
else if ( $HOSTTYPE == "i386-linux" ) then
        stty erase "^H" erase "^?"
        alias ls         "ls --color=tty"
        alias ll         "ls -ali --color=tty"
        alias l.         "ls -d .[a-zA-Z]* --color=tty"
        alias gpi        "gnuplot"
else if ( $HOSTTYPE == "x86_64" ) then
        stty erase "^H" erase "^?"
        alias ls         "ls --color=tty"
        alias ll         "ls -ali --color=tty"
        alias l.         "ls -d .[a-zA-Z]* --color=tty"
        alias gpi        "gnuplot"
#
# HP-UX on a HP-RISC-Workstation
else if ( $HOSTTYPE == "hp9000s700" ) then
        alias make       "gmake"
        set color=ls-F

#
# None of the above. In generic there should go only shell scripts
else
        set color=ls-F
        alias ls         "ls --color=tty"
        alias ll         "ls -ali"
        alias l.         "ls -d .[a-zA-Z]*"
        alias make       "gmake"
        alias build      "gmake clean; gmake"
        alias mc         "mc -b"
endif

# The usual bindings
if ( -e `which vim` ) then
        alias vi     "vim"
        alias gvi    "gvim"
        alias se     "vim -S Session.vim"
        alias gse    "gvim -S Session.vim"
        alias di     "vimdiff"
        alias gdi    "gvimdiff"
        alias vr     "gvim --remote "
        alias help   "vim -R $HOME/man"
endif 
alias 2a4    "psnup -pA4 -2 "
alias prn    "lp -o media=recycled"
alias 2p     "prn -od "
alias lc     "wc -l"
alias uni    "unison -auto "
alias .      source
alias ff     "locate"

# Create a booklet for duplex printing:
alias book   'pstops "4:-3L@.7(21cm,0)+0L@.7(21cm,14.85cm),1L@.7(21cm,0)+-2L@.7(21cm,14.85cm)"'

# Some aliases for programming
# Note that these require certain tags within the makefile!
alias build  "make clean; make"
alias run    "make run"
alias debug  "make debug"
alias plot   "make plot"
alias ,b     "build"
alias ,m     "make"
alias ,r     "run"

alias ftp    "lftp"
alias h      "history"
alias d      "dirs"
alias pd     "pushd"
alias d2     "pushd +2"
alias po     "popd"

# DOS-style aliases
alias rd     "rmdir"
alias md     "mkdir"
alias ren    "mv"
alias dir    "ls"
alias cls    "clear"

# Some vi style
alias :q     "exit"
alias :q!    "exit"
alias :e     $EDITOR

alias :Gstatus "git status"
alias :Gdiff   "git status"
alias :Glog    "git log"
alias :Gpull   "git pull"
alias :Gpush   "git push"

alias un     "uname -smpr"
alias cpu    "ps aux | awk 'NR == 1 || \$3 > 0'"
alias gi     "grep  -in "
alias sps    "paper hep-ph0201233"

# Change directories
alias pd..   "pd .."

alias nav  "exo-open "

# Some terminal aliases. It comes in handy to have some terms with
# different colours. Names are just conventions from a project.
alias gitterm   'xterm -bg lightgreen -fg black'
alias cdsterm   'xterm -bg yellow -fg black'

alias pyterm    'xterm -T "iPython [`hostname`]" +sb -fa Monospace -fs 12 -sl 5000 -bg black -fg white -e ipython'
alias perlterm  'xterm -T "Perl [`hostname`]"    +sb -fa Monospace -fs 12 -sl 5000 -bg black -fg white -e perl -d -e 1'

if ( -e $HOME/.aliases.csh.local ) then 
	source $HOME/.aliases.csh.local
fi
