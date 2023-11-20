export BASH_SILENCE_DEPRECATION_WARNING=1
export CLICOLOR=1

PS1="\[\e]0;\w\a\]\n\[\e[32m\]\u@\h \[\e[33m\]\w\[\e[0m\]\n\$ "

function ranger()
{
	local IFS=$'\t\n'
	local temp_file="$(mktemp -t tmp.XXXXXX)"
	local cmd=(
		command
		ranger
		--cmd "map > chain shell echo %d > '$temp_file'; quitall"
	)

	${cmd[@]} "$@"
	if [ ! -r "$temp_file" ]
	then
		printf "\e[1;35mranger error:\e[0m failed to navigate to directory\n\n"
	fi

	cd -- "$(cat "$temp_file")"
	rm -f -- "$temp_file" #2 > /dev/null
}

alias tmux='/usr/local/bin/tmux attach \; choose-tree -s || /usr/local/bin/tmux new-session -n ""'

