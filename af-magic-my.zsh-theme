#!/bin/zsh
# af-magic-my.zsh-theme

# color vars
local c_line="$FG[237]"

#if [ $UID -eq 0 ]; then NCOLOR="red"; else NCOLOR="green"; fi
local prompt_status="%(?.$FG[022]ok.%{$fg[red]%}%?)"
local prompt_time="$FG[240]%D{%Y-%m-%d %H:%M:%S.%.}"

# git settings
ZSH_THEME_GIT_PROMPT_PREFIX="$FG[023]"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="$FG[214]*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$c_line │ "

function prompt1_gen() {
	local fake_status=$(($? ? $? : 12)) # fake prompt status (%? is not usable in (S%%) substitution)
	local p_real="[ $(git_prompt_info)${prompt_status}$c_line │ ${prompt_time}$c_line ]" # real prompt to be displayed
	local p_fake="[ $(git_prompt_info)${fake_status}$c_line │ ${prompt_time}$c_line ]" # fake prompt for length calculation
	local zero='*m'				# ANSI code pattern to delete
	local plen=${#${(S%%)p_fake//$~zero/}} # length of the prompt
	echo "$c_line$(printf "─"%.0s {1..$(($COLUMNS-$plen-3))})$p_real──"
}

# primary prompt
PROMPT='$(prompt1_gen)%{$reset_color%}
$FG[032]%~ \
%(!.$fg[red]#.$FG[105]»)%{$reset_color%} '
PROMPT2='%{$fg[red]%}\ %{$reset_color%}'
RPS1='${return_code}'


# right prompt
# if type "virtualenv_prompt_info" > /dev/null
# then
# 	RPROMPT='$(virtualenv_prompt_info)$my_gray%n@%m%{$reset_color%}%'
# else
# 	RPROMPT='$my_gray%n@%m%{$reset_color%}%'
# fi
