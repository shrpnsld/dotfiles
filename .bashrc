export BASH_SILENCE_DEPRECATION_WARNING=1
export CLICOLOR=1

PS1="\u@\w$ "
#export W3MIMGDISPLAY_PATH='/Users/antondehtiar/Projects/w3m/w3mimgdisplay'

#[[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

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

