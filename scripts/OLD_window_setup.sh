#!/bin/bash

# Name of the tmux session
SESSION_NAME="video_test"
# Commands to run in the windows
COMMAND1="ls"
COMMAND2="ls"

# Environment variables for each window
VAR1="value1"
VAR2="value2"

# Create a new tmux session and run the first command in window 1
tmux new-session -d -s $SESSION_NAME

# Set environment variable for the first window
tmux set-environment -t $SESSION_NAME VAR1 "$VAR1"

# Send the command to window 1 with the environment variable
tmux send-keys -t $SESSION_NAME:1 "$COMMAND1" C-m

# Create a second window
tmux new-window -t $SESSION_NAME

# Set environment variable for the second window
tmux set-environment -t $SESSION_NAME VAR2 "$VAR2"

# Send the command to window 2 with the environment variable
tmux send-keys -t $SESSION_NAME:2 "$COMMAND2" C-m

# Attach to the session (optional)
tmux attach-session -t $SESSION_NAME
