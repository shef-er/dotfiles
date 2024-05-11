#!/usr/bin/env bash
#  _                   _
# (_)_ __  _ __  _   _| |_
# | | '_ \| '_ \| | | | __|
# | | | | | |_) | |_| | |_
# |_|_| |_| .__/ \__,_|\__|
#         |_|

# A colon-separated list of values controlling how commands are saved on the
# history list.
export HISTCONTROL=ignoredups:ignorespace

# The name of the file in which command history is saved.
export HISTFILE="$XDG_STATE_HOME"/bash_history

# The maximum number of lines contained in the history file.
export HISTFILESIZE=50000

# The number of commands to remember in the command history.
export HISTSIZE=50000

# Format string to print the time stamp associated with each history entry.
export HISTTIMEFORMAT='%FT%T '

# When the shell exits, the history list is appended to the history file,
# rather than overwriting the file.
shopt -s histappend

# If set, aliases are expanded as described above under ALIASES.
# This option is enabled by default for interactive shells.
shopt -s expand_aliases

# If set, and readline is being used, bash will not attempt to search
# the PATH for possible completions when completion is attempted on
# an empty line.
shopt -s no_empty_cmd_completion

bind -m emacs 'set bell-style none'

bind -m emacs 'set show-all-if-ambiguous on'
bind -m emacs 'set colored-completion-prefix on'

bind -m emacs 'TAB: menu-complete'
bind -m emacs '"\e[Z": menu-complete-backward'

bind -m emacs '"\e[A": history-search-backward'
bind -m emacs '"\e[B": history-search-forward'
