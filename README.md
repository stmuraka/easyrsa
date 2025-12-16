# easyrsa
Docker image to generate a certificate and key pair using Easy-RSA

## Usage

### Building the Docker Image

```bash
docker build -t easyrsa .
```

### Basic Commands

#### Show Help
```bash
docker run --rm easyrsa
```

#### Initialize PKI (Public Key Infrastructure)
```bash
docker run --rm -v $(pwd)/pki:/pki easyrsa init-pki
```

#### Create a Certificate Authority (CA)
```bash
docker run --rm -v $(pwd)/pki:/pki easyrsa --batch build-ca nopass
```

#### Generate a Server Certificate and Key
```bash
docker run --rm -v $(pwd)/pki:/pki easyrsa --batch build-server-full server nopass
```

#### Generate a Client Certificate and Key
```bash
docker run --rm -v $(pwd)/pki:/pki easyrsa --batch build-client-full client nopass
```

### Complete Workflow Example

```bash
# Create a directory for PKI data
mkdir -p ./pki

# Initialize PKI
docker run --rm -v $(pwd)/pki:/pki easyrsa init-pki

# Build Certificate Authority
docker run --rm -v $(pwd)/pki:/pki easyrsa --batch build-ca nopass

# Generate server certificate and key
docker run --rm -v $(pwd)/pki:/pki easyrsa --batch build-server-full myserver nopass

# Generated files will be in:
# - Certificate: ./pki/pki/issued/myserver.crt
# - Private Key: ./pki/pki/private/myserver.key
# - CA Certificate: ./pki/pki/ca.crt
```

## About Easy-RSA

Easy-RSA is a CLI utility to build and manage a PKI CA. It is used to:
- Create a root certificate authority
- Generate certificate requests and private keys
- Sign certificate requests to create certificates
- Revoke certificates and generate CRLs (Certificate Revocation Lists)

This Docker image packages Easy-RSA 3.1.7 for convenient use without local installation.
