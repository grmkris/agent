#!/bin/bash
set -e

# Create and fix ownership of persistent volume directories
echo "Setting up persistent directories..."

# Ensure all volume directories exist and have correct permissions
for dir in "/home/coder/workspace" "/home/coder/.config" "/home/coder/.local" "/home/coder/.cache"; do
    if [ ! -d "$dir" ]; then
        echo "Creating directory: $dir"
        sudo mkdir -p "$dir"
    fi
    echo "Setting ownership for: $dir"
    sudo chown -R coder:coder "$dir"
done

# Ensure the coder user owns their home directory
echo "Setting ownership for /home/coder"
sudo chown -R coder:coder /home/coder

# Initialize workspace directory with a welcome message if it's empty
if [ -d "/home/coder/workspace" ] && [ -z "$(ls -A /home/coder/workspace)" ]; then
    echo "Initializing workspace..."
    cat > /home/coder/workspace/README.md << 'EOF'
# Welcome to Your Development Environment

This workspace is persistent across container restarts!

## Available Tools
- **jq** - JSON processor
- **lsof** - List open files
- **htop** - Interactive process viewer
- **ncdu** - Disk usage analyzer
- **tree** - Directory tree viewer
- **tmux** - Terminal multiplexer
- **bat** - Better cat with syntax highlighting
- **fd** - Better find
- **ripgrep (rg)** - Fast text search
- **ast-grep (sg)** - AST-based code search
- **fzf** - Fuzzy finder

## Standard Linux Commands
This environment uses standard Linux commands without custom aliases.
Use commands like `ls -la`, `git status`, `netstat -tulanp`, etc.

## Persistent Directories
- `/home/coder/workspace` - Your projects (this directory)
- `/home/coder/.config` - Configuration files
- `/home/coder/.local` - Local binaries and data
- `/home/coder/.cache` - Cache files

Happy coding! 🚀
EOF
    sudo chown coder:coder /home/coder/workspace/README.md
fi

# Start code-server as the coder user
exec "$@"