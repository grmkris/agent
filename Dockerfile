FROM node:20-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    vim \
    nano \
    htop \
    tree \
    jq \
    build-essential \
    python3 \
    python3-pip \
    ca-certificates \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

# Install Bun
RUN curl -fsSL https://bun.sh/install | bash
ENV PATH="/root/.bun/bin:$PATH"

# Install global packages for both Node.js and Bun
RUN npm install -g \
    typescript \
    ts-node \
    @types/node \
    nodemon \
    prettier \
    eslint \
    @typescript-eslint/parser \
    @typescript-eslint/eslint-plugin

# Install Bun global packages
RUN bun install -g typescript

# Set working directory
WORKDIR /workspace

# Create directories for development
RUN mkdir -p /workspace && \
    chmod 755 /workspace

# Default command (this will be overridden by code-server)
CMD ["/bin/bash"]