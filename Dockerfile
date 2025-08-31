FROM codercom/code-server:latest

# Switch to root to install packages
USER root

# Install Node.js, TypeScript, ripgrep, and essential tools
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    unzip \
    ca-certificates \
    sudo \
    ripgrep \
    && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g typescript @anthropic-ai/claude-code \
    && rm -rf /var/lib/apt/lists/*

# Add coder user to sudo group for permission fixes
RUN usermod -aG sudo coder \
    && echo "coder ALL=(ALL) NOPASSWD: /bin/chown" >> /etc/sudoers.d/coder

# Copy and set up entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Install Bun for the coder user
USER coder
RUN curl -fsSL https://bun.sh/install | bash
ENV PATH="/home/coder/.bun/bin:$PATH"

# Set working directory
WORKDIR /home/coder

# Expose port 8080 for code-server and 3000 for dev server
EXPOSE 8080 3000

# Set entrypoint and default command
ENTRYPOINT ["/entrypoint.sh"]
CMD ["code-server", "--bind-addr", "0.0.0.0:8080", "--auth", "password"]