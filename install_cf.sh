#!/bin/bash

sudo apt update
sudo apt install docker.io docker-compose -y
mkdir passbolt

# Prompt user for input
read -p "Enter domain name: " domain
while [[ -z "$domain" ]]; do
  read -p "Domain name cannot be empty. Please enter domain name: " domain
done

read -p "Enter Cloudflare email: " email
while [[ -z "$email" ]]; do
  read -p "Cloudflare email cannot be empty. Please enter Cloudflare email: " email
done

read -sp "Enter Cloudflare API key: " api_key
while [[ -z "$api_key" ]]; do
  echo ""
  read -sp "Cloudflare API key cannot be empty. Please enter Cloudflare API key: " api_key
done

read -p "Enter port (default: 8443): " port
if [[ -z "$port" ]]; then
  port=8443
fi

read -p "Enter name (default: anon): " name
if [[ -z "$name" ]]; then
  name="anon"
fi

read -p "Enter surname (default: anon): " surname
if [[ -z "$surname" ]]; then
  surname="anon"
fi
wget https://raw.githubusercontent.com/bigwhoman/Password-Manager/main/.env -P passbolt
# Update .env file
cat > .env <<- EOM
DOMAINNAME_CLOUD_SERVER=$domain
CLOUDFLARE_EMAIL=$email
CLOUDFLARE_API_KEY=$api_key
PORT=$port
EOM
docker network create traefik-proxy
echo "Updated .env file with user inputs."
wget https://raw.githubusercontent.com/bigwhoman/Password-Manager/main/docker-compose-cf.yaml -P passbolt
mkdir passbolt/conf
wget https://raw.githubusercontent.com/bigwhoman/Password-Manager/main/conf/headers.yaml -P passbolt/conf
wget https://raw.githubusercontent.com/bigwhoman/Password-Manager/main/conf/tls.yaml -P passbolt/conf
docker-compose -f passbolt/docker-compose-cf.yaml up -d
sleep 5
docker-compose -f passbolt/docker-compose-cf.yaml exec passbolt su -m -c "/usr/share/php/passbolt/bin/cake \
                                passbolt register_user \
                                -u $email \
                                -f $name \
                                -l $surname \
                                -r admin" -s /bin/sh www-data
