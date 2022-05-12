#
# ~/.bash_profile
#
# https://wiki.archlinux.org/title/environment_variables#Per_user
# https://wiki.archlinux.org/title/Node.js_#Allow_user-wide_installations
# 1. try .profile 
# 2. isn't in $PATH
# 3. try .bash_profile
PATH="$HOME/.local/bin:$PATH"
export npm_config_prefix="$HOME/.local"

# default
[[ -f ~/.bashrc ]] && . ~/.bashrc
