domain=your.domain
email=your.email@mail.com
name=yourName
surname=yourFamilyName
sudo apt update
sudo apt install docker.io docker-compose -y
mkdir passbolt
wget https://raw.githubusercontent.com/bigwhoman/Password-Manager/main/docker-compose-ce.yaml -P passbolt
sed -i "s/https:\/\/passbolt.local/$domain/g" passbolt/docker-compose-ce.yaml
sed -i "s/passbolt.domain.tld/$domain/g" passbolt/docker-compose-ce.yaml
wget https://raw.githubusercontent.com/bigwhoman/Password-Manager/main/traefik.yaml -P passbolt
sed -i "s/yourname@domain.tld/$email/g" passbolt/traefik.yaml
mkdir passbolt/conf
wget https://raw.githubusercontent.com/bigwhoman/Password-Manager/main/conf/headers.yaml -P passbolt/conf
wget https://raw.githubusercontent.com/bigwhoman/Password-Manager/main/conf/tls.yaml -P passbolt/conf
docker-compose -f passbolt/docker-compose-ce.yaml up -d
docker-compose -f passbolt/docker-compose-ce.yaml exec passbolt su -m -c "/usr/share/php/passbolt/bin/cake \
                                passbolt register_user \
                                -u $email \
                                -f $name \
                                -l $surname \
                                -r admin" -s /bin/sh www-data
