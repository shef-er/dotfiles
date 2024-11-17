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

# Running only 'history -a', without '-c' and '-r', is better usability-wise.
# It means commands you run are available instantly in new shells even
# before exiting the current shell, but not in concurrently running shells.
# This way Arrow-Up still always selects the last-run commands of
# the current session, which much less confusing.
#
# https://unix.stackexchange.com/questions/1288/preserve-bash-history-in-multiple-terminal-windows#comment67052_48116
PROMPT_COMMAND+=('history -a')

# If set, a command name that is the name of a directory is executed as
# if it were the argument to the cd command. This option is only used by
# interactive shells.
shopt -s autocd

# If set, bash includes filenames beginning with a '.' in the results
# of pathname expansion. The filenames '.' and '..' must always
# be matched explicitly, even if dotglob is set.
shopt -s dotglob

# If set, aliases are expanded as described above under ALIASES.
# This option is enabled by default for interactive shells.
shopt -s expand_aliases

# If set, and readline is being used, bash will not attempt to search
# the PATH for possible completions when completion is attempted on
# an empty line.
shopt -s no_empty_cmd_completion

# Controls what happens when readline wants to ring the terminal bell.
# If set to 'none', readline never rings the bell. If set to 'visible',
# readline uses a visible bell if one is available. If set to 'audible',
# readline attempts to ring the terminal's bell.
bind -m emacs 'set bell-style none'

# If set to 'On', when listing completions, readline displays the common
# prefix of the set of possible completions using a different color.
# The color definitions are taken from the value of the 'LS_COLORS'
# environment variable. If there is a color definition in '$LS_COLORS'
# for the custom suffix "readline-colored-completion-prefix",
# readline uses this color for the common prefix instead of its default.
bind -m emacs 'set colored-completion-prefix on'

# Search backward through the history for the string of characters between
# the start of the current line and the current cursor position (the point).
# The search string may match anywhere in a history line.
# This is a non-incremental search.
bind -m emacs '"\e[A": history-substring-search-backward'

# Search forward through the history for the string of characters between
# the start of the current line and the point. The search string may match
# anywhere in a history line. This is a non-incremental search.
bind -m emacs '"\e[B": history-substring-search-forward'

# bind -m emacs '"\e[A": history-search-backward'
# bind -m emacs '"\e[B": history-search-forward'
