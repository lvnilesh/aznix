# Create a directory for certificates if you haven't already
sudo rm -rf ~/mongo-tls
mkdir -p ~/mongo-tls
cd ~/mongo-tls

# Create a configuration file for OpenSSL
cat > mongodb.cnf << EOL
[req]
default_bits = 4096
prompt = no
default_md = sha256
distinguished_name = dn
req_extensions = req_ext

[dn]
C=US
ST=WA
L=Sammamish
O=CloudGenius
OU=IT
CN=localhost

[req_ext]
subjectAltName = @alt_names

[alt_names]
DNS.1 = localhost
DNS.2 = aznix.tail52f7b.ts.net
DNS.3 = aznix.westus.cloudapp.azure.com
IP.1 = 127.0.0.1
EOL


# Generate a CA private key
openssl genrsa -out ca.key 4096

# Generate a CA certificate
openssl req -new -x509 -days 3650 -key ca.key -out ca.pem -subj "/C=US/ST=WA/L=Sammamish/O=CloudGenius/OU=IT/CN=MongoDB CA"

# Generate server key
openssl genrsa -out mongodb-cert.key 4096

# Generate a certificate signing request using the config file
openssl req -new -key mongodb-cert.key -out mongodb-cert.csr -config mongodb.cnf

# Sign the certificate with your CA
openssl x509 -req -days 365 -in mongodb-cert.csr -CA ca.pem -CAkey ca.key -CAcreateserial -out mongodb-cert.crt -extensions req_ext -extfile mongodb.cnf

# Create the PEM file
cat mongodb-cert.key mongodb-cert.crt > mongodb.pem 
