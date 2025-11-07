FROM n8nio/n8n:latest

# Switch to root user to install packages
USER root

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      ffmpeg \
      imagemagick \
      jq \
      curl \
      wget \
      git \
      python3 \
      python3-pip \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Python packages if needed
RUN pip3 install --no-cache-dir --upgrade pip

# Switch back to n8n user
USER node

# Create necessary directories
RUN mkdir -p /home/node/.n8n /home/node/.tmp

# Expose n8n port
EXPOSE 5678

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD curl -f http://localhost:5678/healthz || exit 1
