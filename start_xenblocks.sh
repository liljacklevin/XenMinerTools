#!/bin/bash

# Default behavior: Use the number of CPU cores
num_cores=$(sysctl -n hw.ncpu)

if [ $# -eq 1 ]; then
    num_windows=$1
else
    num_windows=$num_cores
fi

session_name="miner_session"
config_file="/opt/xenminer/config.conf"

# Configuration to check - make sure you are not mining on the defauly address
config_to_check="0x0A6969ffF003B760c97005e03ff5a9741126167A"

# Function to check if a string exists in a file
string_in_file() {
    local string="$1"
    local file="$2"
    grep -q "$string" "$file"
}

# Check if the session already exists
if tmux has-session -t $session_name 2>/dev/null; then
    echo "Session '$session_name' already exists. Attaching to it."
    tmux attach-session -t $session_name
else
    # Check if the config file exists and the config is present in it
    if [ -f "$config_file" ] && string_in_file "$config_to_check" "$config_file"; then
        echo "Configuration '$config_to_check' found in '$config_file'. Aborting."
        exit 1
    fi

    # Create a new session with one window
    cd /opt/xenminer
    tmux new-session -d -s $session_name -n "Window 1" "python3 /opt/xenminer/miner.py"

    for ((i=2; i<=$num_windows; i++)); do
        # Split the current window into a new horizontal pane and run the command
        tmux split-window -h "python3 /opt/xenminer/miner.py"
        tmux select-layout tiled
    done

    echo "Session '$session_name' created with $num_windows windows. Attaching to it."
    tmux attach-session -t $session_name
fi
