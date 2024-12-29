#!/bin/bash

# Default window name
DEFAULT_WINDOW_NAME=""

# Check if a command-line argument is provided
if [ $# -eq 0 ]; then
  WINDOW_NAME=$DEFAULT_WINDOW_NAME
else
  WINDOW_NAME=$1
fi

SESSION_NAME="SESSION-$((RANDOM % 90 + 10))"

# Check if inside a tmux session
if [ -z "$TMUX" ]; then
  # Check if there are existing tmux sessions
  if tmux list-sessions >/dev/null 2>&1; then
    echo "Error: Not currently in a tmux session."
    exit 1
  else
    # No tmux sessions, create a new one
    if [ -z "$WINDOW_NAME" ]; then
      tmux new-session -d -s $SESSION_NAME
    else
      tmux new-session -d -s $SESSION_NAME -n "$WINDOW_NAME"
    fi
    tmux attach-session -t $SESSION_NAME
    exit 0
  fi
fi

# Create a new tmux window with the specified name (if provided) and switch to it
if [ -z "$WINDOW_NAME" ]; then
  tmux new-window
else
  tmux new-window -n "$WINDOW_NAME"
fi
tmux select-window -t "$WINDOW_NAME"
