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
		echo "${CYAN}docker-machine ip Char${END_OF_COLOR}"
		docker-machine ip Char
	fi
fi
