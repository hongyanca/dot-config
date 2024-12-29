#!/bin/bash

# ANSI color codes
GREEN="\033[32m"
YELLOW="\033[33m"
RESET="\033[0m"

# Check if running inside a tmux session
if [ -n "$TMUX" ]; then
  tmux choose-tree
  exit 0
fi

# List all tmux sessions and store them in an array
sessions=($(tmux list-sessions -F "#S" 2>/dev/null))

# Check if there are no tmux sessions
if [ ${#sessions[@]} -eq 0 ]; then
  echo "No tmux sessions found. Creating a new session named 'shell'."
  tmux new-session -d -s shell
  tmux attach-session -t shell
  exit 0
fi

# If there is only one session, attach to it
if [ ${#sessions[@]} -eq 1 ]; then
  echo "Only one session found: ${sessions[0]}. Attaching to it."
  tmux attach-session -t "${sessions[0]}"
  exit 0
fi

# Display sessions with colored formatting
echo "Available tmux sessions:"
for i in "${!sessions[@]}"; do
  num=$((i + 1))
  echo -e "${GREEN}${num}${RESET} - ${YELLOW}${sessions[$i]}${RESET}"
done

# Prompt user for input with timeout
read -t 3 -p "Select session number: " choice

# Validate input
if [[ $choice =~ ^[0-9]+$ ]] && [ "$choice" -gt 0 ] && [ "$choice" -le "${#sessions[@]}" ]; then
  session_name="${sessions[$((choice - 1))]}"
  echo "Attaching to session: $session_name"
  tmux attach-session -t "$session_name"
else
  # Fallback to default session
  echo "No input or invalid input. Attaching to default session."
  tmux attach-session
fi
