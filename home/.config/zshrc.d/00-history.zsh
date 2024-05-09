#!/usr/bin/env zsh
#  _     _     _
# | |__ (_)___| |_ ___  _ __ _   _
# | '_ \| / __| __/ _ \| '__| | | |
# | | | | \__ \ || (_) | |  | |_| |
# |_| |_|_|___/\__\___/|_|   \__, |
#                            |___/

# The name of the file in which command history is saved.
export HISTFILE="$XDG_STATE_HOME"/zsh_history

# The maximum number of lines contained in the history file.
export SAVEHIST=50000

# The number of commands to remember in the command history.
export HISTSIZE=50000

setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
