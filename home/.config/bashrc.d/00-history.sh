#!/usr/bin/env bash
#  _     _     _
# | |__ (_)___| |_ ___  _ __ _   _
# | '_ \| / __| __/ _ \| '__| | | |
# | | | | \__ \ || (_) | |  | |_| |
# |_| |_|_|___/\__\___/|_|   \__, |
#                            |___/

# A colon-separated list of values controlling how commands are saved on the history list.
export HISTCONTROL=ignoredups:ignorespace

# The name of the file in which command history is saved.
export HISTFILE="$XDG_STATE_HOME"/bash_history

# The maximum number of lines contained in the history file.
export HISTFILESIZE=50000

# The number of commands to remember in the command history.
export HISTSIZE=50000

# Format string to print the time stamp associated with each history entry.
export HISTTIMEFORMAT='%FT%T '

# When the shell exits, the history list is appended to the history file, rather than overwriting the file.
shopt -s histappend
