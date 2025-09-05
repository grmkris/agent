FROM codercom/code-server:latest

# Switch to root to install packages
USER root

# Install Node.js, TypeScript, ripgrep, and comprehensive dev tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    # Basic utilities
    curl \
    wget \
    git \
    unzip \
    zip \
    p7zip-full \
    ca-certificates \
    sudo \
    # Development tools
    ripgrep \
    jq \
    lsof \
    htop \
    ncdu \
    tree \
    vim \
    nano \
    tmux \
    # Network tools
    net-tools \
    iputils-ping \
    dnsutils \
    telnet \
    nmap \
    # Build essentials
    build-essential \
    python3 \
    python3-pip \
    make \
    # Shell enhancements
    zsh \
    bat \
    fd-find \
    silversearcher-ag \
    fzf \
    # File operations
    rsync \
    less \
    && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g typescript @anthropic-ai/claude-code \
    && npm install -g @ast-grep/cli --force \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add coder user to sudo group for permission fixes
RUN usermod -aG sudo coder \
    && echo "coder ALL=(ALL) NOPASSWD: /bin/chown, /bin/mkdir, /bin/chmod" >> /etc/sudoers.d/coder \
    && echo "coder ALL=(ALL) NOPASSWD: /usr/bin/chown, /usr/bin/mkdir, /usr/bin/chmod" >> /etc/sudoers.d/coder

# Copy and set up entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Copy Claude context file for AI assistant
COPY CLAUDE.md /home/coder/CLAUDE.md
RUN chown coder:coder /home/coder/CLAUDE.md

# Install Bun for the coder user
USER coder
RUN curl -fsSL https://bun.sh/install | bash
ENV PATH="/home/coder/.bun/bin:$PATH"

# Set working directory
WORKDIR /home/coder

# Define persistent volumes
VOLUME ["/home/coder/workspace"]
VOLUME ["/home/coder/.config"]
VOLUME ["/home/coder/.local"]
VOLUME ["/home/coder/.cache"]

# Expose port 8080 for code-server and 3000 for dev server
EXPOSE 8080 3000

# Set entrypoint and default command
ENTRYPOINT ["/entrypoint.sh"]
CMD ["code-server", "--bind-addr", "0.0.0.0:8080", "--auth", "password"]