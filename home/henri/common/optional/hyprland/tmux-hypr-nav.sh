#!/usr/bin/env sh
#
# tmux-hypr-nav - Use the same bindings to move focus between hyprland windows
# and tmux splits. Requires the accompanying tmux conf and jq.

dir="$1"

case "$dir" in
u) ;;
r) ;;
d) ;;
l) ;;
*)
	echo "USAGE: $0 u|r|d|l"
	exit 1
	;;
esac

get_tmux_movement() {
	# see the tmux keybindings config section "Smart pane switching with hyprland"
	case "$1" in
	u) echo "k" ;;
	r) echo "l" ;;
	d) echo "j" ;;
	l) echo "g" ;; # because 'h' was already taken by tmux-copycat plugin
	*)
		return 1
		;;
	esac
	return 0
}

send_tmux_movement() {
	# effectivly simulate a CTRL-ALT-<tmux-direction-key> (if this script was triggered by a CTRL key)
	# because of bug : wtype keep the current mod key pressed : so we need to add CTRL to the tmux conf
	wtype -M alt "$(get_tmux_movement "$1")"
}

get_descendant_vim_pid() {
	pid="$1"
	terms="$2"

	if grep -iqE '^g?(view|n?vim?x?)(diff)?$' "/proc/$pid/comm"; then
		if embed_pid="$(pgrep --parent "$pid" --full 'nvim --embed')"; then
			echo "$embed_pid"
		else
			echo "$pid"
		fi

		return 0
	fi

	for child in $(pgrep --runstates D,I,R,S --terminal "$terms" --parent "$pid"); do
		if get_descendant_vim_pid "$child" "$terms"; then
			# already echo'd PID in recursive call
			return 0
		fi
	done

	return 1
}

get_descendant_tmux_pid() {
	pid="$1"
	terms="$2"

	if grep -iqE '^tmux: client$' "/proc/$pid/comm"; then
		echo "$pid"
		return 0
	fi

	for child in $(pgrep --runstates D,I,R,S --terminal "$terms" --parent "$pid"); do
		if get_descendant_tmux_pid "$child" "$terms"; then
			# already echo'd PID in recursive call
			return 0
		fi
	done

	return 1
}

if focused_pid="$(hyprctl activewindow -j | jq -e '.pid')"; then
	terms="$(find /dev/pts -type c -not -name ptmx | sed s#^/dev/## | tr '\n' ,)"
	# if get_descendant_tmux_pid "$focused_pid" "$terms"; then
	if tmux_pid="$(get_descendant_tmux_pid "$focused_pid" "$terms")"; then
		send_tmux_movement "$dir" "$tmux_pid"
	else
		hyprctl dispatch movefocus "$dir"
	fi
fi
