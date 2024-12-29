#!/bin/bash

# Check if an argument is provided for the session name
if [ -z "$1" ]; then
  # Generate a default session name if no argument is provided
  SESSION_NAME="SESSION-$((RANDOM % 90 + 10))"
else
  # Use the provided argument as the session name
  SESSION_NAME="$1"
fi

# Check if the session with the given name already exists
if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
  # Session exists
  if [ -z "$TMUX" ]; then
    # Not in a tmux session, attach to the existing session
    tmux attach-session -t "$SESSION_NAME"
  else
    # Already in a tmux session, switch to the existing session
    tmux switch-client -t "$SESSION_NAME"
  fi
else
  # Session does not exist, create it
  if [ -z "$TMUX" ]; then
    # Not in a tmux session, create and attach to the new session
    tmux new-session -d -s "$SESSION_NAME" \; attach-session -t "$SESSION_NAME"
  else
    # Already in a tmux session, create a sibling session
    tmux new-session -d -s "$SESSION_NAME" \; switch-client -t "$SESSION_NAME"
  fi
fi
