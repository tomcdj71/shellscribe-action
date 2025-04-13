FROM ubuntu:24.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    ca-certificates \
    build-essential \
    cmake \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set up the working directory
WORKDIR /app

# Fetch the latest release of Shellscribe
RUN RELEASE_URL=$(curl -s https://api.github.com/repos/tomcdj71/shellscribe/releases/latest | \
    grep -oP '"browser_download_url": "\K[^"]+\.deb') \
    && wget "$RELEASE_URL" -O shellscribe.deb \
    && apt-get update \
    && dpkg -i shellscribe.deb \
    && apt-get install -f -y \
    && rm shellscribe.deb \
    && rm -rf /var/lib/apt/lists/*

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Set entrypoint
ENTRYPOINT ["/entrypoint.sh"] 
