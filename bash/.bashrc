#
# ~/.bashrc
#

# Prompt
PS1='\[\e[0;32m\]\u@\h\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] \[\e[1;37m\]'
# Basic PS1
#PS1='\[\e[1;32m\][\u@\h \W]\$\[\e[0m\] '

#
# Aliases
#

# ls
alias ls='ls -alF --color=auto'
# grep
alias grep='grep --color=auto'
# nano 
alias nano='nano -w'

# Pacman aliases
alias pacupg='sudo pacman -Syu'        # Synchronize with repositories before upgrading packages that are out of date on the local system.
alias aurupdate='pacaur -Syua'	       # Update AUR packages on system using pacaur
alias update='pacaur -Syu'             # Update all packages, including AUR, using pacaur
alias pacdl='pacman -Sw'		# Download specified package(s) as .tar.xz ball
alias pacin='sudo pacman -S'           # Install specific package(s) from the repositories
alias pacinfile='sudo pacman -U'        # Install specific package not from the repositories but from a file 
alias pacre='sudo pacman -R'           # Remove the specified package(s), retaining its configuration(s) and required dependencies
alias pacrem='sudo pacman -Rns'        # Remove the specified package(s), its configuration(s) and unneeded dependencies
alias pacrep='pacman -Si'              # Display information about a given package in the repositories
alias pacsearch='pacman -Ss'             # Search for package(s) in the repositories
alias pacloc='pacman -Qi'              # Display information about a given package in the local database
alias paclocs='pacman -Qs'             # Search for package(s) in the local database
alias paclo="pacman -Qdt"		# List all packages which are orphaned
alias pacc="sudo pacman -Scc"		# Clean cache - delete all the package files in the cache
alias paclf="pacman -Ql"		# List all files installed by a given package
alias paclistaur='pacman -Qem'	       # List all 'foreign' packages (i.e. not from a pacman repository) - usually from the AUR
alias paclistinstalled='pacman -Qen'   # List all the explicitly installed packages from the repositories
alias pacremoveorphans='sudo pacman -Rs $(pacman -Qtdq)'
alias pacman-disowned-dirs="comm -23 <(sudo find / \( -path '/dev' -o -path '/sys' -o -path '/run' -o -path '/tmp' -o -path '/mnt' -o -path '/srv' -o -path '/proc' -o -path '/boot' -o -path '/home' -o -path '/root' -o -path '/media' -o -path '/var/lib/pacman' -o -path '/var/cache/pacman' \) -prune -o -type d -print | sed 's/\([^/]\)$/\1\//' | sort -u) <(pacman -Qlq | sort -u)"
alias pacman-disowned-files="comm -23 <(sudo find / \( -path '/dev' -o -path '/sys' -o -path '/run' -o -path '/tmp' -o -path '/mnt' -o -path '/srv' -o -path '/proc' -o -path '/boot' -o -path '/home' -o -path '/root' -o -path '/media' -o -path '/var/lib/pacman' -o -path '/var/cache/pacman' \) -prune -o -type f -print | sort -u) <(pacman -Qlq | sort -u)"
# Locate .pacnew files
alias pacnew='find /etc -regextype posix-extended -regex ".+\.pac(new|save|orig)" 2> /dev/null'

# Back up aliases
alias pacdbbackup='tar -cjf pacman_database.tar.bz2 /var/lib/pacman/local'
alias etcbackup='sudo tar -cjf etc-backup.tar.bz2 /etc'

# Emacs running as a daemon (Systemd) so emacs aliases:
alias emt='emacsclient -t'
alias em='emacsclient -c -a emacs' # opens the GUI with alternate non-daemon
alias stopemacs='emacsclient --eval "(kill-emacs)"'

# Privileged access
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

# Private env variables
if [ -f ~/.bash.d/.env.private ]; then
    source ~/.bash.d/.env.private
fi

# mutt background fix
COLORFGBG="default;default"

# Arch latest news
if [ "$PS1" ] && [[ $(ping -c1 www.google.com 2>&-) ]]; then
	# The characters "£, §" are used as metacharacters. They should not be encountered in a feed...
	echo -e "$(echo $(curl --silent https://www.archlinux.org/feeds/news/ | awk ' NR == 1 {while ($0 !~ /<\/item>/) {print;getline} sub(/<\/item>.*/,"</item>") ;print}' | sed -e ':a;N;$!ba;s/\n/ /g') | \
		sed -e 's/&amp;/\&/g
		s/&lt;\|&#60;/</g
		s/&gt;\|&#62;/>/g
		s/<\/a>/£/g
		s/href\=\"/§/g
		s/<title>/\\n\\n\\n   :: \\e[01;31m/g; s/<\/title>/\\e[00m ::\\n/g
		s/<link>/ [ \\e[01;36m/g; s/<\/link>/\\e[00m ]/g
		s/<description>/\\n\\n\\e[00;37m/g; s/<\/description>/\\e[00m\\n\\n/g
		s/<p\( [^>]*\)\?>\|<br\s*\/\?>/\n/g
		s/<b\( [^>]*\)\?>\|<strong\( [^>]*\)\?>/\\e[01;30m/g; s/<\/b>\|<\/strong>/\\e[00;37m/g
		s/<i\( [^>]*\)\?>\|<em\( [^>]*\)\?>/\\e[41;37m/g; s/<\/i>\|<\/em>/\\e[00;37m/g
		s/<u\( [^>]*\)\?>/\\e[4;37m/g; s/<\/u>/\\e[00;37m/g
		s/<code\( [^>]*\)\?>/\\e[00m/g; s/<\/code>/\\e[00;37m/g
		s/<a[^§|t]*§\([^\"]*\)\"[^>]*>\([^£]*\)[^£]*£/\\e[01;31m\2\\e[00;37m \\e[01;34m[\\e[00;37m \\e[04m\1\\e[00;37m\\e[01;34m ]\\e[00;37m/g
		s/<li\( [^>]*\)\?>/\n \\e[01;34m*\\e[00;37m /g
		s/<!\[CDATA\[\|\]\]>//g
		s/\|>\s*<//g
		s/ *<[^>]\+> */ /g
		s/[<>£§]//g')\n\n";
fi
# Check for local customisation file and source if exists to override for local machine
if [ -f ~/.bashrc_local ]; then
    source ~/.bashrc_local
fi
# GVM
if [ -f ~/.bash.d/.gvm.private ]; then
    source ~/.bash.d/.gvm.private
fi
