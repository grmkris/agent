#!/bin/bash
set -e

# Fix ownership of workspace directory if it exists
if [ -d "/home/coder/workspace" ]; then
    echo "Fixing ownership of /home/coder/workspace"
    sudo chown -R coder:coder /home/coder/workspace
fi

# Ensure the coder user owns their home directory
sudo chown -R coder:coder /home/coder

# Start code-server as the coder user
exec "$@"