# Init-Docker
Projets d'initiation a l'administration systeme et reseau

## roger-skyline-1
[Sujet](https://cdn.intra.42.fr/pdf/pdf/1510/roger-skyline-1.5.fr.pdf)  
`mkdir -p /sgoinfre/goinfre/Perso/<my_username>`  
`chmod 600 /sgoinfre/goinfre/Perso/<my_username>`  
`mkdir -p /sgoinfre/goinfre/Perso/<my_username>/VirtualBox\ VMs`  
`ln -s /sgoinfre/goinfre/Perso/<my_username> /Users/<my_username>/STOCKAGE`  

VirtualBox -\> Preferences... -\> General -\> Default Machine Folder :  
	/Users/<my_username>/STOCKAGE/VirtualBox\ VMs  

Creer le disque dur :  
`mkdir -p /sgoinfre/goinfre/Perso/<my_username>/VB_HardDrive`  
`VBoxManage createmedium disk --filename /sgoinfre/goinfre/Perso/<my_username>/VB_HardDrive/Roger_Skyline.vdi --sizebyte 8000000000 --format VDI --variant Fixed`  

New -\> \[...\] -\> /sgoinfre/goinfre/ISO/Debian/debian-9.6.0-amd64-netinst.iso  


 \- Init\_and\_Docker/download\_debian\_image\_openclassrooms.sh \-  
`curl -o /Users/<my_username>/STOCKAGE/VirtualBox\ VMs/Debian8.5.vdi http://www.lalitte.com/Debian8.5.vdi`  

 \- Init\_and\_Docker/projet\_Init/notes\_perso.txt \-  

Renommer le systeme de maniere permanente : `vim /etc/hostname`  

`apt-get update && apt-get -y install sudo`  

1. _Vous devez creer un utilisateur non root pour vous connecter et travailler_  
[Reference - Reprenez le controle a l'aide de Linux](https://openclassrooms.com/fr/courses/43538-reprenez-le-controle-a-laide-de-linux/39044-les-utilisateurs-et-les-droits)  
`adduser <user_login>`  
password: 'roger'  

2. _Utilisez sudo pour pouvoir, depuis cet utilisateur, effectuer les operations demamdant des droits speciaux_  
`adduser <user_login> sudo`  

(logout -\> login with new user account)  

3. _Nous ne voulons pas que vous utilisiez le service DHCP de votre machine. A vous donc de la configurer afin qu'elle ait une IP fixe et un Netmask en /30_  

[Reference - Apprenez le fonctionnement des reseaux TCP/IP](https://openclassrooms.com/fr/courses/857447-apprenez-le-fonctionnement-des-reseaux-tcp-ip/853668-decoupage-dune-plage-dadresses)  

`/sbin/ifconfig`  
eth0  
	inet add:10.0.2.15  

(Ajouter '/sbin' a la variable d'environnement 'PATH' : `sudo vim /etc/profile`)  
[Variables d'environnement persistantes](https://doc.ubuntu-fr.org/variables_d_environnement#variables_d_environnement_persistantes)  
`sudo apt-get update && sudo apt-get -y install vim`  

[Configurer une interface reseau manuellement](https://wiki.debian.org/fr/NetworkConfiguration)  

[RFC 1918](https://openclassrooms.com/fr/courses/857447-apprenez-le-fonctionnement-des-reseaux-tcp-ip/853441-la-couche-3#/id/r-2152680)  

`sudo vim /etc/network/interfaces`  

\# Sur le Mac  
\# `netstat -nr`  
\# default Gateway 10.11.254.254  
\# 00001010.00001011.11111110.11111110  
\# Dans la VM Debian  
\# 00001010.00001011.11111110.11111101 -\>  10.11.254.253/30  

```
auto eth0
iface eth0 inet static
	address 10.11.254.253/30
	gateway 10.11.254.254
```

`sudo init 0`  

VirtualBox -\> Settings -\> Network -\> Attached to :  
	Bridged Adapter  

4. _Vous devez changer le port par defaut du service SSH par celui de votre choix. L'acces SSH DOIT se faire avec des publickeys. L'utilisateur root ne doit pas pouvoir se connecter en SSH_  

[Reference - Reprenez le controle a l'aide de Linux](https://openclassrooms.com/fr/courses/43538-reprenez-le-controle-a-laide-de-linux/41773-la-connexion-securisee-a-distance-avec-ssh#/id/r-2282884)  

Dans la VM :  

`sudo apt-get update && sudo apt-get -y install openssh-server`  
`sudo vim /etc/ssh/sshd_config`  

Port 2222  
PermitRootLogin no  
PasswordAuthentification yes # (Dans un premier temps)  

`sudo service ssh reload`  

Sur le Mac :  

`ssh-keygen -t rsa`  
`ssh-copy-id -p 2222 -i /Users/<my_username>/.ssh/id_rsa.pub <user_login>@10.11.254.253`  

Dans la VM :  
`sudo vim /etc/ssh/sshd_config`  

PasswordAuthentification no # (dans un second temps)  
`sudo service ssh reload`  

Sur le Mac :  
`ssh -p 2222 lcabanes@10.11.254.253`  


5. _Vous devez mettre en place des regles de pare-feu (firewall) sur le serveur avec uniquement les services utilises accessibles en dehors de votre VM_  

[Reference - Reprenez le controle a l'aide de Linux](https://openclassrooms.com/fr/courses/43538-reprenez-le-controle-a-laide-de-linux/42264-analyser-le-reseau-et-filtrer-le-trafic-avec-un-pare-feu#/id/r-42263)  

Dans un script dans le dossier '/root'  
```
iptables -A INPUT -p tcp --dport 2222 -j ACCEPT
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -P INPUT DROP
```

Appeler le script depuis la CronTab  
Verifier les regles en vigueur : `sudo iptables -L -v`  

`sudo apt-get update && sudo apt-get -y install ufw`  
`ufw reset`  
`ufw default deny incoming`  
`ufw default deny outgoing`  
`ufw allow 2222/tcp`  
`ufw allow in http`  
`ufw allow out http`  
`ufw allow in https`  
`ufw allow out https`  
`ufw allow in 53`  
`ufw allow out 53`  
`ufw logging on`  
`ufw enable`  

6. _Vous devez mettre en place une protection contre les DOS (Denial Of Service Attack) sur les ports ouverts de votre VM_  

fail2ban  
`sudo vim /etc/fail2ban/jail.d/defaults-debian.conf`  
`sudo vim /etc/fail2ban/jail.d/custom.conf`  

\[DEFAULT\]  
findtime = 300  
bantime = 1800  
maxretry = 3  

\[sshd\]  
enabled = true  
port = 2222  

`sudo vim /etc/fail2ban/filter.d/sshd.conf`  
	^%(prefix_line)sConnection closed by <HOST> port \d+ \[preauth\]$  

7. _Vous devez mettre en place une protection contre les scans sur les ports ouverts de votre VM_  

[Debian Wiki](https://wiki.debian-fr.xyz/Portsentry)  

portsentry  
`sudo vim /etc/default/portsentry`  

TCP\_MODE="atcp"  
UDP\_MODE="audp"  

`sudo vim /etc/portsentry/portsentry.conf`  

BLOCK\_UDP="1"  
BLOCK\_TCP="1"  

KILL\_RUN\_CMD="/sbin/iptables -I INPUT -s $TARGET$ -j DROP \  
	&& /sbin/iptables -I INPUT -s $TARGET$ -m limit --limit 3/minute --limit-burst 5 -j LOG --log-level debug --log-prefix 'Portsentry: dropping: '"  


`nmap -sS -sU 10.11.254.253`  

8. _Arretez les services dont vous n'avez pas besoin pour ce projet_  

`sudo service --status-all`  


9. [Init\_and\_Docker/projet\_Init/scripts/02](https://github.com/HippopoStar/Init_and_Docker/blob/master/projet_Init/scripts/02)  

Egalement au reboot  
[Reference - Reprenez le controle a l'aide de Linux](https://openclassrooms.com/fr/courses/43538-reprenez-le-controle-a-laide-de-linux/41155-executer-un-programme-a-une-heure-differee#/id/r-41154)  

10. [Init\_and\_Docker/projet\_Init/scripts/04](https://github.com/HippopoStar/Init_and_Docker/blob/master/projet_Init/scripts/04)  

