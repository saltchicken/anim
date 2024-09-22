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

echo "Using REMOTE_USER: $REMOTE_USER and HOST: $HOST"
if [[ $# -lt 1 ]]; then
  echo "Usage: $0 {tunnel|command} [args...]"
  exit 1
fi

PORT="$2"
# COMMAND="$2"

ACTION=$1

case $ACTION in
tunnel)
  echo "Creating SSH tunnel: Local port $PORT -> $HOST:$PORT"
  # Open SSH tunnel in the background
  # ssh -L "${PORT}:localhost:${PORT}" "${REMOTE_USER}@${HOST}" -N &
  ssh -L "${PORT}:localhost:${PORT}" "${REMOTE_USER}@${HOST}"
  ;;
stream)
  VIDEO_FILE="$3"
  ssh ${USER}@${HOST} "ffmpeg -re -i "${VIDEO_FILE}" -f mpegts -listen 1 http://localhost:${PORT}/live.stream"
  ;;
play)
  mpv http://localhost:${PORT}/live.stream --force-seekable=yes --loop
  ;;
command)
  if [[ $# -lt 1 ]]; then
    echo "Please provide a command to send over SSH."
    exit 1
  fi
  SSH_COMMAND="$2"
  echo "Executing command: $SSH_COMMAND on $HOST"
  ssh ${USER}@${HOST} "${SSH_COMMAND}"
  ;;
*)
  echo "Invalid option. Use 'tunnel' or 'command'."
  exit 1
  ;;
esac
# TODO: This needs a way to kil the created tunnel

# Capture the tunnel's PID
# TUNNEL_PID=$!
# # Wait for a few seconds to ensure the tunnel is established
# sleep 10
#
# # Execute the command on the remote server
# # ssh "${REMOTE_USER}@${REMOTE_HOST}" "$COMMAND"
#
# # sleep 2
# # Kill the tunnel when done
# # kill "$TUNNEL_PID"
# echo $TUNNEL_PID
