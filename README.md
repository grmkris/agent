# Docker Development Environment

A complete development environment with VS Code (code-server) running in Docker, deployable on Coolify with simple password authentication.

## Features

- 🖥️ **VS Code in Browser**: Full VS Code experience accessible from any device
- 🔐 **Password Authentication**: Simple password-based access
- 📱 **Mobile Friendly**: Works on phones and tablets
- 🧰 **Pre-installed Tools**: Node.js, Bun, TypeScript, and essential dev tools
- 💾 **Persistent Storage**: Your workspace, extensions, and Git config persist across restarts
- 🚀 **One-Click Deploy**: Ready for Coolify deployment

## Quick Start on Coolify

1. **Fork/Clone this repo** to your GitHub account
2. **Create New Resource** in Coolify
3. **Select your repository** and choose "Docker Compose" build pack
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

# Start the development environment
docker-compose up -d

# Access code-server at http://localhost:8443
```

## Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `PASSWORD` | Code-server login password | `devpassword` |
| `SUDO_PASSWORD` | Sudo password inside code-server | `devpassword` |
| `TZ` | Timezone | `UTC` |

## What's Included

### Development Tools
- **Node.js 20** with npm
- **Bun** (latest) - Fast JavaScript runtime
- **TypeScript** with ts-node
- **Essential packages**: prettier, eslint, nodemon
- **System tools**: git, vim, nano, htop, tree, jq

### Persistent Volumes
- `workspace/`: Your code and repositories
- `extensions/`: VS Code extensions
- `gitconfig/`: Git configuration
- `ssh-keys/`: SSH keys for Git authentication

## Usage

1. **Access Code-server**: Visit your domain and enter your password
2. **Open Terminal**: Use Ctrl+` or Terminal menu
3. **Clone Repositories**: `git clone <your-repo-url>`
4. **Install Dependencies**: Use `npm install` or `bun install`
5. **Start Coding**: Everything persists across restarts!

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
- Check if the `PASSWORD` environment variable is set
- Verify the container is running: `docker-compose ps`

### Extensions not persisting
- Ensure the `extensions` volume is properly mounted
- Check Coolify volume configuration

### Git authentication issues
- Add your SSH keys to the `ssh-keys` volume
- Or use HTTPS with personal access tokens

## Contributing

Feel free to submit issues and enhancement requests!