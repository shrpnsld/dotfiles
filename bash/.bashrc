export BASH_SILENCE_DEPRECATION_WARNING=1
export CLICOLOR=1

source ~/.config/bash/plugins/git
source ~/.config/bash/plugins/ranger

PS1='\[\e]0;\w\a\]\n\[\e[34m\]󰝰 \w\[\e[0m\]$(__git_pretty_status)\n '

[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

alias tmux='/usr/local/bin/tmux attach \; choose-tree -s || /usr/local/bin/tmux new-session -n ""'

