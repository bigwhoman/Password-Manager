# Password-Manager
A script that sets up yout own password manager on linux server
Run the command below to create your password manager.<br>
It has two options, if your domain is on cloudflare and if not. My personal preference is the one with cloudflare.
# Domain not on cloudflare
```shell
wget https://raw.githubusercontent.com/bigwhoman/Password-Manager/main/install.sh
chmod +x install.sh
sudo bash install.sh
```
You should give your <b> hosting domain, email, name and surname </b>.<br>
This script only works if you have a hosting domain so if you do not have one or you are not sure, use the command below to find it
```shell
hostnamectl | grep 'hostname'
```
# Domain on cloudflare
<b>you have to add your domain to cloudflare before the steps below</b><br>
First, we need to create a <b>cloudflare certificate</b> for our domain, to do this go to : <br>
cloudflare dashboard --> ssl-tls --> client-certificates --> Create Certificate <br>
![image](https://user-images.githubusercontent.com/79264715/233497050-c85bd3a2-f042-4cc8-953f-b977d97e84f5.png)
<br>
Then we need to get a cloudflare API_KEY from cloudflare dashboard : <l>https://dash.cloudflare.com/profile/api-tokens</l>.
<br>
Now run the script below
```shell
wget https://raw.githubusercontent.com/bigwhoman/Password-Manager/main/install_cf.sh
chmod +x install_cf.sh
sudo bash install_cf.sh
```
In the next steps you are asked some questions, answer them.<br>
After the complete installation ( lookout for the ports and check if docker ps is right) you would get 
a completion like this : 
```bash
    ____                  __          ____  
    / __ \____  _____ ____/ /_  ____  / / /_ 
   / /_/ / __ `/ ___/ ___/ __ \/ __ \/ / __/ 
  / ____/ /_/ (__  |__  ) /_/ / /_/ / / /    
 /_/    \__,_/____/____/_.___/\____/_/\__/   

 Open source password manager for teams
-------------------------------------------------------------------------------
https://my.domain.tld/setup/install/1eafab88-a17d-4ad8-97af-77a97f5ff552/f097be64-3703-41e2-8ea2-d59cbe1c15bc
```
Just copy the url into your browser and you are good to go.
![image](https://user-images.githubusercontent.com/79264715/233514232-e7333f0c-20b2-4ad5-892a-8a2d34d9a5bc.png)

<b>Note</b>
If you get a database error, just wait and after a while, enter the command below 
```shell
$ docker-compose -f passbolt/docker-compose-ce.yaml exec passbolt su -m -c "/usr/share/php/passbolt/bin/cake \
                                passbolt register_user \
                                -u <your@email.com> \
                                -f <yourname> \
                                -l <surname> \
                                -r admin" -s /bin/sh www-data
```
If you want to remove the whole thing with dockers and volumes : 
```shell
docker-compose -f passbolt/docker-compose-cf.yaml down -v
rm -f -r passbolt
```
Remember to open your port !!!!!
