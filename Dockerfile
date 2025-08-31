FROM node:20-slim

# Install minimal dependencies
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git \
    vim \
    nano \
    unzip \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install Bun for root
RUN curl -fsSL https://bun.sh/install | bash
ENV PATH="/root/.bun/bin:$PATH"

# Install only TypeScript globally
RUN npm install -g typescript

# Create user and directories
RUN useradd -m -s /bin/bash coder && \
    mkdir -p /home/coder/workspace && \
    chown -R coder:coder /home/coder

# Install Bun for coder user and set PATH
USER coder
WORKDIR /home/coder
RUN curl -fsSL https://bun.sh/install | bash
ENV PATH="/home/coder/.bun/bin:$PATH"

# Default command
CMD ["/bin/bash"]