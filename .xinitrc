#!/bin/sh

#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)
#
# If we come from SLiM (and not gdm e.g.) this file is used to set the
# detfault session we want to log in. Otherwise one needs to set it by
# F1 at every login.
# To reenable F1 session settings use
#	exec $1
# below
limit coredumpsize 0
[[ -f $HOME/.Xresources ]] && xrdb -merge $HOME/.Xresources
exec startxfce4

