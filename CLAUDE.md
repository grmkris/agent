# Claude Development Environment Context

This is a containerized development environment based on **code-server** running on Linux. This context file provides essential information about the environment, tools, and best practices when working in this container.

## 🏗️ Environment Overview

- **Base**: code-server (VS Code in browser)
- **OS**: Ubuntu/Debian Linux
- **User**: `coder` (with sudo privileges)
- **Working Directory**: `/home/coder`
- **Exposed Ports**: 8080 (code-server), 3000 (dev server)

## 📦 Installed Tools & Languages

### Development Languages
- **Node.js 20.x** with npm
- **Bun** (fast JS runtime) - `/home/coder/.bun/bin/bun`
- **TypeScript** (global)
- **Python 3** with pip
- **Claude Code CLI** (global)
- **ast-grep** (sg) - AST-based code search and refactoring

### Essential CLI Tools
- **jq** - JSON processor (`cat file.json | jq '.'`)
- **ripgrep (rg)** - Super fast text search (`rg "pattern" --type js`)
- **ast-grep (sg)** - AST-based structural code search (`sg --pattern '$FUNC()' --lang js`)
- **fd** - Better find (`fd filename`)
- **bat** - Better cat with syntax highlighting
- **htop** - Interactive process viewer
- **lsof** - List open files (`lsof -i :3000`)
- **ncdu** - Disk usage analyzer
- **tree** - Directory tree view
- **tmux** - Terminal multiplexer
- **fzf** - Fuzzy finder

### Network & System Tools
- **net-tools** - netstat, ifconfig
- **iputils-ping** - ping
- **dnsutils** - nslookup, dig
- **nmap** - Network mapper
- **telnet** - Network testing

### Build Tools
- **build-essential** - gcc, make, etc.
- **git** version control
- **vim/nano** - Text editors
- **zip/unzip/p7zip** - Archive tools

## 🗂️ Directory Structure & Persistence

### Persistent Volumes (survive container restarts)
- **`/home/coder/workspace`** - 🎯 **PRIMARY WORK DIRECTORY** - Store all projects here
- **`/home/coder/.config`** - Configuration files (VS Code settings, etc.)
- **`/home/coder/.local`** - Local binaries and user-installed tools
- **`/home/coder/.cache`** - Cache files (npm, pip, etc.)

### Temporary (wiped on restart)
- `/tmp` - Temporary files
- System directories outside /home/coder

## 🔧 Standard Linux Environment

This environment uses standard Linux commands and tools without custom aliases. Claude agents are trained on these standard commands, making interaction more predictable and reliable.

## 🚀 Development Workflow Best Practices

### 1. Always Use Workspace
```bash
cd ~/workspace
# All your projects should go here for persistence
```

### 2. Common Development Commands
```bash
# Navigate to workspace
cd ~/workspace

# Start a dev server (typically on port 3000)
npm run dev
# or
bun dev

# Install dependencies
npm install  # or bun install

# Run tests
npm test    # or bun test

# Build project
npm run build  # or bun run build
```

### 3. Port Usage
- **8080** - Code-server (VS Code interface)
- **3000** - Typical dev server port (React, Next.js, etc.)
- Other ports as needed for your applications

## 🔧 Troubleshooting & Debugging

### Permission Issues
```bash
# Fix ownership of files/directories
sudo chown -R coder:coder /path/to/directory

# Create directories with proper permissions
mkdir -p ~/workspace/my-project
```

### Network Debugging
```bash
# Check what's running on ports
netstat -tulanp
lsof -i :3000

# Test connectivity
ping google.com
nmap localhost
telnet localhost 3000
```

### System Monitoring
```bash
# Interactive process monitoring
htop

# Disk usage analysis
ncdu ~/workspace
df -h

# Memory usage
free -h
```

### File Search & Content
```bash
# Fast file search
fd "package.json" ~/workspace

# Fast text-based content search
rg "import.*react" --type js

# AST-based structural code search
sg --pattern 'useState($_)' --lang tsx
sg --pattern 'function $NAME($$$)' --lang js

# Directory tree
tree ~/workspace -L 3
```

## 📝 Development Tips

### 1. Package Management
- **Node.js**: Use npm or bun (bun is faster)
- **Python**: pip3 is available
- **Global tools**: Install with `npm install -g` or `bun add -g`

### 2. Editor Integration
- Code-server runs VS Code with extensions support
- Terminal is integrated (Ctrl+` to toggle)
- Use integrated terminal for commands

### 3. Git Configuration
Default git config is set up, but customize with:
```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@domain.com"
```

### 4. Environment Variables
Create `.env` files in your project directories:
```bash
# ~/workspace/my-project/.env
NODE_ENV=development
API_URL=http://localhost:8000
```

## 🔍 Quick Reference Commands

| Task | Command | Notes |
|------|---------|-------|
| Find files | `fd filename` | Better than find |
| Search text | `rg "pattern"` | Fast text search |
| Search code structure | `sg --pattern '$FUNC()'` | AST-based code search |
| JSON processing | `cat file.json \| jq` | Pretty print, query |
| Process monitoring | `htop` | Interactive |
| Port checking | `lsof -i :PORT` | See what's using a port |
| Directory size | `ncdu PATH` | Interactive disk usage |
| File content | `bat file.txt` | Syntax highlighted cat |
| Network info | `curl -s ifconfig.me` | External IP |
| Open ports | `netstat -tulanp` | Show listening ports |

## 💡 Pro Tips

1. **Use the persistent workspace**: Everything in `~/workspace` survives restarts
2. **Use standard commands**: No custom aliases - use `ls -la`, `git status`, etc.
3. **Terminal multiplexing**: Use `tmux` for multiple sessions
4. **Quick JSON**: `curl api-endpoint | jq` for API testing
5. **Fast text search**: `rg pattern --type js` for content searches
6. **Structural code search**: `sg --pattern '$FUNC()' --lang js` for AST-based searches
7. **Directory navigation**: Use `tree` to understand project structure

---

**Happy coding! This environment is optimized for full-stack development with persistent storage and comprehensive tooling.** 🎉