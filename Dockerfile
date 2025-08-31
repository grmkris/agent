FROM codercom/code-server:latest

# Switch to root to install packages
USER root

# Install Node.js, TypeScript, and essential tools
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    unzip \
    ca-certificates \
    && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g typescript \
    && rm -rf /var/lib/apt/lists/*

# Install Bun for the coder user
USER coder
RUN curl -fsSL https://bun.sh/install | bash
ENV PATH="/home/coder/.bun/bin:$PATH"

# Set working directory
WORKDIR /home/coder