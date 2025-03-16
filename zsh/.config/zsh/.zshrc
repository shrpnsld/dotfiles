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

zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

autoload -Uz select-bracketed select-quoted
zle -N select-quoted
zle -N select-bracketed

for keymap in viopp visual
do
	bindkey -M $keymap -- '-' vi-up-line-or-history
	for c in {a,i}${(s..)^:-\'\"\`\|,./:;=+@}
	do
		bindkey -M $keymap $c select-quoted
	done

	for c in {a,i}${(s..)^:-'()[]{}<>bB'}
	do
		bindkey -M $keymap $c select-bracketed
	done
done

#
# Aliases

source $ZDOTDIR/aliases/tmux
source $ZDOTDIR/aliases/ranger

