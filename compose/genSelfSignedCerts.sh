#!/bin/sh

mkdir -p certs

(
cat <<'CONFIGFILECONTENTS'
[ req ]
prompt = no
default_bits = 2048
default_keyfile = kosher.key
encrypt_key = no
distinguished_name = req_distinguished_name

string_mask = utf8only

req_extensions = v3_req

[ req_distinguished_name ]
O=Some guy
L=Ithaca
ST=NY
C=US
CN=localhost

[ v3_req ]

basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
CONFIGFILECONTENTS
) >certs/config

openssl req -new -x509 -config certs/config -keyout certs/lh.key -out certs/lh.crt

openssl dhparam -out ./certs/dhparam.pem 2048
