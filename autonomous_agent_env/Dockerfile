FROM node:22-bullseye

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    jq \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Install firecrawl-cli globally
RUN npm install -g firecrawl-cli

# Create a non-root user 'agent'
RUN useradd -m -s /bin/bash agent && \
    echo "agent ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Switch to non-root user
USER agent
WORKDIR /home/agent

# Copy setup scripts
COPY --chown=agent:agent scripts /home/agent/scripts
RUN chmod +x /home/agent/scripts/*.sh

# Ensure .config directory exists for persistence
RUN mkdir -p /home/agent/.config/opencode && \
    mkdir -p /workspace

# Set default working directory
WORKDIR /workspace

# Keep container running
CMD ["tail", "-f", "/dev/null"]
