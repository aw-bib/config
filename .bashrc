#!/bin/bash
#
# Last update: Sun, 2004/02/01, 11:14:38
#
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

case $TERM in
    xterm*)
        PROMPT_COMMAND='echo -ne "\033]0;${HOSTNAME}: ${PWD}\007"'
        ;;
esac

export PS1='(\!)\w [\h]$ '
export PS2='contd: '

# vi-like keybindings
if [ $USER = "arwagner" ]; then
    set -o vi
fi

set histfile ~/.bash_history
set histsize 1000
set histcontrol ignoredups

# set PROMPT_COMMAND echo -ne '\033]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007'

# visible bell (like in vim)
set bell-style visible

source $HOME/.env.sh
source $HOME/.path.sh
source $HOME/.aliases.sh
