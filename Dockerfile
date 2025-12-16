# Build stage with Ubuntu to get OpenSSL
FROM ubuntu:24.04 AS builder

# Install OpenSSL
RUN apt-get update && apt-get install -y openssl && rm -rf /var/lib/apt/lists/*

# Final stage with UBI10-minimal
FROM registry.access.redhat.com/ubi10/ubi-minimal:latest

# Set Easy-RSA version
ENV EASYRSA_VERSION=3.1.7

# Copy OpenSSL from builder stage
COPY --from=builder /usr/bin/openssl /usr/bin/openssl
COPY --from=builder /usr/lib/x86_64-linux-gnu/libssl.so.* /usr/lib64/
COPY --from=builder /usr/lib/x86_64-linux-gnu/libcrypto.so.* /usr/lib64/

# Copy Easy-RSA files directly
COPY EasyRSA-${EASYRSA_VERSION}/ /usr/share/easy-rsa/

# Set working directory for EasyRSA operations
WORKDIR /pki

# Set the easyrsa binary as the entrypoint
ENTRYPOINT ["/usr/share/easy-rsa/easyrsa"]

# Default command shows help
CMD ["help"]
