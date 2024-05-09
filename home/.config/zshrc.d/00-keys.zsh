#!/usr/bin/env zsh
#  _
# | | _____ _   _ ___
# | |/ / _ \ | | / __|
# |   <  __/ |_| \__ \
# |_|\_\___|\__, |___/
#           |___/
#
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

unsetopt BEEP

bindkey -e

bindkey "^[[H"    beginning-of-line
bindkey "^[[F"    end-of-line
bindkey "^[[2~"   overwrite-mode
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
