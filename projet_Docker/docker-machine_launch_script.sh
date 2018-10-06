#!/bin/sh
END_OF_COLOR='\033[00m'
BLACK='\033[30m'
RED='\033[31m'
GREEN='\033[32m'
YELLOW='\033[33m'
BLUE='\033[34m'
MAGENTA='\033[35m'
CYAN='\033[36m'
WHITE='\033[37m'

echo "${GREEN}Avez-vous bien lance le programme de la maniere suivante : '${END_OF_COLOR}source ./docker-machine_launch_script.sh${GREEN}' ?${END_OF_COLOR} [y/n]"
YES_OR_NO="$(read -e)"
if test 'xy' = "x${YES_OR_NO}" ; then
	echo "${CYAN}docker-machine ls${END_OF_COLOR}"
	docker-machine ls
	echo "${GREEN}La machine virtuelle '${END_OF_COLOR}Char${GREEN}' figure-t-elle dans la liste et est-elle arretee ?${END_OF_COLOR} [y/n]"
	YES_OR_NO="$(read -e)"
	if test 'xy' = "x${YES_OR_NO}" ; then
		echo "${GREEN}Voulez-vous la lancer ?${END_OF_COLOR} [y/n]"
		YES_OR_NO="$(read -e)"
		if test 'xy' = "x${YES_OR_NO}" ; then
			echo "${CYAN}docker-machine start Char${END_OF_COLOR}"
			docker-machine start Char
		fi
	else
		echo "${GREEN}Est-elle absente ?${END_OF_COLOR} [y/n]"
		YES_OR_NO="$(read -e)"
		if test 'xy' = "x${YES_OR_NO}" ; then
			echo "${GREEN}Voulez-vous la creer ?${END_OF_COLOR} [y/n]"
			YES_OR_NO="$(read -e)"
			if test 'xy' = "x${YES_OR_NO}" ; then
				echo "${CYAN}docker-machine create --driver virtualbox Char${END_OF_COLOR}"
				docker-machine create --driver virtualbox Char
				echo "${CYAN}mv /Users/lcabanes/.docker/machine/machines/Char /sgoinfre/goinfre/Perso/lcabanes/docker-machine_folder/${END_OF_COLOR}"
				mv /Users/lcabanes/.docker/machine/machines/Char /sgoinfre/goinfre/Perso/lcabanes/docker-machine_folder/
				echo "${CYAN}ln -s /sgoinfre/goinfre/Perso/lcabanes/docker-machine_folder/Char /Users/lcabanes/.docker/machine/machines/${END_OF_COLOR}"
				ln -s /sgoinfre/goinfre/Perso/lcabanes/docker-machine_folder/Char /Users/lcabanes/.docker/machine/machines/
				echo "${CYAN}docker-machine ls${END_OF_COLOR}"
				docker-machine ls
				echo "${CYAN}docker volume ls${END_OF_COLOR}"
				docker volume ls
				echo "${GREEN}Voulez-vous creer le volume '${END_OF_COLOR}hatchery${GREEN}' ?${END_OF_COLOR} [y/n]"
				YES_OR_NO="$(read -e)"
				if test 'xy' = "x${YES_OR_NO}" ; then
					echo "${CYAN}docker volume create hatchery${END_OF_COLOR}"
					docker volume create hatchery
				fi
			fi
		fi
	fi
	echo "${GREEN}Voulez-vous (re-)assigner les variables specifiques a la machine virtuelle '${END_OF_COLOR}Char${GREEN}' dans l env du present terminal ?${END_OF_COLOR} [y/n]"
	YES_OR_NO="$(read -e)"
	if test 'xy' = "x${YES_OR_NO}" ; then
		echo "${CYAN}eval \"\$(docker-machine env -u)\"${END_OF_COLOR}"
		eval "$(docker-machine env -u)"
		echo "${CYAN}eval \"\$(docker-machine env Char)\"${END_OF_COLOR}"
		eval "$(docker-machine env Char)"
		echo "${CYAN}env${END_OF_COLOR}"
		env
		echo "${CYAN}ls -la /Users/lcabanes/.docker/machine/machines/${END_OF_COLOR}"
		ls -la /Users/lcabanes/.docker/machine/machines/
		echo "${CYAN}docker-machine ssh Char sudo ls /var/lib/docker/${END_OF_COLOR}"
		docker-machine ssh Char sudo ls /var/lib/docker/
		echo "${CYAN}docker-machine ip Char${END_OF_COLOR}"
		docker-machine ip Char
		echo "${CYAN}docker volume ls${END_OF_COLOR}"
		docker volume ls
		echo "${CYAN}docker node ls${END_OF_COLOR}"
		docker node ls
		echo "${CYAN}docker service ls${END_OF_COLOR}"
		docker service ls
		echo "${GREEN}Voulez-vous forcer l'arret et supprimer l'ensemble des services du swarm local ?${END_OF_COLOR} [y/n]"
		YES_OR_NO="$(read -e)"
		if test 'xy' = "x${YES_OR_NO}" ; then
			echo "${CYAN}docker service rm $(docker service ls | awk 'NR>1 { print $1 }')${END_OF_COLOR}"
			docker service rm $(docker service ls | awk 'NR>1 { print $1 }')
			echo "${CYAN}docker service ls${END_OF_COLOR}"
			docker service ls
		fi
		echo "${CYAN}docker ps -a${END_OF_COLOR}"
		docker ps -a
		echo "${GREEN}Voulez-vous forcer l'arret et supprimer l'ensemble des containers ?${END_OF_COLOR} [y/n]"
		YES_OR_NO="$(read -e)"
		if test 'xy' = "x${YES_OR_NO}" ; then
			echo "${CYAN}docker rm -f $(docker ps -a | awk 'NR>1 { print $1 }')${END_OF_COLOR}"
			docker rm -f $(docker ps -a | awk 'NR>1 { print $1 }')
			echo "${CYAN}docker ps -a${END_OF_COLOR}"
			docker ps -a
		fi
		echo "${CYAN}docker image ls${END_OF_COLOR}"
		docker image ls
		echo "${GREEN}Voulez-vous supprimer l'ensemble des images de container stockee sur la machine virtuelle ${END_OF_COLOR}Char${GREEN} ?${END_OF_COLOR} [y/n]"
		YES_OR_NO="$(read -e)"
		if test 'xy' = "x${YES_OR_NO}" ; then
			echo "${CYAN}docker rmi $(docker image ls | awk 'NR>1 { print $3 }')${END_OF_COLOR}"
			docker rmi $(docker image ls | awk 'NR>1 { print $3 }')
			echo "${CYAN}docker image ls${END_OF_COLOR}"
			docker image ls
		fi
	fi
fi
echo "'CMD' + 'RightClick' https://cdn.intra.42.fr/pdf/pdf/1007/docker.fr.pdf"
