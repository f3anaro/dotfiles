#!/bin/bash
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

HISTSIZE=100000                   # big big history
HISTFILESIZE=100000               # big big history
shopt -s histappend               # append to history, don't overwrite it

# Save and reload the history after each command finishes
# PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color)
        color_prompt=yes
        ;;
esac

# Fix current directory reporting for tilix and other VTE-based applications.
#
# @see https://gnunn1.github.io/tilix-web/manual/vteconfig/
#
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
    if [ -f /etc/profile.d/vte.sh ]; then
        source /etc/profile.d/vte.sh
    elif [ -f /etc/profile.d/vte-2.91.sh ]; then
        source /etc/profile.d/vte-2.91.sh
    fi
fi

# Uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

# Hook for PS1 showing an indicator when inside a virtual Python environment.
__virtualenv_ps1() {
  if [ -n "$VIRTUAL_ENV" ]; then
    echo "⬡"
    # echo "⮩ py"
  fi
}

# Uncomment the following line to display the hostname in the
# command line prompt
#prompt_host=yes

# Escape sequences for PS1 prompt
# -------------------------------
# 
# Time 12h   \T
# Time 12a   \@
# 
# Path Short \w
# Path Full  \W
# 
# Jobs \j
# User \u
# Host \h

if [ "$color_prompt" = yes ]; then
    # Include color definitions
    . $HOME/.colors

    # Build of Steve Losh's prompt
     
    # PS1="${debian_chroot:+($debian_chroot)}"
    # PS1+="${MonoBPink}\u "
    # PS1+="${BWhite}at "
    # PS1+="${CandyBOrange}\h "
    # PS1+="${BWhite}in "
    # PS1+="${BGreen}\w "
    # PS1+="$(__git_ps1 "${BWhite}on ${MonoBPink}%s ")"
    # PS1+="\n${BWhite}\$ $Color_Off"

    # Monokai inspired prompt theme
    PS1="${debian_chroot:+($debian_chroot)}"
    if [[ $EUID -ne 0 ]]; then
        PS1+="${MonoBGreen}\u"
    else
        PS1+="${BRed}\u"
    fi

    if [ "$prompt_host" = yes ] || [ ! -z "$SSH_CLIENT" ]; then
        PS1+="${CandyBGray}@"
        # PS1+="${CandyBGray} at " # A more verbose alternative
        PS1+="${CandyBOrange}\h "
    else
        PS1+=" "
    fi

    # PS1+="${CandyBGray}in "
    PS1+="${BWhite}\w "
    # PS1+="$(__git_ps1 "${CandyBGray}on ${MonoBPink}%s ")"
    PS1+="${MonoBPink}\$(__git_ps1 '${CandyBGray}on ${MonoBPink}%s ')"
    PS1+="${CandyBOrange}\$(__virtualenv_ps1)"
    PS1+="\n${BWhite}"
    if [[ $EUID -ne 0 ]]; then
      PS1+="\$"
    else
      PS1+="#"
    fi
    PS1+=" $Color_Off"
else
    # prompt without color support
    PS1="${debian_chroot:+($debian_chroot)}\u"

    # Use host only of flag is set
    if [ "$prompt_host" = yes ]; then
        PS1+="@\h "
    else
        PS1+=" "
    fi

    # Append short path and git status
    PS1+="\w \$(__git_ps1 'on %s ')\$(__virtualenv_ps1)\n\$ "
fi

# Clear flags
unset color_prompt force_color_prompt prompt_host


# Alias definitions.
# 
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
. $HOME/.complete_alias  # Utility function for completing aliases
. $HOME/.aliases

# Include common local binary directories
PATH="$HOME/.local/bin:$PATH"

export EDITOR=vim

# Enable direnv hook if available
if which direnv > /dev/null; then
    eval "$(direnv hook bash)"
fi

# added by travis gem
[ -f /home/lucas/.travis/travis.sh ] && source /home/lucas/.travis/travis.sh
