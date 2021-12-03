###
# arch

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# shell options
shopt -s histappend
shopt -s checkwinsize

# history behavior
# ignore duplicates and whitespace prefixed commands
HISTCONTROL=ignoreboth

# time
HISTTIMEFORMAT='%D %I:%M %p '

# number of lines stored during session
HISTSIZE=

# number of lines stored in file after session
HISTFILESIZE=

# https://wiki.archlinux.org/title/Color_output_in_console#less
export LESS='-R --use-color -Dd+r$Du+b'

# https://wiki.archlinux.org/title/Color_output_in_console#man
export MANPAGER='less -R --use-color -Dd+r -Du+b'

# use nvim
export EDITOR=nvim
export VISUAL=nvim

# fzf interactive search
# https://wiki.archlinux.org/title/fzf
source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash

# prompt colors
RESET=$(tput sgr0)
BLUE=$(tput setaf 4)
GREY=$(tput setaf 244)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)

# git
git_prompt() {
	BRANCH=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/*\(.*\)/\1/')
	if [ -n "$BRANCH" ]; then
		echo -n "$YELLOW$BRANCH"
	if [ -n "$(git status --short)" ]; then
		echo "${RED} ✗ "
	fi
fi
}

# prompt
PS1='\[$BLUE\w$(git_prompt)\]
\[$GREY\]$ \[$RESET\]'

# color
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias diff='diff --color=auto'

alias grep='grep --color=auto -n'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ip='ip --color=auto'

# shortcuts
alias ll='ls -alF'
alias la='ls -A'
alias lt='ls -altrh'
alias lr='ls -alSrh'
alias lll='lsd -liFS'
alias mount='mount | column -t'
alias l='ls --group-directories-first -la'
alias ldd='ls --group-directories-first -l'
alias duffy='sudo du -sch .[!.]* * | sort -rh'

# test entropy
alias ent='cat /proc/sys/kernel/random/entropy_avail'

# netctl
alias wifi='sudo wifi-menu -o'

# extend sudo timeout
alias sudo='sudo -v; sudo '

# update mirrors
alias reflect="sudo reflector --verbose --protocol https \
	--latest 6  --sort rate --country 'United States'\
	--save /etc/pacman.d/mirrorlist"

# package viewer
alias sc="pacman -Qq | fzf --preview 'pacman -Qil {}' \
	--layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'"

# sublime text
alias subl='firejail subl'

# nord
alias nord='nordvpn connect Seattle &&
	nordvpn settings &&
	nordvpn status'

#
# systemd
# +adm / +wheel group
alias failed='systemctl --failed'
alias journal='journalctl -p 3 -xb'

# vpn
# todo: switch to openvpn
# common issues:
# 	open-conn-track: timeout opening
#	[v1] magicsock: rx [1GaNB] set as new priority
#       [v2] [1GaNB]
#	if enabled - multiple connections are attempted at startup
alias vpn-start='sudo systemctl start nordvpnd.service'
	# nordvpn connect Canada && 
	# nordvpn settings && nordvpn status'

alias vpn-stop='sudo systemctl stop nordvpnd.service' 

# kvm qemu
alias vm-start='sudo systemctl start libvirtd.service &&
	sudo virsh net-start default &&
	sudo virsh net-list --all'

alias vm-stop='sudo virsh net-destroy default &&
	sudo systemctl stop libvirtd.service &&
	sudo systemctl stop libvirtd-admin.socket &&
	sudo systemctl stop libvirtd-ro.socket &&
	sudo systemctl stop libvirtd.socket'

# razer
alias razer-start='systemctl --user start openrazer-daemon.service'
alias razer-stop='systemctl --user stop openrazer-daemon.service'
