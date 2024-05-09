#!/usr/bin/env bash
#  _                   _
# (_)_ __  _ __  _   _| |_
# | | '_ \| '_ \| | | | __|
# | | | | | |_) | |_| | |_
# |_|_| |_| .__/ \__,_|\__|
#         |_|

shopt -s expand_aliases
shopt -s no_empty_cmd_completion

bind -m emacs 'set bell-style none'

bind -m emacs 'set show-all-if-ambiguous on'
bind -m emacs 'set colored-completion-prefix on'

bind -m emacs 'TAB: menu-complete'
bind -m emacs '"\e[Z": menu-complete-backward'

bind -m emacs '"\e[A": history-search-backward'
bind -m emacs '"\e[B": history-search-forward'
