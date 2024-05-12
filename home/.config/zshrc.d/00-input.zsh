#!/usr/bin/env zsh
#  _                   _
# (_)_ __  _ __  _   _| |_
# | | '_ \| '_ \| | | | __|
# | | | | | |_) | |_| | |_
# |_|_| |_| .__/ \__,_|\__|
#         |_|

# The name of the file in which command history is saved.
export HISTFILE="$XDG_STATE_HOME"/zsh_history

# The maximum number of lines contained in the history file.
export SAVEHIST=50000

# The number of commands to remember in the command history.
export HISTSIZE=50000

# Do not enter command lines into the history list if they are duplicates
# of the previous event.
setopt HIST_IGNORE_DUPS

# Remove command lines from the history list when the first character
# on the line is a space, or when one of the expanded aliases contains
# a leading space. Only normal aliases (not global or suffix aliases)
# have this behaviour. Note that the command lingers in the internal
# history until the next command is entered before it vanishes, allowing
# you to briefly reuse or edit the line. If you want to make it vanish
# right away without entering another command, type a space and press return.
setopt HIST_IGNORE_SPACE

# Do not require a leading ‘.’ in a filename to be matched explicitly.
setopt GLOB_DOTS

# Prevents aliases on the command line from being internally substituted
# before completion is attempted. The effect is to make the alias a distinct
# command for completion purposes.
setopt COMPLETE_ALIASES

# If a command is issued that can’t be executed as a normal command, and
# the command is the name of a directory, perform the cd command to that directory.
setopt AUTO_CD

# Do not beep on error in ZLE.
unsetopt BEEP

# Fish-like autosuggestions for zsh.
# It suggests commands as you type based on history and completions.
source_if_exists "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"


autoload -Uz compinit && compinit -d "$XDG_CACHE_HOME"/zcompdump

zstyle ':compinstall'                   filename "$HOME"/.zshrc

zstyle ':completion:*'                  rehash true
zstyle ':completion:*'                  menu select

# zstyle ':completion:*:pacman:*'         force-list always
# zstyle ':completion:*:*:pacman:*'       menu true select
# zstyle ':completion:*:kill:*'           force-list always
# zstyle ':completion:*:*:kill:*'         menu true select
# zstyle ':completion:*:killall:*'        force-list always
# zstyle ':completion:*:*:killall:*'      menu true select
# zstyle ':completion:*:processes-names'  command  "ps c -u $USER -o command | uniq"


typeset -g -A key

key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[Ctrl-Left]="${terminfo[kLFT5]}"
key[Ctrl-Right]="${terminfo[kRIT5]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Delete]="${terminfo[kdch1]}"
key[Backspace]="${terminfo[kbs]}"
key[Shift-Tab]="${terminfo[kcbt]}"

bindkey -e

# test -n "${key[Up]}"            && bindkey -- "${key[Up]}"          up-line-or-history
# test -n "${key[Down]}"          && bindkey -- "${key[Down]}"        down-line-or-history
test -n "${key[Ctrl-Left]}"     && bindkey -- "${key[Ctrl-Left]}"   backward-word
test -n "${key[Ctrl-Right]}"    && bindkey -- "${key[Ctrl-Right]}"  forward-word
test -n "${key[Home]}"          && bindkey -- "${key[Home]}"        beginning-of-line
test -n "${key[End]}"           && bindkey -- "${key[End]}"         end-of-line
test -n "${key[Delete]}"        && bindkey -- "${key[Delete]}"      delete-char

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
test -n "${key[Up]}"    && bindkey -- "${key[Up]}"                  up-line-or-beginning-search
test -n "${key[Down]}"  && bindkey -- "${key[Down]}"                down-line-or-beginning-search

function exit_zsh { exit }
zle -N            exit_zsh
bindkey '^D'      exit_zsh

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi
