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


bindkey -e

bindkey "^[[H"    beginning-of-line
bindkey "^[[F"    end-of-line
# bindkey "^[[2~"   overwrite-mode
bindkey "^[[3~"   delete-char
#bindkey "^[[A"    up-line-or-history
#bindkey "^[[B"    down-line-or-history
bindkey "^[[D"    backward-char
bindkey "^[[C"    forward-char
#bindkey "^[[5~"   history-beginning-search-backward
#bindkey "^[[6~"   history-beginning-search-forward
bindkey "^[[1;2A" history-beginning-search-backward
bindkey "^[[1;2B" history-beginning-search-forward

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N            up-line-or-beginning-search
zle -N            down-line-or-beginning-search
bindkey "^[[A"    up-line-or-beginning-search
bindkey "^[[B"    down-line-or-beginning-search

function exit_zsh { exit }
zle -N            exit_zsh
bindkey '^D'      exit_zsh

# TAB           Completion for commands and file/directory names
# Ctrl + Shift  Switching between keyboard layouts

## MOVING CURSOR:
# Ctrl + a      Go to the beginning of the line (Home)
# Ctrl + e      Go to the End of the line (End)
# Ctrl + p      Previous command (Up)
# Ctrl + n      Next command (Down)
# Ctrl + f      Forward one character (Right)
# Ctrl + b      Backward one character (Left)
#  Alt + f      Forward one word
#  Alt + b      Backward one word

## EDITING:
# Ctrl + l      Clear the Screen, similar to the clear command.
#
# Ctrl + d      Delete character under the cursor.
# Ctrl + h      Delete character before the cursor (Backspace)
#  Alt + d      Delete the word after the cursor.
#  Alt + Del    Delete the word before the cursor.
#
# Ctrl + k      Cut the Line after the cursor to the clipboard.
# Ctrl + u      Cut the Line before the cursor to the clipboard.
# Ctrl + w      Cut the Word before the cursor to the clipboard.
# Ctrl + y      Paste the last thing to be cut (yank)
#
#  Alt + t      Swap current word with previous.
# Ctrl + t      Swap the last two characters before the cursor.
#  Esc + t      Swap the last two words before the cursor.
#
#  Alt + u      Uppercase every character from the cursor to the end of the current word.
#  Alt + l      Lowercase every character from the cursor to the end of the current word.
#  Alt + c      Capitalize the character under the cursor and move to the end of the word.
#  Alt + r      Cancel the changes and put back the line as it was in the history (revert).
# Ctrl + _      Undo

## HISTORY:
# Ctrl + r      Recall the last command including the specified character(s)
# Ctrl + p      Previous command in history
# Ctrl + n      Next command in history
# Ctrl + s      Go back to the next most recent command. 
#               (beware to not execute it from a terminal because this will also launch its XOFF).
# Ctrl + o      Execute the command found via Ctrl+r or Ctrl+s
# Ctrl + g      Exit from history searching mode
#
#       !!      Repeat last command
#     !abc      Run last command starting with abc
#   !abc:p      Print last command starting with abc
#       !$      Last argument of previous command
#  ALT + .      Last argument of previous command
#       !*      All arguments of previous command
# ^abc­^­def      Run previous command, replacing abc with def

## PROCESS CONTROLS:
# Ctrl + c      Interrupt/Kill whatever you are running (SIGINT)
# Ctrl + l      Clear the screen
# Ctrl + s      Stop output to the screen. Then use PgUp/PgDn for navigation
#               (for long running verbose commands)
# Ctrl + q      Allow output to the screen (if previously stopped using command above)
# Ctrl + d      Send an EOF marker, unless disabled by an option, this will close the current shell (EXIT).
# Ctrl + z      Send the signal SIGTSTP to the current task, which suspends it.
#               To return to it later enter fg 'process name' (foreground).
#
## SPECIAL KEYS:
# Ctrl + I      Tab
# Ctrl + J      Newline
# Ctrl + M      Enter
#
# Ctrl + v      Tells the terminal to not interpret the following character 
#               (can be used to enter control character)

## CONTROL CHARACTERS:
# Ctrl + 2      ^@
# Ctrl + [      Escape
# Ctrl + 3      ^[ = Escape
# Ctrl + 4      ^\
# Ctrl + 5      ^]
# Ctrl + 6      ^^
# Ctrl + 7      ^_ = Undo
# Ctrl + 8      ^? = Backward-delete-char
