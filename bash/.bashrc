#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Prompt
PS1='\[\e[1;37m\][\u@\h\[\e[1;36m\] \w]\$ \[\033[0m\]'

# Dircolors
eval `dircolors ~/colors/dircolors-solarized-master/dircolors.ansi-dark`

# don't put duplicate lines in the history. See bash(1) for more options

# Expand the history size
HISTFILESIZE=50000
HISTSIZE=20000

# commands with leading space do not get added to history
HISTCONTROL=ignorespace
HISTCONTROL=ignoredups:erasedups

# Path
#=========================================
export TERM=xterm-256color
[[ $TMUX = ""  ]] && export TERM="xterm-256color"
export EDITOR=vim
export RUST_BACKTRACE=1
export GNOME_KEYRING_CONTROL GNOME_KEYRING_PID GPG_AGENT_INFO SSH_AUTH_SOCK
export GIT_PROMPT_FETCH_REMOTE_STATUS=0
export QT_GRAPHICSSYSTEM=native
export GOPATH=~/go
export PATH="$PATH:~/.composer/vendor/bin"
export PATH="$PATH:~/.gem/ruby/2.3.0/bin"
export PATH="$PATH:/vendor/bin"
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:~/scripts"
export PATH="$PATH:vendor/bin"
export PATH="$PATH:~/bin"
export PATH="$HOME/.cargo/bin:$PATH"

COWPATH="$COWPATH:$HOME/.cowsay"

# aliases
#=========================================
if [ -f ~/.bash_aliases ]; then
. ~/.bash_aliases
fi

if [ -f ~/.bash_private_aliases ]; then
. ~/.bash_private_aliases
fi
# Functions
#=========================================
if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi

if [ -f /usr/share/autojump/autojump.bash ]; then
  . /usr/share/autojump/autojump.bash
fi

# Start gnome keyring
eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)

# Don't break my balls when i accidentally type ctrl-S on vim
stty -ixon

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/base16-ocean.dark.sh"
[[ -s $BASE16_SHELL  ]] && source $BASE16_SHELL

function _update_ps1() {
	PS1="$(python2 ~/sources/powerline-shell/powerline-shell.py --cwd-max-depth 3 $? 2> /dev/null)"
}

if [ "$TERM" != "linux" ]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi
