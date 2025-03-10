fpath=($ZDOTDIR/plugins $fpath)

#
# Options

setopt PROMPT_SUBST

setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

#
# Prompt

source $ZDOTDIR/plugins/git-pretty-status

PROMPT='
%F{blue}󰝰 %~%f$(__git_pretty_status)
 '

RPROMPT=$'%F{60}%D{%Y-%m-%d}  %*%f'

zle -N __git-pretty-status-toggle
bindkey -M vicmd '^g' __git-pretty-status-toggle

#
# Vi

autoload -Uz vi-cursor; vi-cursor

bindkey -A viins main
export KEYTIMEOUT=1

#
# Aliases

source $ZDOTDIR/aliases/tmux
source $ZDOTDIR/aliases/ranger

