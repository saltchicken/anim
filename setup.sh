#!/bin/bash

CONFIG_FILE="config.txt"
if [[ ! -f $CONFIG_FILE ]]; then
  echo "Config file not found!"
  exit 1
fi

# Read the USER and HOST from the config file
REMOTE_USER=$(grep "^REMOTE_USER=" $CONFIG_FILE | cut -d'=' -f2)
HOST=$(grep "^HOST=" $CONFIG_FILE | cut -d'=' -f2)

# Ensure both USER and HOST are set
if [[ -z "$REMOTE_USER" || -z "$HOST" ]]; then
  echo "REMOTE_USER or HOST is not set in the config file."
  exit 1
fi

# echo "Using REMOTE_USER: $REMOTE_USER and HOST: $HOST"
# if [[ $# -lt 1 ]]; then
#   echo "Usage: $0 {tunnel|command} [args...]"
#   exit 1
# fi
PORT="$1"
VIDEO_FILE="$2"
# Name of the tmux session
SESSION_NAME="tunnel_player_${PORT}"
# Commands to run in the windows
COMMAND1="ssh -L '${PORT}:localhost:${PORT}' '${REMOTE_USER}@${HOST}'"
echo $COMMAND1

# ffmpeg -framerate 15 -i "$OUTPUT_FOLDER/frame_%04d.png" -c:v ffv1 -pix_fmt yuva420p -f matroska ${OUTPUT_FILE}
COMMAND2="ssh ${USER}@${HOST} 'ffmpeg -re -i '${VIDEO_FILE}' -c:v ffv1 -pix_fmt yuva420p -f matroska -listen 1 http://localhost:${PORT}/live.stream'"
echo $COMMAND2
COMMAND3="mpv http://localhost:${PORT}/live.stream --force-seekable=yes --loop"
echo $COMMAND3

# Environment variables for each window
# VAR1="value1"
# VAR2="value2"

# Create a new tmux session and run the first command in window 1
tmux new-session -d -s $SESSION_NAME

# Set environment variable for the first window
tmux set-environment -t $SESSION_NAME VAR1 "$VAR1"

tmux send-keys -t $SESSION_NAME:1.1 "$COMMAND1" C-m

# Create a second window
tmux split-window -h -t $SESSION_NAME

# Set environment variable for the second window
# tmux set-environment -t $SESSION_NAME VAR2 "$VAR2"

tmux send-keys -t $SESSION_NAME:1.2 "$COMMAND2" C-m

tmux split-window -v -t $SESSION_NAME
tmux send-keys -t $SESSION_NAME:1.3 "$COMMAND3" C-m
# Attach to the session (optional)
tmux attach-session -t $SESSION_NAME
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
