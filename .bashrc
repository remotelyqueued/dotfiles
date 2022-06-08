###
# arch
##

# shell options
shopt -s histappend

# https://wiki.archlinux.org/title/bash#Common_programs_and_options
# sourced in /etc/bash.bashrc
# [[ $- != *i* ]] && return
# shopt -s checkwinsize
# source /usr/share/bash-completion/bash_completion

# https://wiki.archlinux.org/title/bash#Shorter_history
HISTCONTROL=erasedups

# time
HISTTIMEFORMAT='%D %I:%M %p '

# number of lines stored during session
HISTSIZE=

# number of lines stored in file after session
HISTFILESIZE=

# decrypt
# export SSLKEYLOGFILE=/home/ryan/.mozilla/ssl-key.log

# privoxy
# https://wiki.archlinux.org/title/privoxy
# http_proxy="http://localhost:8118"

# colorize less
# https://wiki.archlinux.org/title/Color_output_in_console#less
export LESS='-R --use-color -Dd+r$Du+b'

# colorize man
# https://wiki.archlinux.org/title/Color_output_in_console#man
export MANPAGER='less -R --use-color -Dd+r -Du+b'

# default nvim
export EDITOR=nvim
export VISUAL=nvim

# https://wiki.archlinux.org/title/environment_variables#Per_user
# https://wiki.archlinux.org/title/Node.js_#Allow_user-wide_installations
# located in .profile
# 1. isn't in $PATH, trying .bash-profile
# PATH="$HOME/.local/bin:$PATH"
# export npm_config_prefix="$HOME/.local"

# fzf interactive search
# https://wiki.archlinux.org/title/fzf
source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash

# https://unix.stackexchange.com/questions/93476/gnome-terminal-keep-track-of-directory-in-new-tab
source /etc/profile.d/vte.sh

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
alias ip='ip --color=auto'
alias diff='diff --color=auto'
alias grep='grep -n --color=auto --exclude-dir=data_sets'

# shortcuts
alias l='ls --group-directories-first -la'
alias la='ls -A'
alias ll='ls -alF'
alias lt='lsd -liFS'
alias mount='mount | column -t'
alias duffy='sudo du -sch .[!.]* * | sort -rh'

# test entropy
# https://wiki.archlinux.org/title/Random_number_generation#/dev/random
alias ent='cat /proc/sys/kernel/random/entropy_avail'
alias pool='cat /proc/sys/kernel/random/pools'

# netctl
# https://wiki.archlinux.org/title/netctl#Obfuscate_wireless_passphrase
alias wifi='sudo wifi-menu -o'

# extend sudo timeout
# https://wiki.archlinux.org/title/Sudo#Passing_aliases
alias sudo='sudo -v; sudo '

# man reflector
alias reflect="sudo reflector --verbose --protocol https \
  --latest 6  --sort rate --country 'United States'\
  --save /etc/pacman.d/mirrorlist"

# static server
alias serve="http-server -p 5500 --cors -c-1 --log-ip -r"

# https://wiki.archlinux.org/title/Pacman/Tips_and_tricks#Browsing_packages
alias sc="pacman -Qq | fzf --preview 'pacman -Qil {}' \
  --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'"

# sublime text
alias subl='firejail subl'

# systemd
# +adm / +wheel group
alias failed='systemctl --failed'
alias journal='journalctl -p 3 -xb'

# kvm qemu
alias vm-start='sudo systemctl start libvirtd.service &&
  sudo virsh net-start default &&
  sudo virsh net-list --all'

alias vm-stop='sudo virsh net-destroy default &&
  sudo systemctl stop libvirtd.service &&
  sudo systemctl stop libvirtd-admin.socket &&
  sudo systemctl stop libvirtd-ro.socket &&
  sudo systemctl stop libvirtd.socket'

alias tracep="for ttl in {1..30}; do ping -4 -c 1 -t $ttl example.com && break; done | grep -i from | nl -s ' ' -w 2"

# razer
alias razer-start='systemctl --user start openrazer-daemon.service'
alias razer-stop='systemctl --user stop openrazer-daemon.service'
