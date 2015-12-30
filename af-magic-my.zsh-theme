#!/bin/zsh
# af-magic-my.zsh-theme

# color vars
local prompt_c_line="$FG[237]"

#if [ $UID -eq 0 ]; then NCOLOR="red"; else NCOLOR="green"; fi
#local prompt_status="%(?.$FG[022]ok.%{$fg[red]%}%?)"
local prompt_time="$FG[240]%D{%Y-%m-%d %H:%M:%S.%.}"

function prompt_status() {
	# Get the exit code.
	# Must be run before any other command.
	local status_num=$?

	local -A codes
	codes=(
		  2 'usage'		# Bad usage

		 64 'usage'		# command line usage error
		 65 'dataerr'	# data format error
		 66 'noinput'	# cannot open input
		 67 'nouser'	# addressee unknown
		 68 'nohost'	# host name unknown
		 69 'unavail'	# service unavailable
		 70 'software'	# internal software error
		 71 'oserr'		# system error (e.g., can't fork)
		 72 'osfile'	# critical OS file missing
		 73 'creat'		# can't create (user) output file
		 74 'ioerr'		# input/output error
		 75 'tempfail'	# temp failure; user is invited to retry
		 76 'proto'		# remote error in protocol
		 77 'noperm'	# permission denied
		 78 'config'	# configuration error

		126 'nexec'		# Cannot execute
		127 'noent'		# Not found
		128 'badarg'	# Bad arguments

		129	'sighup'	# Hangup (POSIX).
		130	'sigint'	# Interrupt (ANSI).
		131	'sigquit'	# Quit (POSIX).
		132	'sigill'	# Illegal instruction (ANSI).
		133	'sigtrap'	# Trace trap (POSIX).
		134	'sigabrt'	# Abort (ANSI).
		135	'sigbus'	# BUS error (4.2 BSD).
		136	'sigfpe'	# Floating-point exception (ANSI).
		137	'sigkill'	# Kill, unblockable (POSIX).
		138	'sigusr1'	# User-defined signal 1 (POSIX).
		139	'sigsegv'	# Segmentation violation (ANSI).
		140	'sigusr2'	# User-defined signal 2 (POSIX).
		141	'sigpipe'	# Broken pipe (POSIX).
		142	'sigalrm'	# Alarm clock (POSIX).
		143	'sigterm'	# Termination (ANSI).
		144	'sigstkflt' # Stack fault.
		145	'sigchld'	# Child status has changed (POSIX).
		146	'sigcont'	# Continue (POSIX).
		147	'sigstop'	# Stop, unblockable (POSIX).
		148	'sigtstp'	# Keyboard stop (POSIX).
		149	'sigttin'	# Background read from tty (POSIX).
		150	'sigttou'	# Background write to tty (POSIX).
		151	'sigurg'	# Urgent condition on socket (4.2 BSD).
		152	'sigxcpu'	# CPU limit exceeded (4.2 BSD).
		153	'sigxfsz'	# File size limit exceeded (4.2 BSD).
		154	'sigvtalrm' # Virtual alarm clock (4.2 BSD).
		155	'sigprof'	# Profiling alarm clock (4.2 BSD).
		156	'sigwinch'	# Window size change (4.3 BSD, Sun).
		157	'sigio'		# I/O now possible (4.2 BSD).
		158	'sigpwr'	# Power failure restart (System V).
		159	'sigsys'	# Bad system call.

		255 'range'		# Exit code out of range
	)

	case $status_num in
		0)
			echo "$FG[022]ok"
			;;
		*)
			if ((${+codes[$status_num]}))
			then
				echo "$fg[red]$status_num$FG[052]:$fg[red]${codes[$status_num]}"
			else
				echo "$fg[red]$status_num"
			fi
			;;
	esac
}

# git settings
ZSH_THEME_GIT_PROMPT_PREFIX="$FG[023]"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="$FG[214]*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$prompt_c_line │ "

# Generates the first line of the prompt.
function prompt1_gen() {
	# Parse the exit status before anything else.
	local status_str="$(prompt_status)"

	# The inner text of the prompt.
	local p="[ $(git_prompt_info)${status_str}$prompt_c_line │ ${prompt_time}$prompt_c_line ]"

	# Delete color codes, so we know how long (in characters) the text is.
	local zero='*m'

	# Calculate the length of the prompt text.
	local plen=${#${(S%%)p//$~zero/}}

	# Right-align and pad the prompt text, and return the result.
	echo "$prompt_c_line$(printf "─"%.0s {1..$(($COLUMNS-$plen-3))})$p──"
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
#	RPROMPT='$(virtualenv_prompt_info)$my_gray%n@%m%{$reset_color%}%'
# else
#	RPROMPT='$my_gray%n@%m%{$reset_color%}%'
# fi
