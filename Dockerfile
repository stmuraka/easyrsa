# Use Ubuntu as base image
FROM ubuntu:24.04

# Install easy-rsa package and clean up apt cache
RUN apt-get update && \
    apt-get install -y easy-rsa && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set working directory for EasyRSA operations
WORKDIR /pki

# Set the easyrsa binary as the entrypoint
ENTRYPOINT ["/usr/share/easy-rsa/easyrsa"]

# Default command shows help
CMD ["help"]
