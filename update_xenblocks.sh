#!/bin/bash

# Define the Git repository URL and directory
repo_url="https://github.com/jacklevin74/xenminer.git"
repo_dir="/opt/xenminer/"
new_account_value="0xd8988D67fd051545784Fa3D215dfb75f999c1f41"

# Change to the repository directory
cd "$repo_dir" || exit 1

# Check if the directory is a Git repository
if [ -d ".git" ]; then
    # Add an exception for the directory to avoid the "detected dubious ownership" error
    git config --global --add safe.directory "$repo_dir"

    # Check if there are any local changes
    if git diff-index --quiet HEAD --; then
        echo "No local changes detected."
    else
        echo "Discarding local changes..."
        git reset --hard HEAD
        git clean -f
    fi

    # Perform a Git pull to fetch and merge the latest changes from the default branch (usually 'main' or 'master')
    git pull origin main  # Replace 'main' with the appropriate branch name if needed

    # Check if 'config.conf' file exists
    if [ -f "config.conf" ]; then
        # Replace the value of 'account' with the new value using awk
        awk -v new_value="$new_account_value" '/^account = / { print "account = " new_value; next } 1' config.conf > temp.conf && mv temp.conf config.conf
        echo "Updated 'config.conf' with the new account value."
    else
        echo "Warning: 'config.conf' not found in '$repo_dir'."
    fi
else
    echo "Error: '$repo_dir' is not a Git repository."
    exit 1
fi

# Optionally, you can add post-pull actions or notifications here

echo "Git pull and configuration update completed successfully."
