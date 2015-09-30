#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Start Gnome-keyring for terminal keyring applications (e.g. ssh)
if [ -n "$DESKTOP_SESSION" ];then
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK
fi

[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx

#THIS MUST BE AT THE END OF THE FILE FOR GVM TO WORK!!!
[[ -s "/home/mark/.gvm/bin/gvm-init.sh" ]] && source "/home/mark/.gvm/bin/gvm-init.sh"
