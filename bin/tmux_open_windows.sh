#!/bin/sh

if ! type tmux >/dev/null 2>&1; then
    echo 'Error: tmux command not found' 2>&1
    exit 1
fi
 
if [ -n "$TMUX" ]; then
#    echo "Error: tmux session has already been attached" 2>&1
    exit 1
fi

if tmux has-session >/dev/null 2>&1; then
    # detached session exists
    tmux attach && echo "tmux attached session "
    exit 0
fi

# var for session name (to avoid repeated occurences)
session_name=xyz
window_name=win

# Start the session and window 0
#   This will also be the default cwd for new windows created
#   via a binding unless overridden with default-path.
cd ~
tmux new-session -s "$session_name" -n $window_name -d

# Create a bunch of windows in your home directory 
# TODO
# create window failed: index in use: 1
cd ~
for i in {1..6}; do
    tmux new-window -t "$session_name:$i" -n "$window_name$i" >/dev/null 2>&1
    tmux split-window -h -t "$session_name:$i" -p 50
    tmux select-pane -R -t "$session_name:$i"
	#tmux send-keys -t "$session_name:$i" "man tmux" C-m
done

# Set the default cwd for new windows (optional, otherwise defaults to session cwd)
#tmux set-option default-path /

# Select window #1 and attach to the session
tmux select-window -t "$session_name:1"
tmux -2 attach-session -t "$session_name"
