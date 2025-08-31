# Docker Development Environment

A complete development environment with VS Code (code-server) running in Docker, deployable on Coolify with simple password authentication.

## Features

- 🖥️ **VS Code in Browser**: Full VS Code experience accessible from any device
- 🔐 **Password Authentication**: Simple password-based access
- 📱 **Mobile Friendly**: Works on phones and tablets
- 🧰 **Pre-installed Tools**: Node.js, Bun, TypeScript, Claude Code AI assistant, and essential dev tools
- 💾 **Persistent Storage**: Your workspace, extensions, and Git config persist across restarts
- 🚀 **One-Click Deploy**: Ready for Coolify deployment

## Quick Start on Coolify

1. **Fork/Clone this repo** to your GitHub account
2. **Create New Resource** in Coolify
3. **Select your repository** and choose "Dockerfile" build pack
4. **Set environment variables**:
   - `PASSWORD`: Your secure password for code-server access
5. **Deploy** and access via your assigned domain

## Local Development

```bash
# Clone the repository
git clone https://github.com/grmkris/agent.git
cd agent

# Copy environment file
cp .env.example .env

# Edit your password
nano .env

# Build and run the container
docker build -t dev-environment .
docker run -d -p 8080:8080 -e PASSWORD=your_password dev-environment

# Access code-server at http://localhost:8080
```

## Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `PASSWORD` | Code-server login password | `devpassword` |
| `TZ` | Timezone | `UTC` |

## What's Included

### Development Tools
- **Node.js 20** with npm
- **Bun** (latest) - Fast JavaScript runtime
- **TypeScript** with ts-node
- **Claude Code** - AI-powered coding assistant
- **System tools**: git, vim, nano, htop, tree, jq, ripgrep

### Storage
- Your code and extensions are stored in `/home/coder/` inside the container
- For persistence, mount volumes when running locally

## Usage

1. **Access Code-server**: Visit your domain and enter your password
2. **Open Terminal**: Use Ctrl+` or Terminal menu
3. **Set up Claude Code**: Run `claude` and authenticate with your preferred method
4. **Clone Repositories**: `git clone <your-repo-url>`
5. **Install Dependencies**: Use `npm install` or `bun install`
6. **Start Coding**: Use Claude Code AI assistance and code with confidence!

### Claude Code Authentication

After accessing your development environment, authenticate Claude Code:

```bash
# Start Claude Code
claude

# Follow the authentication prompts:
# - Anthropic Console (requires billing at console.anthropic.com)
# - Claude Pro/Max subscription
# - Enterprise platforms (AWS Bedrock, Google Vertex AI)
```

## Coolify Deployment Notes

- **No port exposure needed**: Coolify handles this automatically
- **Automatic SSL**: Coolify provides HTTPS certificates
- **Domain assignment**: You'll get a domain like `app-name.yourdomain.com`
- **Volume persistence**: Your data survives deployments and restarts

## Mobile Access Tips

- Use a strong password for security
- Enable "Desktop Site" mode on mobile browsers for better experience
- Consider using external keyboard for extended coding sessions
- Touch-friendly VS Code themes work better on mobile

## Troubleshooting

### Can't access code-server
- Check if the `PASSWORD` environment variable is set in Coolify
- Verify the container is running in Coolify's container logs

### Extensions not persisting
- Extensions are stored in the container filesystem
- For persistence, consider using Coolify's volume mounts

### Git authentication issues
- Use HTTPS with personal access tokens for simplicity
- SSH keys can be added directly in the code-server terminal

## Contributing

Feel free to submit issues and enhancement requests!