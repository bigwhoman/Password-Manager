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
