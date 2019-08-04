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

 \- Init\_and\_Docker/download\_debian\_image\_openclassrooms.sh \-  
`curl -o /Users/<my_username>/STOCKAGE/VirtualBox\ VMs/Debian8.5.vdi http://www.lalitte.com/Debian8.5.vdi`  

 \- Init\_and\_Docker/projet\_Init/notes\_perso.txt \-  

Renommer le systeme de maniere permanente : `vim /etc/hostname`  

`apt-get update && apt-get -y install sudo`  

1. Vous devez creer un utilisateur non root pour vous connecter et travailler  
[Reference - Reprenez le controle a l'aide de Linux](https://openclassrooms.com/fr/courses/43538-reprenez-le-controle-a-laide-de-linux/39044-les-utilisateurs-et-les-droits)  
`adduser <user_login>`  
password: 'roger'  

2. Utilisez sudo pour pouvoir, depuis cet utilisateur, effectuer les operations demamdant des droits speciaux  
`adduser <user_login> sudo`  

(logout -\> login with new user account)  

3. Nous ne voulons pas que vous utilisiez le service DHCP de votre machine. A vous donc de la configurer afin qu'elle ait une IP fixe et un Netmask en /30  

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

\# 10.0.2.15
\# 00001010.00000000.00000010.00001111
\# Etant donne le netmask de /30
\# l'adresse de broadcast est 10.0.2.15
\# l'adresse de reseau est 10.0.2.12
\# on a le choix pour la gateway et l'ip de la machine entre les 2 adresses restantes  

```
auto eth0
iface eth0 inet static
	address 10.0.2.13/30
	gateway 10.0.2.14
```

`sudo init 0`  

VirtualBox -\> Settings -\> Network -\> Attached to :  
	Bridged Adapter  

4. Vous devez changer le port par defaut du service SSH par celui de votre choix. L'acces SSH DOIT se faire avec des publickeys. L'utilisateur root ne doit pas pouvoir se connecter en SSH  

`sudo apt-get update && sudo apt-get -y install openssh-server`  

5. Vous devez mettre en place des regles de pare-feu (firewall) sur le serveur avec uniquement les services utilises accessibles en dehors de votre VM  

[Reference - Reprenez le controle a l'aide de Linux](https://openclassrooms.com/fr/courses/43538-reprenez-le-controle-a-laide-de-linux/42264-analyser-le-reseau-et-filtrer-le-trafic-avec-un-pare-feu#/id/r-42263)  

```
iptables -A INPUT -p tcp --dport 2222 -j ACCEPT
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -P INPUT DROP
```

6. Vous devez mettre en place une protection contre les DOS (Denial Of Service Attack) sur les ports ouverts de votre VM  

fail2ban  

7. Vous devez mettre en place une protection contre les scans sur les ports ouverts de votre VM  

8. Arretez les services dont vous n'avez pas besoin pour ce projet  

9. [Init\_and\_Docker/projet\_Init/scripts/02](https://github.com/HippopoStar/Init_and_Docker/blob/master/projet_Init/scripts/02)  

10. [Init\_and\_Docker/projet\_Init/scripts/04](https://github.com/HippopoStar/Init_and_Docker/blob/master/projet_Init/scripts/04)  

