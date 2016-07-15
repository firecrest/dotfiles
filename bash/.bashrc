#
# ~/.bashrc
#

## Prompt
PS1='\[\e[0;32m\]\u@\h\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] \[\e[1;37m\]'
# Basic PS1
#PS1='\[\e[1;32m\][\u@\h \W]\$\[\e[0m\] '

# Figure out what os/distro we are on
IS_MAC=
IS_LINUX=
DISTRO=
OS=
VERSION=

if which uname &> /dev/null; then
    OS=`uname`
fi

if [[ "$OS" == 'Darwin' ]]; then
    DISTRO='OSX'
    IS_MAC=1
elif [[ "$OS" == 'Linux' ]]; then
    IS_LINUX=1
    if [[ -f /etc/gentoo-release ]]; then
        DISTRO='Gentoo'
    elif [[ -f /etc/redhat-release ]]; then
        DISTRO=`awk '{ print $1 }' /etc/redhat-release`
    elif [[ -f /etc/debian_version ]]; then
        DISTRO='Debian'
    elif [[ -f /etc/arch-release ]]; then
        DISTRO='Arch'
    elif [[ -f /etc/lsb*release ]]; then
        eval `cat /etc/lsb*release`
        DISTRO=$DISTRIB_ID
    fi
fi

#
# Aliases
#

## Modifed Commands
alias ls='ls -alF --color=auto --group-directories-first'
alias grep='grep --color=auto'
alias nano='nano -w'
alias du='du -c -h'                    # Disk Usage, with grand total in human readable form
alias mkdir='mkdir -p -v'              # Make parent directories, verbose to detail what directories were created
# We want i(nteractive) prompts for safety
alias rm='rm -I'			# Prompt if removing more than 3 files or removing recursively
alias mv='mv -i'	       		# Prompt if overwriting a file
alias cp='cp -i'			# Prompt if overwriting a file

## New commands
alias dutotal='du -cs * | sort -h'     # Disk Usage, grand total, summaries only, piped to sort to display in order of size
alias myip="curl http://ipecho.net/plain; echo"
alias installed="sudo tune2fs -l /dev/sda8 | sudo grep 'Filesystem created:'"
#Keyboard mappings
alias mapcaps="setxkbmap -option 'ctrl:swapcaps'"
alias unmapcaps="setxkbmap -option"

# Following remove or copy directories recurvsively
alias cpdir='cp -r'			# Required arguments <dir> <newdir>
alias rmdir='rm -r'			# Required argument <dir>
# Navigation
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias dotfiles='cd ~/dotfiles'

# Back up aliases
alias etcbackup='sudo tar -cjf etc-backup.tar.bz2 /etc'

# Emacs running as a daemon (Systemd) so emacs aliases:
alias emt='emacsclient -t'
alias em='emacsclient -c -a emacs' # opens the GUI with alternate non-daemon
alias stopemacs='emacsclient --eval "(kill-emacs)"'

## Privileged access
alias scat='sudo cat'
alias svim='sudo vim'
alias snano='sudo nano'
alias root='sudo su'
alias poweroff='sudo systemctl poweroff'
alias reboot='sudo systemctl reboot'
alias halt='sudo systemctl halt'

# Private aliases
if [ -f ~/.bash.d/.aliases.private ]; then
    source ~/.bash.d/.aliases.private
fi

# default editor
export ALTERNATE_EDITOR=""
export EDITOR='emacsclient -c'
# The following sets the editor to be used when using 'sudo -e'
# So can simply type 'sudo -e <file>' to edit a file as root
# using the emacs daemon
export SUDO_EDITOR='emacsclient -c'

export PATH="${PATH}:/home/mark/Scripts/maintenance"

# Private env variables
if [ -f ~/.bash.d/.env.private ]; then
    source ~/.bash.d/.env.private
fi

# mutt background fix
COLORFGBG="default;default"

## Arch Linux specific .bashrc details
if [[ "$DISTRO" == 'Arch' ]]; then
    source ~/.bash.d/.arch.bash
fi

# Check for local customisation file and source if exists to override for local machine
if [ -f ~/.bashrc_local ]; then
    source ~/.bashrc_local
fi
# GVM
if [ -f ~/.bash.d/.gvm.private ]; then
    source ~/.bash.d/.gvm.private
fi
